
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logo_app_traning/generated/l10n.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_text_field.dart';
import 'package:logo_app_traning/views/Login/login_page.dart';
import 'package:logo_app_traning/views/Regester/regester_data.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegesterPage extends StatefulWidget {
  const RegesterPage({super.key});
  static String id = 'regesterpage';

  @override
  State<RegesterPage> createState() => _RegesterPageState();
}

class _RegesterPageState extends State<RegesterPage> {
  RegesterData regesterData = RegesterData();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: regesterData.isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: regesterData.formKey,
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
                  controller: regesterData.firstNameController,
                  onChanged: (data) {
                    regesterData.firstName = data;
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
                  controller: regesterData.middleNameController,
                  onChanged: (data) {
                    regesterData.midName = data;
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
                  controller: regesterData.lastNameController,
                  onChanged: (data) {
                    regesterData.lastName = data;
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
                  controller: regesterData.phoneController,
                  keyboardType: TextInputType.phone,
                  onChanged: (data) {
                    if (!data.startsWith('05')) {
                      regesterData.phoneController.text = '05';
                    }

                    regesterData.phoneController.selection =
                        TextSelection.fromPosition(
                          TextPosition(
                            offset: regesterData.phoneController.text.length,
                          ),
                        );
                    if (regesterData.phoneController.text.length > 10) {
                      regesterData.phoneController.text = regesterData
                          .phoneController
                          .text
                          .substring(0, 10);
                      regesterData.phoneController.selection =
                          TextSelection.fromPosition(
                            TextPosition(
                              offset: regesterData.phoneController.text.length,
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

                SizedBox(height: 20),
                CustomFormTextField(
                  controller: regesterData.emailController,
                  onChanged: (data) {
                    regesterData.email = data;
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
                  controller: regesterData.passwordController,
                  onChanged: (data) {
                    regesterData.password = data;
                  },
                  labelText: S.of(context).password,
                  obscureText: true,
                  usePassword: true,
                ),
                SizedBox(height: 20),
                CustomFormTextField(
                  controller: regesterData.confirmPasswordController,
                  onChanged: (data) {
                    regesterData.confirmPassword = data;
                    if (regesterData.confirmPassword != regesterData.password) {
                      setState(() {
                        regesterData.passwordError = S.of(context).validat_pass;
                      });
                    } else {
                      setState(() {
                        regesterData.passwordError = null;
                      });
                    }
                  },
                  labelText: S.of(context).confirm_password,
                  obscureText: true,
                  usePassword: true,
                  errorText: regesterData.passwordError,
                ),
                SizedBox(height: 40),
                CustomButton(
                  size: 200,
                  text: S.of(context).create_account,
                  onTap: () async {
                    setState(() {
                      regesterData.isLoading = true;
                    });
                    await regesterData.register(context);
                    setState(() {
                      regesterData.isLoading = false;
                    });
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
