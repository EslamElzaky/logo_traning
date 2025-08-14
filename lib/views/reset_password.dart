import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:logo_app_traning/Cubit/otp_cubit.dart';
import 'package:logo_app_traning/Cubit/otp_state.dart';
import 'package:logo_app_traning/generated/l10n.dart';
import 'package:logo_app_traning/helper/api_servic.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_snack_bar.dart';
import 'package:logo_app_traning/helper/custom_text_field.dart';
import 'package:logo_app_traning/views/login_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:offline_captcha/offline_captcha.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});
  static String id = 'resetpassword';
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController codeController = TextEditingController();
  String? passwordError, confirmPassword, password;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
    
      showSnackBar(
        context,
        'كلمة المرور وتأكيد كلمة المرور غير متطابقتين',
        Colors.yellow,
      );
      setState(() => isLoading = false);
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await ApiService().resetPssword(
        codeController.text.trim(),
        passwordController.text.trim(),
        confirmPasswordController.text.trim(),
      );

      if (response.statusCode == 200) {
        showSnackBar(context, "تم تغيير كلمة المرور بنجاح", Colors.green);

        Navigator.pushReplacementNamed(context, LoginPage.id);
      } else {
        final data = jsonDecode(response.body);
        showSnackBar(
          context,
          data['message'] ?? "حصل خطأ أثناء تغيير كلمة المرور",
          Colors.orangeAccent,
        );
      }
    } catch (e) {
      showSnackBar(context, "خطأ في الاتصال بالسيرفر: $e", Colors.orange[50]);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String phoneNumber =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Logo',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Alexandria',
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    S.of(context).page_new_pass,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Alexandria',
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).sent_code,
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(phoneNumber, style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 30),
                  CustomFormTextField(
                    labelText: S.of(context).verfy,
                    controller: codeController,
                  ),
                  SizedBox(height: 20),

                  CustomFormTextField(
                    controller: passwordController,
                    onChanged: (data) {
                      password = data;
                    },
                    labelText: S.of(context).new_pass,
                    obscureText: true,
                    usePassword: true,
                  ),
                  SizedBox(height: 20),
                  CustomFormTextField(
                    controller: confirmPasswordController,
                    onChanged: (data) {
                      confirmPassword = data;
                      if (confirmPassword != password) {
                        setState(() {
                          passwordError = S.of(context).validat_pass;
                        });
                      } else {
                        setState(() {
                          passwordError = null;
                        });
                      }
                    },
                    labelText: S.of(context).conf_new_pass,
                    obscureText: true,
                    usePassword: true,
                    errorText: passwordError,
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                    size: 200,
                    text: S.of(context).send,
                    onTap: () {
                      resetPassword();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
