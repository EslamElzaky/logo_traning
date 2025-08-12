import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:logo_app_traning/Cubit/otp_cubit.dart';
import 'package:logo_app_traning/Cubit/otp_state.dart';
import 'package:logo_app_traning/generated/l10n.dart';
import 'package:logo_app_traning/helper/api_servic.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_text_field.dart';
import 'package:offline_captcha/offline_captcha.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});
  static String id = 'resetpassword';
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  final CaptchaController captchaController = CaptchaController(length: 6);
  final TextEditingController captchaInputController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? passwordError, confirmPassword, password;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OtpCubit.get(context).startTimer();
    });

    captchaController.regenerate();
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
            Navigator.pop(context); // بيرجع للصفحة اللي قبلها
          },
        ),
      ),
      body: Form(
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
                CustomFormTextField(labelText: S.of(context).verfy),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).reciev_code,
                      style: TextStyle(color: Color(0xFF24A19B)),
                    ),

                    const SizedBox(width: 5),
                    BlocBuilder<OtpCubit, OtpState>(
                      builder: (context, state) {
                        if (state.controller != null) {
                          return CountdownTimer(
                            controller: state.controller!,
                            onEnd: () {},
                            widgetBuilder: (_, time) {
                              if (time == null) {
                                return InkWell(
                                  onTap: () {
                                    OtpCubit.get(context).resartTimer();
                                    captchaController.regenerate();
                                    ApiService().regenerateOtp(phoneNumber);
                                  },
                                  child: Text(
                                    S.of(context).resend,
                                    style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                );
                              }

                              return Text(
                                "${time.sec?.toString().padLeft(2, '0') ?? '00'}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
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
                  text: S.of(context).login,
                  onTap: () {
                    if (formKey.currentState!.validate()) {}
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
