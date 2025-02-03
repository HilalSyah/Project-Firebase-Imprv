import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/CustomTextFieldHome.dart';
import 'home_controller.dart';

class UpdateScreen extends StatelessWidget {
  final String id;
  final String currentTitle;
  final String currentDescription;
  final String currentImageUrl;
  final double currentPrice;

  UpdateScreen({
    Key? key,
    required this.id,
    required this.currentTitle,
    required this.currentDescription,
    required this.currentImageUrl,
    required this.currentPrice,
  }) : super(key: key);

  final HomeController controller = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final RxString imageUrl = ''.obs;

  @override
  Widget build(BuildContext context) {
    // Initialize controllers with current values
    titleController.text = currentTitle;
    descriptionController.text = currentDescription;
    imageUrlController.text = currentImageUrl;
    priceController.text = currentPrice.toStringAsFixed(2);
    imageUrl.value = currentImageUrl;

    imageUrlController.addListener(() {
      imageUrl.value = imageUrlController.text;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Barang'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Center(
                  child: imageUrl.value.isNotEmpty
                      ? Image.network(
                          imageUrl.value,
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
                )),
            const SizedBox(height: 16.0),
            CustomTextFieldHome(
              controller: titleController,
              labelText: 'Nama Barang',
            ),
            const SizedBox(height: 10),
            CustomTextFieldHome(
              controller: descriptionController,
              labelText: 'Deskripsi',
            ),
            const SizedBox(height: 10),
            CustomTextFieldHome(
              controller: imageUrlController,
              labelText: 'Image URL',
            ),
            const SizedBox(height: 10),
            CustomTextFieldHome(
              controller: priceController,
              keyboardType: TextInputType.number,
              labelText: 'Harga',
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  controller.updateTask(
                    id,
                    titleController.text,
                    descriptionController.text,
                    imageUrlController.text,
                    double.tryParse(priceController.text) ?? 0.0,
                  );
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
                  'Update',
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
