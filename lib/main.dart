import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logo_app_traning/Cubit/otp_cubit.dart';
import 'package:logo_app_traning/views/home_view.dart';
import 'package:logo_app_traning/views/login_page.dart';
import 'package:logo_app_traning/views/regester_page.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logo_app_traning/views/verfiy_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(),
      child: MaterialApp(
        theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar'), 
        supportedLocales: [Locale('ar')],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl, 
            child: child!,
          );
        },
        routes: {
          'regesterpage': (context) => RegesterPage(),
          'loginpage': (context) => LoginPage(),
          'homeView': (context) => HomeView(),
          'verfiyPage': (context) => VerfiyPage(),
        },
        initialRoute: LoginPage.id, 
      ),
    );
  }
}
