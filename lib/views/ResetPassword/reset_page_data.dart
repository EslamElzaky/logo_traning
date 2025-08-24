import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logo_app_traning/helper/api_servic.dart';
import 'package:logo_app_traning/helper/custom_snack_bar.dart';
import 'package:logo_app_traning/views/Login/login_page.dart';

class ResetData {

   final formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  String? passwordError, confirmPassword, password;
  bool isLoading = false;

  Future<void> resetPassword(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      showSnackBar(
       
        'كلمة المرور وتأكيد كلمة المرور غير متطابقتين',
        Colors.yellow,
      );
  
      return;
    }

    

    try {
      final response = await ApiService().resetPssword(
        codeController.text.trim(),
        passwordController.text.trim(),
        confirmPasswordController.text.trim(),
        phoneNumber.text.trim(),
      );

      if (response.statusCode == 200) {
        showSnackBar( "تم تغيير كلمة المرور بنجاح", Colors.green);

        Navigator.pushReplacementNamed(context, LoginPage.id);
      } else {
        final data = jsonDecode(response.body);
        showSnackBar(
          
          data['message'] ?? "حصل خطأ أثناء تغيير كلمة المرور",
          Colors.orangeAccent,
        );
      }
    } catch (e) {
      showSnackBar( "خطأ في الاتصال بالسيرفر: $e", Colors.orange[50]);
    }
  }
}