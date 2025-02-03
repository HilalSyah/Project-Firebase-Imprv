import 'package:flutter/material.dart';

class Customlogin extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final String? imagePath;
  final String text;
  final double? imageSize;
  final Color borderColor;

  const Customlogin({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.imagePath,
    this.imageSize = 20.0,
    this.borderColor = Colors.black12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 400;
        final buttonWidth = (constraints.maxWidth > 0)
            ? (isSmallScreen ? constraints.maxWidth * 10 : 209.0)
            : 209.0; // Default jika maxWidth tidak valid
        final buttonHeight = (isSmallScreen ? 45.0 : 50.0);

        return SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor ?? Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: borderColor, width: 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imagePath != null)
                  Image.asset(
                    imagePath ?? '',
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.contain,
                  ),
                SizedBox(width: isSmallScreen ? 10 : 15),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16.0 : 22.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'WorkSans',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}