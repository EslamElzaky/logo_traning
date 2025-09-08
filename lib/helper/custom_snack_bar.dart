import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void showSnackBar(String message, Color? color) {
  rootScaffoldMessengerKey.currentState?.clearSnackBars();
  rootScaffoldMessengerKey.currentState?.showSnackBar(
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
