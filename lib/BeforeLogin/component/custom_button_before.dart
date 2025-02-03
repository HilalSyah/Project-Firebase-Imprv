import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String? imagePath;
  final double textSize;
  final Color textColor;
  final Color backgroundColor;
  final double height;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.imagePath,
    this.textSize = 16.0,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.height = 70.0, // Default height
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
          side: BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
          minimumSize: Size(double.infinity, height),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Image.asset(
                imagePath!,
                height: 30,
                width: 30,
              ),
            if (imagePath != null) SizedBox(width: 10), // Spacing between image and text
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: textSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'WorkSans',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
