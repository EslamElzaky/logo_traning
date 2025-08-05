import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_text_field.dart';
import 'package:logo_app_traning/helper/api_servic.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  static String id = 'forgetPassword';
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController(
    text: '05',
  );
  void _forgetPassword() async {
    if (!formKey.currentState!.validate()) return;

    try {
      final response = await ApiService().forgetPassword(
        phoneController.text.trim(),
      );

      if (response.statusCode == 200) {
        Navigator.pushNamed(
          context,
          'verfiyPage',
          arguments: phoneController.text.trim(),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل في إرسال رمز التحقق: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('حدث خطأ أثناء إرسال رمز التحقق')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24),
          onPressed: () {
            Navigator.pop(context); // بيرجع للصفحة اللي قبلها
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
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
                  'نسيت كلمه المرور',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontFamily: 'Alexandria',
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'يرجي إدخال رقم الجوال المسجل لدينا',
                  style: TextStyle(
                    fontSize: 14,

                    color: Colors.black,
                    fontFamily: 'Alexandria',
                  ),
                ),
                SizedBox(height: 60),
                CustomFormTextField(
                  hintText: 'يرجي إدخال رقم الجوال المسجل لدينا',
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  onChanged: (data) {
                    if (!data.startsWith('05')) {
                      phoneController.text = '05';
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
                SizedBox(height: 30),
                CustomButton(
                  size: 200,
                  text: 'ارسال',
                  onTap: () {
                    _forgetPassword();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
