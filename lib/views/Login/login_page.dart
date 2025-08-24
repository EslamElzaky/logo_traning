import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logo_app_traning/Cubit/translate/translate_cubit.dart';
import 'package:logo_app_traning/generated/l10n.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_text_field.dart';
import 'package:logo_app_traning/views/Login/login_data.dart';
import 'package:logo_app_traning/views/Regester/regester_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'loginpage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // bool isLoading = false;
  // bool isArabic = true;

  LoginData loginData = LoginData();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loginData.isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: loginData.formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(
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
                    S.of(context).login,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    S.of(context).subLogin,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomFormTextField(
                    controller: loginData.phoneController,
                    keyboardType: TextInputType.phone,
                    onChanged: (data) {
                      if (!data.startsWith('05')) {
                        loginData.phoneController.text = '05';
                      }

                      loginData.phoneController.selection =
                          TextSelection.fromPosition(
                            TextPosition(
                              offset: loginData.phoneController.text.length,
                            ),
                          );
                      if (loginData.phoneController.text.length > 10) {
                        loginData.phoneController.text = loginData
                            .phoneController
                            .text
                            .substring(0, 10);
                        loginData.phoneController.selection =
                            TextSelection.fromPosition(
                              TextPosition(
                                offset: loginData.phoneController.text.length,
                              ),
                            );
                      }
                    },
                    labelText: S.of(context).phone_number,
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value!.length >= 3) {
                        String thirdDigit = value[2];
                        log(thirdDigit);
                        if (thirdDigit == '0' || thirdDigit == '2') {
                          return S.of(context).valaidat_num2 + thirdDigit;
                        }
                      }
                      if (value.length < 10) {
                        return S.of(context).valaidat_num1;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomFormTextField(
                    controller: loginData.passwordController,
                    labelText: S.of(context).password,
                    obscureText: true,
                    usePassword: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return S.of(context).req_password;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).forgot_password,
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'forgetPassword');
                        },
                        child: Text(
                          S.of(context).reset_password,
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
                    text: S.of(context).login,
                    onTap: () async {
                      setState(() {
                        loginData.isLoading = true;
                      });
                    await  loginData.login(context);
                      setState(() {
                        loginData.isLoading = false;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).no_account,
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegesterPage.id);
                        },
                        child: Text(
                          S.of(context).create_account,
                          style: TextStyle(
                            color: Color.fromARGB(255, 8, 220, 181),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'homeView');
                    },
                    child: Text(
                      S.of(context).skip,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
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
                            loginData.isArabic = !loginData.isArabic;
                            if (loginData.isArabic) {
                              TranslateCubit.get(
                                context,
                              ).changeLanguage(Locale('ar'));
                            } else {
                              TranslateCubit.get(
                                context,
                              ).changeLanguage(Locale('en'));
                            }
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
                            alignment: loginData.isArabic
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
                  Text('${loginData.isArabic ? 'العربية' : 'English'}'),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
