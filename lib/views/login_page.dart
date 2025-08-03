import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logo_app_traning/helper/api_servic.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_snack_bar.dart';
import 'package:logo_app_traning/helper/custom_text_field.dart';

import 'package:logo_app_traning/views/regester_page.dart';
import 'dart:convert';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'loginpage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController(
    text: '050',
  );
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool isArabic = true;
  Future<bool> login() async {
    if (!_formKey.currentState!.validate()) return false;

    setState(() => isLoading = true);

    try {
      final response = await ApiService().loginUser(
        phoneController.text.trim(),
        passwordController.text.trim(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log(data.toString());
        return true;
       
      } else {
        showSnackBar(context, 'فشل تسجيل الدخول: ${response.body}');
        print(response.body);
        return false;
      }
    } catch (e) {
      showSnackBar(context, 'حدث خطأ أثناء تسجيل الدخول');
      print(e);
      return false;
    } finally {
      setState(() => isLoading = false);
    }
  }

  // Future<bool> login() async {
  //   if (!_formKey.currentState!.validate()) return false;

  //   setState(() => isLoading = true);

  //   try {
  //     final response = await ApiService().loginUser(
  //       phoneController.text.trim(),
  //       passwordController.text.trim(),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);

  //       showSnackBar(context, 'تم تسجيل الدخول بنجاح');
  //       return true;
  //     } else {
  //       showSnackBar(context, 'فشل تسجيل الدخول: ${response.body}');
  //       print(response.body);
  //       return false;
  //     }
  //   } catch (e) {
  //     showSnackBar(context, 'حدث خطأ أثناء تسجيل الدخول');
  //     print(e);
  //     return false;
  //   } finally {
  //     setState(() => isLoading = false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 60),
                Text(
                  'Logo',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Alexandria',
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'يرجي ادخال رقم الجوال المسجل لدينا و كلمه المرور',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 30),
                CustomFormTextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  onChanged: (data) {
                    if (!data.startsWith('050')) {
                      phoneController.text = '050';
                      phoneController.selection = TextSelection.fromPosition(
                        TextPosition(offset: phoneController.text.length),
                      );
                    } else if (data.length > 10) {
                      phoneController.text = data.substring(0, 10);
                      phoneController.selection = TextSelection.fromPosition(
                        TextPosition(offset: phoneController.text.length),
                      );
                    }
                  },
                  labelText: 'رقم الجوال',
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'رقم الهاتف مطلوب';
                    }
                    if (!value.startsWith('050')) {
                      return 'رقم الهاتف يجب أن يبدأ بـ 050';
                    }
                    if (value.length != 10) {
                      return 'رقم الهاتف يجب أن يتكون من 10 أرقام';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                CustomFormTextField(
                  controller: passwordController,
                  labelText: 'كلمه المرور',
                  obscureText: true,
                  usePassword: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'كلمة المرور مطلوبة';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "نسيت كلمه المرور ؟",
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "اعاده تعيين",
                        style: TextStyle(
                          color: Color.fromARGB(255, 8, 220, 181),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomButton(
                  size: 250,
                  text: 'تسجيل الدخول',
                  onTap: () async {
                    bool success = await login();
                    if (success) {
                      Navigator.pushNamed(context, 'homeView');
                    }
                    setState(() => isLoading = false);
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ليس لديك حساب بالفعل؟',
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegesterPage.id);
                      },
                      child: Text(
                        'انشاء حساب',
                        style: TextStyle(
                          color: Color.fromARGB(255, 8, 220, 181),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Text(
                  'تخطي الان ',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'العربيه',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isArabic = !isArabic;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: 60,
                        height: 35,
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey, // الخلفية
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: AnimatedAlign(
                          duration: Duration(milliseconds: 300),
                          alignment: isArabic
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          curve: Curves.easeInOut,
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: Colors.black, // لون الزر الدائري
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'English',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
