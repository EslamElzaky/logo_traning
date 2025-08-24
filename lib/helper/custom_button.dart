import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.color = Colors.black,
    this.colorText = Colors.white,
    required this.size,
    required this.text,
    this.onTap,
    this.isLoding = false,
  });
  final String text;
  final Color color;
  final Color colorText;
  final double size;
  final VoidCallback? onTap;
  final bool isLoding;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black),
        ),
        width: size,
        height: 55,
        child: Center(
          child:
              //  isLoding
              //     ? CircularProgressIndicator(color: Colors.black)
              Text(text, style: TextStyle(color: colorText, fontSize: 20)),
        ),
      ),
    );
  }
}
