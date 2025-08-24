import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logo_app_traning/Cubit/otp_cubit.dart';
import 'package:logo_app_traning/Cubit/translate/translate_cubit.dart';
import 'package:logo_app_traning/generated/l10n.dart';
import 'package:logo_app_traning/helper/custom_snack_bar.dart';
import 'package:logo_app_traning/views/ForgetPassword/forget_password.dart';
import 'package:logo_app_traning/views/home_view.dart';
import 'package:logo_app_traning/views/Login/login_page.dart';
import 'package:logo_app_traning/views/page_service_houre.dart';
import 'package:logo_app_traning/views/Regester/regester_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logo_app_traning/views/ResetPassword/reset_password.dart';
import 'package:logo_app_traning/views/verfiyPage/verfiy_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OtpCubit()),
        BlocProvider(create: (context) => TranslateCubit()),
      ],

      child: BlocBuilder<TranslateCubit, TranslateState>(
        builder: (context, state) {
          return MaterialApp(
              scaffoldMessengerKey: rootScaffoldMessengerKey,
            theme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: 'Poppins',
            ),
            debugShowCheckedModeBanner: false,
            locale: state.appLocale,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,

            routes: {
              'regesterpage': (context) => RegesterPage(),
              'loginpage': (context) => LoginPage(),
              'homeView': (context) => HomeView(),
              'verfiyPage': (context) => VerfiyPage(),
              'forgetPassword': (context) => ForgetPassword(),
              'resetpassword': (context) => ResetPassword(),
              'serviceHoure': (context) => ServiceHoure(),
            },
            initialRoute: LoginPage.id,
          );
        },
      ),
    );
  }
}
