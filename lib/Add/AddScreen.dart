import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AddController.dart';
import 'components/CustomTextFieldAdd.dart';

class AddScreen extends StatelessWidget {
  AddScreen({Key? key}) : super(key: key);

  final AddController controller = Get.put(AddController()); // Inisialisasi controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambahkan Barang'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan gambar jika URL ada, tanpa menggunakan Obx
            Center(
              child: controller.imageUrlController.text.isNotEmpty
                  ? Image.network(
                controller.imageUrlController.text,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(child: Text('No Image')),
                  );
                },
              )
                  : Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(child: Text('No Image')),
              ),
            ),
            const SizedBox(height: 16.0),

            // Input field untuk Nama Barang
            CustomTextFieldAdd(
              controller: controller.titleController,
              labelText: 'Nama Barang',
            ),
            const SizedBox(height: 10),

            // Input field untuk Deskripsi
            CustomTextFieldAdd(
              controller: controller.descriptionController,
              labelText: 'Deskripsi',
            ),
            const SizedBox(height: 10),

            // Input field untuk Image URL
            CustomTextFieldAdd(
              controller: controller.imageUrlController,
              labelText: 'Image URL',
            ),
            const SizedBox(height: 10),

            // Input field untuk Harga
            CustomTextFieldAdd(
              controller: controller.priceController,
              keyboardType: TextInputType.number,
              labelText: 'Harga',
            ),
            const SizedBox(height: 20),

            // Tombol untuk menambahkan task
            Center(
              child: ElevatedButton(
                onPressed: () {
                  controller.addTask(); // Panggil addTask dari controller
                  Get.back(); // Kembali ke layar sebelumnya
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
