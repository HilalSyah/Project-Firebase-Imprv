import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final VoidCallback onupdate;
  final VoidCallback onDelete;

  const CustomCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.onupdate,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      color: Colors.blue.shade50, // Latar belakang kartu biru muda
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // Semua elemen di kiri
          children: [
            // Gambar
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: imageUrl.isNotEmpty
                  ? Image.network(
                imageUrl,
                height: 160, // Sesuaikan tinggi gambar
                width: double.infinity,
                fit: BoxFit.fitWidth,
              )
                  : Container(
                height: 80, // Sesuaikan tinggi placeholder
                color: Colors.blue.shade100, // Warna latar belakang placeholder
                child: const Center(
                  child: Icon(Icons.image_not_supported, color: Colors.blueGrey),
                ),
              ),
            ),
            const SizedBox(height: 2.0),
            // Judul dan Harga
            Text(
              title,
              style: const TextStyle(
                fontSize: 14, // Ukuran font lebih kecil
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Warna teks biru
              ),
            ),
            const SizedBox(height: 4.0), // Jarak antara nama dan harga
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 13, // Ukuran font lebih kecil
                color: Colors.blueAccent, // Warna teks harga biru
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3.0), // Jarak antara harga dan deskripsi
            // Deskripsi
            Text(
              description,
              style: const TextStyle(fontSize: 12, color: Colors.blueGrey), // Ukuran font lebih kecil
            ),
            const SizedBox(height: 2.0),

            // Konten utama di atas tombol-tombol
            Expanded(child: Container()), // Memberikan ruang kosong agar tombol berada di bawah

            // Row untuk tombol
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: onupdate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Warna tombol biru
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0), // Padding lebih kecil
                  ),
                  icon: const Icon(Icons.edit, size: 10, color: Colors.white), // Ukuran ikon lebih kecil
                  label: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white, fontSize: 10), // Ukuran font lebih kecil
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: Colors.blue.shade50,
                          title: Row(
                            children: const [
                              Icon(Icons.warning, color: Colors.redAccent),
                              SizedBox(width: 8),
                              Text(
                                'Konfirmasi Hapus',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          content: const Text(
                            'Apakah Anda yakin ingin menghapus tugas ini?',
                            style: TextStyle(color: Colors.black87),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Batal',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                onDelete();
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                elevation: 5.0,
                              ),
                              child: const Text(
                                'Hapus',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                  ),
                  icon: const Icon(Icons.delete, size: 10, color: Colors.white),
                  label: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
