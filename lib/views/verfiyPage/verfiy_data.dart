import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logo_app_traning/helper/api_servic.dart';
import 'package:logo_app_traning/helper/custom_snack_bar.dart';
import 'package:offline_captcha/offline_captcha.dart';

class VerfiyData {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController captchaInputController = TextEditingController();

  final CaptchaController captchaController = CaptchaController(length: 6);

 Future <void> onVerifyPressed(BuildContext context) async {

   if (!formKey.currentState!.validate()) {
      return;
    }
    final input = captchaInputController.text.trim();
    final otpCode = pinController.text.trim();

    bool isValidCaptcha = captchaController.validate(input);
    if (!isValidCaptcha) {
      showSnackBar('الكابتشا غير صحيحة', Colors.red);
      return;
    }
    if (otpCode.length != 6) {
      showSnackBar('من فضلك أدخل رمز التحقق الكامل', Colors.yellow);
      return;
    }
    // final phoneNumber = ModalRoute.of(context)!.settings.arguments as String;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final phoneNumber = args["phoneNumber"]?.toString() ?? "";
    final password = args["password"]?.toString() ?? "";
    final userId = args["userId"]?.toString() ?? "";
    log(
      "Phone: $phoneNumber, Password: $password, UserId: $userId, OTP: $otpCode",
    );
    try {
      final response = await ApiService().verifyOtp(
        phoneNumber,
        otpCode,
        password,
        userId,
      );
      log('OTP status${response.statusCode}');
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSnackBar('تم التحقق بنجاح', Colors.green);
        Navigator.pushReplacementNamed(context, 'homeView');
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        showSnackBar(
          ' فشل التحقق: ${data["message"] ?? "حدث خطأ"}',
          Colors.red,
        );
      } else {
        showSnackBar(' فشل الاتصال: ${response.statusCode}', Colors.orange);
      }
    } catch (e) {
      showSnackBar(' خطأ أثناء التحقق: $e', Colors.deepOrangeAccent);
    }
  }
}
