import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logo_app_traning/helper/api_servic.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_snack_bar.dart';
import 'package:logo_app_traning/helper/custom_text_field.dart';
import 'package:logo_app_traning/model/regester_model.dart';
import 'package:logo_app_traning/views/login_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
        showSnackBar(context, 'كلمة المرور وتأكيد كلمة المرور غير متطابقتين');
        setState(() => isLoading = false);
        return false;
      }

      final response = await ApiService().registerUser(user);

      if (response.statusCode == 200 || response.statusCode == 201) {
        showSnackBar(context, 'تم تسجيل الدخول بنجاح');

        return true;
      } else {
        showSnackBar(context, 'فشل تسجيل الدخول: ${response.body}');
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
                  'إنشاء حساب جديد',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'يرجي ادخال البيانات الاتيه',
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
                  labelText: 'الاسم الاول',
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
                  labelText: 'الاسم الاوسط',
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
                  labelText: 'الاسم الاخير',
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
                      phoneController.selection = TextSelection.fromPosition(
                        TextPosition(offset: phoneController.text.length),
                      );
                    } else if (data.length > 10) {
                      phoneController.text = data.substring(0, 10);
                      phoneController.selection = TextSelection.fromPosition(
                        TextPosition(offset: phoneController.text.length),
                      );
                    } else {
                      userName = data;
                    }
                  },
                  labelText: 'رقم الجوال',
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'رقم الهاتف مطلوب';
                    }
                    if (!value.startsWith('05')) {
                      return 'رقم الهاتف يجب أن يبدأ بـ 05';
                    }
                    if (value.length != 10) {
                      return 'رقم الهاتف يجب أن يتكون من 10 أرقام';
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
                  labelText: 'البريد الالكتروني',
                  validator: (data) {
                    if (data == null || data.trim().isEmpty) {
                      return 'يجب ادخال الايميل';
                    }
                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(data.trim())) {
                      return 'من فضلك ادخل الايميل بشكل صحيح';
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
                  labelText: 'الباسورد',
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
                        passwordError = 'كلمتا المرور غير متطابقتين';
                      });
                    } else {
                      setState(() {
                        passwordError = null;
                      });
                    }
                  },
                  labelText: 'تاكيد الباسورد',
                  obscureText: true,
                  usePassword: true,
                  errorText: passwordError,
                ),
                SizedBox(height: 40),
                CustomButton(
                  size: 200,
                  text: 'انشاء حساب',
                  onTap: () async {
                    bool success = await register();
                    if (success) {
                      await ApiService().regenerateOtp(
                        phoneController.text.trim(),
                      );
                      Navigator.pushNamed(
                        context,
                        'homeView',
                        arguments: phoneController.text.trim(),
                      );
                    }
                    setState(() => isLoading = false);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'لديك حساب بالفعل؟',
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginPage.id);
                      },
                      child: Text(
                        ' تسجيل الدخول',
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
