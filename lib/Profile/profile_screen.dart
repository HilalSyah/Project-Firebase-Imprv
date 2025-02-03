import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_firebase/Profile/profile_controller.dart';
import '../Service/Auth.dart';
import 'editprofile_screen.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileControllerFB controller = Get.find();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    controller.fetchProfile();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        elevation: 12.0, // Menambahkan efek bayangan
        // Hapus bagian leading untuk menghilangkan ikon
      ),
      body: Container(
        color: const Color(0xFFE3F2FD), // Latar belakang biru muda
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: const Color(0xFF90CAF9), // Warna biru muda
              child: ClipOval(
                child: Image.network(
                  'https://lh3.googleusercontent.com/a/ACg8ocLylh-sIPWkQSbiczNeX_wCeeq-nz8BT19T2lh2LFhL0pg7qQ=s96-c',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 8,
              color: const Color.fromARGB(255, 211, 231, 247), // Warna kartu biru muda
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person, color: Color(0xFF42A5F5)), // Warna ikon biru
                      title: const Text(
                        'Nama Lengkap',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0), // Warna teks biru
                        ),
                      ),
                      subtitle: Obx(() => Text(
                        controller.name.value,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      )),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.email, color: Color(0xFF42A5F5)), // Warna ikon biru
                      title: const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0), // Warna teks biru
                        ),
                      ),
                      subtitle: Obx(() => Text(
                        controller.email.value,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => EditProfilePage());
                },
                child: const Text(
                  'Edit Profil',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Menambahkan warna teks putih
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF42A5F5), // Warna tombol biru
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5, // Menambahkan efek bayangan
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => _authService.signOut(),
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white, // Warna ikon putih
                ),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Warna teks putih
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent, // Warna tombol merah untuk kontras
                  foregroundColor: Colors.white, // Warna teks dan ikon putih
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5, // Menambahkan efek bayangan
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
