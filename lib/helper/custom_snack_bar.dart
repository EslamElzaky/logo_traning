import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, Color? color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: color,
    ),
  );
}
