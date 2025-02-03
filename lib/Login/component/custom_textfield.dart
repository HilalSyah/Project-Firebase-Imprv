import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText; // Teks di atas input field
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final IconData? prefixIcon;

  const CustomTextField({
    Key? key,
    required this.labelText, // Teks di atas input field
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    this.prefixIcon,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscureText;

  @override
  void initState() {
    super.initState();
    _isObscureText = widget.obscureText;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Agar teks rata kiri
      children: [
        Text(
          widget.labelText, // Menampilkan teks di atas input field
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'WorkSans',
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8), // Jarak antara teks dan input field
        TextField(
          controller: widget.controller,
          obscureText: _isObscureText,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
            suffixIcon: widget.labelText.toLowerCase().contains("password")
                ? IconButton(
              icon: Icon(
                _isObscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: _togglePasswordVisibility,
            )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
        SizedBox(height: 16), // Jarak bawah setelah input field
      ],
    );
  }
}
