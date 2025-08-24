import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void showSnackBar(String message, Color? color ) {
  rootScaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: color,
    ),
  );
}
