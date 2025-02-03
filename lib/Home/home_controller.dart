import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final tasksCollection = FirebaseFirestore.instance.collection('tasks');

  // Stream untuk mendapatkan data dari Firestore
  Stream<QuerySnapshot> get tasksStream => tasksCollection.snapshots();

  // Perbarui data di Firestore
  void updateTask(
      String id, String title, String description, String imageUrl, double price) {
    tasksCollection.doc(id).update({
      'title': title.isEmpty ? 'Untitled' : title,
      'description': description.isEmpty ? 'No description' : description,
      'imageUrl': imageUrl.isEmpty ? '' : imageUrl,
      'price': price, // Tambahkan price ke dalam data
    });
  }


  // Hapus data dari Firestore
  void deleteTask(String id) {
    tasksCollection.doc(id).delete();
  }
}