import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:logo_app_traning/model/regester_model.dart';

class ApiService {
  static const String baseUrl = 'https://crmdemo.excp.sa:8004/Api';
  Map<String, String> headers = {
    'platform': 'android',
    'version': '7.0.0',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  Future<http.Response> registerUser(SignUpUserPost user) async {
    final url = Uri.parse('$baseUrl/ar/Account/Register');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(user.toJson()),
    );
    return response;
  }

  Future<http.Response> loginUser(String phoneNumber, String password) async {
    final url = Uri.parse('$baseUrl/ar/Account/Login');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({"userName": phoneNumber, "password": password}),
    );
    return response;
  }

  Future<http.Response> verifyOtp(String phoneNumber, String otp) async {
    final url = Uri.parse('$baseUrl/ar/Account/VerifyCode');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({'userName': phoneNumber, 'otp': otp}),
    );
    return response;
  }

  Future<http.Response> regenerateOtp(String phoneNumber) async {
    final url = Uri.parse('$baseUrl/ar/Account/ReGenrateCode');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({'phoneNumber': phoneNumber}),
    );
    log('Regenerate OTP response: ${response.body}');

    return response;
  }

  Future<http.Response> forgetPassword(String phoneNumber) async {
    final url = Uri.parse('$baseUrl/ar/Account/ForgetPassword');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({'phoneNumber': phoneNumber}),
    );
    log('Forget Password response: ${response.body}');
    return response;
  }

  // Future<http.Response> resetPassword(){};
}
