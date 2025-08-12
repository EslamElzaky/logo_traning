import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.size,
    this.color = Colors.black,
    required this.text,
    this.onTap,
    this.isLoding = false,
  });
  final String text;
  final Color color;
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
        ),
        width: size,
        height: 55,
        child: Center(
          child: isLoding
              ? CircularProgressIndicator(color: Colors.black)
              : Text(text, style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
    );
  }
}
