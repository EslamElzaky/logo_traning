// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Create a New Account`
  String get title {
    return Intl.message(
      'Create a New Account',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `enter Youer information`
  String get subtitle {
    return Intl.message(
      'enter Youer information',
      name: 'subtitle',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message('First Name', name: 'first_name', desc: '', args: []);
  }

  /// `Middle Name`
  String get middle_name {
    return Intl.message('Middle Name', name: 'middle_name', desc: '', args: []);
  }

  /// `Last Name`
  String get last_name {
    return Intl.message('Last Name', name: 'last_name', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// ` enter phone number and password`
  String get subLogin {
    return Intl.message(
      ' enter phone number and password',
      name: 'subLogin',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get no_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'no_account',
      desc: '',
      args: [],
    );
  }

  /// `Skip for Now`
  String get skip {
    return Intl.message('Skip for Now', name: 'skip', desc: '', args: []);
  }

  /// ` is Required`
  String get required {
    return Intl.message(' is Required', name: 'required', desc: '', args: []);
  }

  /// `Field `
  String get field {
    return Intl.message('Field ', name: 'field', desc: '', args: []);
  }

  /// `Mobile verification`
  String get verfiy_number {
    return Intl.message(
      'Mobile verification',
      name: 'verfiy_number',
      desc: '',
      args: [],
    );
  }

  /// `Verification code sent to  `
  String get sent_code {
    return Intl.message(
      'Verification code sent to  ',
      name: 'sent_code',
      desc: '',
      args: [],
    );
  }

  /// `change`
  String get change {
    return Intl.message('change', name: 'change', desc: '', args: []);
  }

  /// `Didn't receive code? Send it `
  String get reciev_code {
    return Intl.message(
      'Didn\'t receive code? Send it ',
      name: 'reciev_code',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message('Resend', name: 'resend', desc: '', args: []);
  }

  /// `Type the letters shown above`
  String get capatcha_label {
    return Intl.message(
      'Type the letters shown above',
      name: 'capatcha_label',
      desc: '',
      args: [],
    );
  }

  /// `Verify code`
  String get verfiy_code {
    return Intl.message('Verify code', name: 'verfiy_code', desc: '', args: []);
  }

  /// `Forgot password`
  String get forget_pass {
    return Intl.message(
      'Forgot password',
      name: 'forget_pass',
      desc: '',
      args: [],
    );
  }

  /// `Please enter registered mobile number`
  String get regster_num {
    return Intl.message(
      'Please enter registered mobile number',
      name: 'regster_num',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must be 10 digits`
  String get valaidat_num1 {
    return Intl.message(
      'Phone number must be 10 digits',
      name: 'valaidat_num1',
      desc: '',
      args: [],
    );
  }

  /// `The third number cannot be`
  String get valaidat_num2 {
    return Intl.message(
      'The third number cannot be',
      name: 'valaidat_num2',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `The passwords do not match`
  String get validat_pass {
    return Intl.message(
      'The passwords do not match',
      name: 'validat_pass',
      desc: '',
      args: [],
    );
  }

  /// `Nwe password`
  String get new_pass {
    return Intl.message('Nwe password', name: 'new_pass', desc: '', args: []);
  }

  /// ` Confirm New Password`
  String get conf_new_pass {
    return Intl.message(
      ' Confirm New Password',
      name: 'conf_new_pass',
      desc: '',
      args: [],
    );
  }

  /// `Verify code`
  String get verfy {
    return Intl.message('Verify code', name: 'verfy', desc: '', args: []);
  }

  /// `Please enter email`
  String get enter_email {
    return Intl.message(
      'Please enter email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `enter correct email`
  String get correct_email {
    return Intl.message(
      'enter correct email',
      name: 'correct_email',
      desc: '',
      args: [],
    );
  }

  /// `required password`
  String get req_password {
    return Intl.message(
      'required password',
      name: 'req_password',
      desc: '',
      args: [],
    );
  }

  /// `Set a new password`
  String get page_new_pass {
    return Intl.message(
      'Set a new password',
      name: 'page_new_pass',
      desc: '',
      args: [],
    );
  }

  /// `Hello dear customer`
  String get titel_home {
    return Intl.message(
      'Hello dear customer',
      name: 'titel_home',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
