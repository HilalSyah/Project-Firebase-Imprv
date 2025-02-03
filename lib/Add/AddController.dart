import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final tasksCollection = FirebaseFirestore.instance.collection('tasks');

  // Fungsi untuk menambahkan task ke Firestore
  void addTask() {
    final title = titleController.text.isEmpty ? 'Untitled' : titleController.text;
    final description = descriptionController.text.isEmpty ? 'No description' : descriptionController.text;
    final imageUrl = imageUrlController.text.isEmpty ? '' : imageUrlController.text;
    final price = double.tryParse(priceController.text) ?? 0.0;

    // Menambahkan task ke Firestore
    tasksCollection.add({
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
    }).then((value) {
      print("Task Added: ${value.id}");
      clearFields(); // Setelah task berhasil ditambahkan, kita bersihkan field input
    }).catchError((error) {
      print("Failed to add task: $error");
    });
  }

  // Fungsi untuk membersihkan input fields
  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    imageUrlController.clear();
    priceController.clear();
  }
}
