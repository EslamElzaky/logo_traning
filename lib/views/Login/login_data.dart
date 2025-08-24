import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logo_app_traning/helper/api_servic.dart';
import 'package:logo_app_traning/helper/custom_snack_bar.dart';

class LoginData {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isArabic = true;
  final TextEditingController phoneController = TextEditingController(
    text: '05',
  );
  final TextEditingController passwordController = TextEditingController();

  Future<bool> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return false;

    try {
      final response = await ApiService().loginUser(
        phoneController.text.trim(),
        passwordController.text.trim(),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final user = data['data']['user'];
        final userId = data["userId"];

        final isVerified = user['phoneNumberConfirmed'] == true;

        debugPrint('🔍 phoneNumberConfirmed: ${user['phoneNumberConfirmed']}');

        log('✅ تسجيل الدخول ناجح. isVerified = $isVerified');
        if (!isVerified) {
          await ApiService().regenerateOtp(phoneController.text.trim());
          // المستخدم لم يؤكد الرقم → صفحة التحقق
          Navigator.pushReplacementNamed(
            context,
            'verfiyPage',
            arguments: {
              "phoneNumber": phoneController.text.trim(),
              "password": passwordController.text.trim(),
              "userId": userId,
            },
          );
          showSnackBar(
            data["message"] ?? 'تم تسجيل الدخول بنجاح',
            Colors.greenAccent,
          );
        } else {
          // المستخدم مفعل → صفحة الهوم
          Navigator.pushReplacementNamed(context, 'homeView');
        }

        return true;
      } else {
        showSnackBar(data["message"] ?? 'فشل تسجيل  الدخول', Colors.red);
        return false;
      }
    } catch (e) {
      showSnackBar('حدث خطأ أثناء تسجيل الدخول', Colors.orange);
      print(e);
      return false;
    } finally {}
  }
}
