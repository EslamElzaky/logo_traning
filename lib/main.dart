import 'package:flutter/material.dart';
import 'package:logo_app_traning/views/home_view.dart';
import 'package:logo_app_traning/views/login_page.dart';
import 'package:logo_app_traning/views/regester_page.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'), // 👈 لغة التطبيق
      supportedLocales: [Locale('ar')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl, // 👈 الاتجاه من اليمين
          child: child!,
        );
      },
      routes: {
        'regesterpage': (context) => RegesterPage(),
        'loginpage': (context) => LoginPage(),
        'homeView': (context) => HomeView(),
      },
      initialRoute: LoginPage.id, // 👈 صفحتك الأساسية
    );
  }
}
