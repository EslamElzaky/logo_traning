import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logo_app_traning/helper/api_servic.dart';
import 'package:logo_app_traning/helper/custom_snack_bar.dart';
import 'package:logo_app_traning/model/login_model.dart';
import 'package:logo_app_traning/model/regester_model.dart';

class RegesterData {
   final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  
   final TextEditingController phoneController = TextEditingController(
    text: '05',
  );
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
        String? email,
      userName,
      city,
      password,
      firstName,
      midName,
      lastName,
      confirmPassword,
      passwordError;


  Future<bool> register(BuildContext context) async {
    if (formKey.currentState!.validate()) {
     
      SignUpUserPost user = SignUpUserPost(
        firstName: firstNameController.text,
        middleName: middleNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        userName: phoneController.text.trim(),
      );
      if (passwordController.text != confirmPasswordController.text) {
        showSnackBar(
         
          'كلمة المرور وتأكيد كلمة المرور غير متطابقتين',
          Colors.yellow,
        );
        
        return false;
      }

      final response = await ApiService().registerUser(user);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Regester regester = Regester.fromJson(jsonDecode(response.body));
        log('user name : ${regester.data!.userId ?? 'mmmnc'}');
        String? userName = regester.data!.userId;
        showSnackBar( 'تم تسجيل حساب جديد بنجاح', Colors.green);
        // await ApiService().regenerateOtp(phoneController.text.trim());
        Navigator.pushNamed(
          context,
          'verfiyPage',
          arguments: {
            "phoneNumber": phoneController.text.trim(),
            "password": passwordController.text.trim(),
            "userId": userName,
          },
        );

        return true;
      } else {
        showSnackBar(
          
          data["message"] ?? 'فشل تسجيل حساب جديد',
          Colors.red,
        );
        return false;
      }
    }
    return false;
  }
}