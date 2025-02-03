import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String imagePath; // Path for the image
  final double textSize; // Parameter for text size

  const ReusableButton({
    required this.text,
    required this.onPressed,
    required this.imagePath, // Path for the image
    this.textSize = 16.0, // Default text size
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: EdgeInsets.symmetric(vertical: 15), // Adjust padding
          minimumSize: Size(double.infinity, 70), // Set the height to 70
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 30, // Image size adjustment
              width: 30,  // Image size adjustment
            ),
            SizedBox(width: 10), // Spacing between image and text
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: textSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'WorkSans', // Use WorkSans font
              ),
            ),
          ],
        ),
      ),
    );
  }
}

