
import 'package:flutter/material.dart';
import 'package:logo_app_traning/generated/l10n.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_text_field.dart';
import 'package:logo_app_traning/views/ResetPassword/reset_page_data.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});
  static String id = 'resetpassword';
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  ResetData resetData = ResetData();
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
        inAsyncCall: resetData.isLoading,
        child: Form(
          key: resetData.formKey,
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
                    controller: resetData.codeController,
                  ),
                  SizedBox(height: 20),

                  CustomFormTextField(
                    controller: resetData.passwordController,
                    onChanged: (data) {
                      resetData.password = data;
                    },
                    labelText: S.of(context).new_pass,
                    obscureText: true,
                    usePassword: true,
                  ),
                  SizedBox(height: 20),
                  CustomFormTextField(
                    controller: resetData.confirmPasswordController,
                    onChanged: (data) {
                      resetData.confirmPassword = data;
                      if (resetData.confirmPassword != resetData.password) {
                        setState(() {
                          resetData.passwordError = S.of(context).validat_pass;
                        });
                      } else {
                        setState(() {
                          resetData.passwordError = null;
                        });
                      }
                    },
                    labelText: S.of(context).conf_new_pass,
                    obscureText: true,
                    usePassword: true,
                    errorText: resetData.passwordError,
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                    size: 200,
                    text: S.of(context).send,
                    onTap: () async {
                      setState(() {
                        resetData.isLoading = true;
                      });
                   await  resetData. resetPassword(context);
                       setState(() {
                        resetData.isLoading = true;
                      });
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
