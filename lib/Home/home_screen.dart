import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'card/CustomCard.dart';
import 'home_controller.dart';
import 'update_screen.dart';
import '../Add/AddScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Toko',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.0, // Mengubah ukuran teks
            color: Colors.white, // Mengubah warna teks
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.blue),
        ),
        elevation: 10.0, // Menambahkan efek bayangan
      ),
      body: Padding(
        padding:
        const EdgeInsets.all(8.0), // Tambahkan padding di sekitar ListView
        child: StreamBuilder<QuerySnapshot>(
          stream: controller.tasksStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final tasks = snapshot.data!.docs;

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Dua kartu per baris
                childAspectRatio:
                0.7, // Rasio aspek untuk menyesuaikan tinggi kartu
                crossAxisSpacing: 8.0, // Spasi antar kolom
                mainAxisSpacing: 8.0, // Spasi antar baris
              ),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                final data = task.data() as Map<String, dynamic>;

                // Log nilai price sebelum konversi
                print('Price from data: ${data['price']}');

                // Konversi price dari String ke double
                final price = double.tryParse(data['price'].toString()) ?? 0.0;

                // Log nilai price setelah konversi
                print('Converted price: $price');

                return CustomCard(
                  imageUrl: data['imageUrl'] ?? '',
                  title: data['title'] ?? 'No Title',
                  description: data['description'] ?? 'No Description',
                  price: price,
                  onupdate: () {
                    Get.to(() => UpdateScreen(
                      id: task.id,
                      currentTitle: data['title'] ?? '',
                      currentDescription: data['description'] ?? '',
                      currentImageUrl: data['imageUrl'] ?? '',
                      currentPrice: price,
                    ));
                  },
                  onDelete: () {
                    controller.deleteTask(task.id);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
