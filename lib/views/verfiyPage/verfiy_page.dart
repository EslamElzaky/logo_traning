import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logo_app_traning/Cubit/otp_cubit.dart';
import 'package:logo_app_traning/Cubit/otp_state.dart';
import 'package:logo_app_traning/generated/l10n.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_text_field.dart';
import 'package:logo_app_traning/views/verfiyPage/verfiy_data.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:offline_captcha/offline_captcha.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:logo_app_traning/helper/api_servic.dart';
import 'dart:ui';

class VerfiyPage extends StatefulWidget {
  const VerfiyPage({super.key});
  static String id = 'verfiyPage';
  @override
  State<VerfiyPage> createState() => _VerfiyPageState();
}

class _VerfiyPageState extends State<VerfiyPage> {
 

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OtpCubit.get(context).startTimer();
    });
   verfiyData. captchaController.regenerate();
  }

  @override
  void dispose() {
   verfiyData. pinController.dispose();
   verfiyData. captchaInputController.dispose();
    super.dispose();
    if (!mounted) return;
  }

VerfiyData verfiyData=VerfiyData();
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final phoneNumber = args["phoneNumber"];

    // final String phoneNumber =
    //     ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ModalProgressHUD(
          inAsyncCall: verfiyData.isLoading,
          child: Form(
            key: verfiyData.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Logo",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Alexandria',
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      S.of(context).verfiy_number,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).sent_code,
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(phoneNumber, style: TextStyle(color: Colors.black)),
                        Text(
                          S.of(context).change,
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: PinCodeTextField(
                        textStyle: TextStyle(color: Colors.black),
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        appContext: context,
                        length: 6,
                        controller:verfiyData.pinController,
                        keyboardType: TextInputType.number,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeColor: Colors.black,
                          selectedColor: Colors.blue,
                          inactiveColor: Colors.grey,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        onChanged: (value) {},
                        onCompleted: (value) {
                          print("رمز التحقق: $value");
                        },
                      ),
                    ),
            
                    const SizedBox(height: 10),
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
                            log(
                              'controller: ${state.controller}, isRunning: ${state.controller?.isRunning}',
                            );
            
                            if (state.controller != null) {
                              return CountdownTimer(
                                controller: state.controller!,
                                onEnd: () {
                                  log('Timer ended');
                                },
                                widgetBuilder: (_, time) {
                                  if (time == null) {
                                    return InkWell(
                                      onTap: () {
                                        log('Resend OTP tapped');
                                        OtpCubit.get(context).resartTimer();
                                       verfiyData. captchaController.regenerate();
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
                    const SizedBox(height: 20),
            
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CaptchaWidget(
                          width: 240,
                          controller: verfiyData. captchaController,
                          theme: CaptchaTheme(
                            scribbleIntensity: 2.0,
                            scribbleColors: [
                              Colors.red.withOpacity(0.8),
                              Colors.blue.withOpacity(0.9),
                              Colors.black.withOpacity(0.5),
                            ],
                            numberColor: Colors.black87.withValues(alpha: .5),
                            fontSize: 28,
                            backgroundColor: Colors.blueGrey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                         
                          ),
                          
                        ),
            
                        IconButton(
                          icon: const Icon(Icons.refresh, color: Colors.black),
                          onPressed: () {
                            setState(() {
                             verfiyData. captchaController.regenerate();
                             verfiyData. captchaInputController.clear();
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    CustomFormTextField(
                      controller:verfiyData. captchaInputController,
                      labelText: S.of(context).capatcha_label,
                    ),
            
                    const SizedBox(height: 20),
            
                    CustomButton(
                      size: 150,
                      text: S.of(context).verfiy_code,
                      onTap: () {
                        verfiyData. onVerifyPressed(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
