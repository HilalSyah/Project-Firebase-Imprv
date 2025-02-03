import 'package:flutter/material.dart';

class CustomRichTextButton extends StatelessWidget {
  final String firstText;
  final String secondText;
  final VoidCallback onPressed;
  final Color? firstTextColor;
  final Color? secondTextColor;
  final double? fontSize;

  const CustomRichTextButton({
    Key? key,
    required this.firstText,
    required this.secondText,
    required this.onPressed,
    this.firstTextColor,
    this.secondTextColor,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: firstText,
              style: TextStyle(
                  color: firstTextColor ?? Colors.grey[600],
                  fontSize: fontSize,
                  fontFamily: 'WorkSans'
              ),
            ),
            TextSpan(
              text: secondText,
              style: TextStyle(
                  color: secondTextColor ?? Colors.blue,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'WorkSans'
              ),
            ),
          ],
        ),
      ),
    );
  }
}