import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logo_app_traning/helper/api_servic.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_snack_bar.dart';
import 'package:logo_app_traning/helper/custom_text_field.dart';
import 'package:logo_app_traning/model/regester_model.dart';
import 'package:logo_app_traning/views/home_view.dart';
import 'package:logo_app_traning/views/login_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegesterPage extends StatefulWidget {
  const RegesterPage({super.key});
  static String id = 'regesterpage';

  @override
  State<RegesterPage> createState() => _RegesterPageState();
}

class _RegesterPageState extends State<RegesterPage> {
  final TextEditingController phoneController = TextEditingController();
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
      confirmPassword;
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
                CostumFormTextField(
                  controller: firstNameController,
                  onChanged: (data) {
                    firstName = data;
                  },
                  labelText: 'الاسم الاول',
                ),
                SizedBox(height: 20),
                CostumFormTextField(
                  controller: middleNameController,
                  onChanged: (data) {
                    midName = data;
                  },
                  labelText: 'الاسم الاوسط',
                ),
                SizedBox(height: 20),
                CostumFormTextField(
                  controller: lastNameController,
                  onChanged: (data) {
                    lastName = data;
                  },
                  labelText: 'الاسم الاخير',
                ),
                SizedBox(height: 20),
                CostumFormTextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  onChanged: (data) {
                    userName = data;
                  },
                  labelText: 'رقم الجوال',
                  maxLength: 10,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'رقم الهاتف مطلوب';
                    }
                    if (value.trim().length != 10) {
                      return 'رقم الهاتف لا يقل عن 10 رقم';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CostumFormTextField(
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
                CostumFormTextField(
                  controller: passwordController,
                  onChanged: (data) {
                    password = data;
                  },
                  labelText: 'الباسورد',
                  obscureText: true,
                  usePassword: true,
                ),
                SizedBox(height: 20),
                CostumFormTextField(
                  controller: confirmPasswordController,
                  onChanged: (data) {
                    confirmPassword = data;
                  },
                  labelText: 'تاكيد الباسورد',
                  obscureText: true,
                  usePassword: true,
                ),
                SizedBox(height: 40),
                CustomButton(
                  size: 200,
                  text: 'انشاء حساب',
                  onTap: () async {
                    bool success = await register();
                    if (success) {
                      Navigator.pushNamed(
                        context,
                        'homeView',
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
