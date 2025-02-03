import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileControllerFB extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var profilePicture = ''.obs; 

  void updateProfile(String newName, String newEmail, String newPassword, String newProfilePicture) {
    name.value = newName;
    email.value = newEmail;
    password.value = newPassword;
    profilePicture.value = newProfilePicture; 
  }

  Future<void> fetchProfile() async {
  try {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc('I9GR2FBoOiOwC4ELXK3nMa1QYq52');

    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      name.value = doc['displayName'] ?? '';
      email.value = doc['email'] ?? '';
      profilePicture.value = doc['profilePicture'] ?? '';
    } else {
      print('Document does not exist');
    }
  } catch (e) {
    print("Failed to fetch profile: $e");
  }
}

}
