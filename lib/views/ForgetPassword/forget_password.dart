import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logo_app_traning/generated/l10n.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_text_field.dart';
import 'package:logo_app_traning/views/ForgetPassword/forget_data.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  static String id = 'forgetPassword';
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  ForgetData forgetData = ForgetData();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
       inAsyncCall: forgetData.isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black, size: 24),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: forgetData.formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  SizedBox(height: 100),
                  Text(
                    S.of(context).forget_pass,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontFamily: 'Alexandria',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    S.of(context).regster_num,
                    style: TextStyle(
                      fontSize: 14,
        
                      color: Colors.black,
                      fontFamily: 'Alexandria',
                    ),
                  ),
                  SizedBox(height: 60),
                  CustomFormTextField(
                    controller: forgetData.phoneController,
                    keyboardType: TextInputType.phone,
                    onChanged: (data) {
                      if (!data.startsWith('05')) {
                        forgetData.phoneController.text = '05';
                      }
        
                      forgetData.phoneController.selection =
                          TextSelection.fromPosition(
                            TextPosition(
                              offset: forgetData.phoneController.text.length,
                            ),
                          );
                      if (forgetData.phoneController.text.length > 10) {
                        forgetData.phoneController.text = forgetData
                            .phoneController
                            .text
                            .substring(0, 10);
                        forgetData.phoneController.selection =
                            TextSelection.fromPosition(
                              TextPosition(
                                offset: forgetData.phoneController.text.length,
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
                  SizedBox(height: 30),
                  CustomButton(
                    size: 200,
                    text: S.of(context).send,
                    onTap: () async {
                      setState(() {
                        forgetData.isLoading = true;
                      });
                      await forgetData.forgetPassword(context);
                      setState(() {
                        forgetData.isLoading = false;
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
