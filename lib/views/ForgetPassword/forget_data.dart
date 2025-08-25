import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logo_app_traning/helper/api_servic.dart';
import 'package:logo_app_traning/helper/custom_snack_bar.dart';

class ForgetData {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController(
    text: '05',
  );
  Future<void> forgetPassword(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    try {
      final response = await ApiService().forgetPassword(
        phoneController.text.trim(),
      );
  
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        showSnackBar(
          data["message"] ?? 'تم ارسال كود التحقق بنجاح',
          Colors.green,
        );
        Navigator.pushNamed(
          context,
          'resetpassword',
          arguments: phoneController.text.trim(),
        );
      } else {
        showSnackBar(
          data["message"] ?? 'فشل في إرسال رمز التحقق',
          Colors.amber,
        );
      }
    } catch (e) {
  
      showSnackBar('فشل في إرسال رمز التحقق', Colors.redAccent);
    } finally {}
  }
}
