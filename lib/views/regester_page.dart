import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logo_app_traning/generated/l10n.dart';
import 'package:logo_app_traning/helper/api_servic.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_snack_bar.dart';
import 'package:logo_app_traning/helper/custom_text_field.dart';
import 'package:logo_app_traning/model/regester_model.dart';
import 'package:logo_app_traning/views/login_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:convert';


class RegesterPage extends StatefulWidget {
  const RegesterPage({super.key});
  static String id = 'regesterpage';

  @override
  State<RegesterPage> createState() => _RegesterPageState();
}

class _RegesterPageState extends State<RegesterPage> {
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
  bool isLoading = false;

  Future<bool> register() async {
    if (formkey.currentState!.validate()) {
      setState(() => isLoading = true);
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
        showSnackBar(context, 'كلمة المرور وتأكيد كلمة المرور غير متطابقتين', Colors.yellow);
        setState(() => isLoading = false);
        return false;
      }

      final response = await ApiService().registerUser(user);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        showSnackBar(context, 'تم تسجيل الدخول بنجاح', Colors.green);
        await ApiService().regenerateOtp(phoneController.text.trim());
        Navigator.pushNamed(
          context,
          'verfiyPage',
          arguments: phoneController.text.trim(),
        );

        return true;
      } else {
        showSnackBar(context, data["message"]??'فشل تسجيل الدخول', Colors.red);
        return false;
      }
    }
    return false;
  }

  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
            child: Column(
              children: [
                Text(
                  'Logo',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Alexandria',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  S.of(context).title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  S.of(context).subtitle,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                SizedBox(height: 20),
                CustomFormTextField(
                  controller: firstNameController,
                  onChanged: (data) {
                    firstName = data;
                  },
                  labelText: S.of(context).first_name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z\u0621-\u064A\s]'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomFormTextField(
                  controller: middleNameController,
                  onChanged: (data) {
                    midName = data;
                  },
                  labelText: S.of(context).middle_name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z\u0621-\u064A\s]'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomFormTextField(
                  controller: lastNameController,
                  onChanged: (data) {
                    lastName = data;
                  },
                  labelText: S.of(context).last_name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z\u0621-\u064A\s]'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
               CustomFormTextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    onChanged: (data) {
                      if (!data.startsWith('05')) {
                        phoneController.text = '05';
                      }
                     
                      phoneController.selection = TextSelection.fromPosition(
                        TextPosition(offset: phoneController.text.length),
                      );
                      if (phoneController.text.length > 10) {
                        phoneController.text = phoneController.text.substring(
                          0,
                          10,
                        );
                        phoneController.selection = TextSelection.fromPosition(
                          TextPosition(offset: phoneController.text.length),
                        );
                      }
                    },
                    labelText: S.of(context).phone_number,
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                  
                      if (value!.length >= 3) {
                        String thirdDigit = value[2];
                        if (thirdDigit == '0' || thirdDigit == '2') {
                          return S.of(context).valaidat_num2 +thirdDigit;
                        }
                      }
                      if (value.length < 10) {
                        return S.of(context).valaidat_num1;
                      }
                      return null;
                    },
                  ),

                SizedBox(height: 20),
                CustomFormTextField(
                  controller: emailController,
                  onChanged: (data) {
                    email = data;
                  },
                  labelText: S.of(context).email,
                  validator: (data) {
                    if (data == null || data.trim().isEmpty) {
                      return S.of(context).enter_email;
                    }
                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(data.trim())) {
                      return S.of(context).correct_email;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomFormTextField(
                  controller: passwordController,
                  onChanged: (data) {
                    password = data;
                  },
                  labelText: S.of(context).password,
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
                  labelText: S.of(context).confirm_password,
                  obscureText: true,
                  usePassword: true,
                  errorText: passwordError,
                ),
                SizedBox(height: 40),
                CustomButton(
                  size: 200,
                  text: S.of(context).create_account,
                  onTap: () async {
                    await register();
                   
                    setState(() => isLoading = false);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).already_have_account,
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginPage.id);
                      },
                      child: Text(
                        S.of(context).login,
                        style: TextStyle(
                          color: Color.fromARGB(255, 8, 220, 181),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
