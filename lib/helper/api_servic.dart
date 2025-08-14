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
  void requestLog({
    required String url,
    required String httpType,
    required Map<String, String> headers,
    dynamic requestBody,
    required int statusCode,
    required dynamic responseBody,
  }) {
    log(' REQUEST');
    log('Method: $httpType');
    log('URL: $url');
    log('Headers: ${jsonEncode(headers)}');
    if (requestBody != null) {
      log('Body: ${jsonEncode(requestBody)}');
    }

    log(' RESPONSE');
    log('Status Code: $statusCode');
    log('Body: ${jsonEncode(responseBody)}');
  }

  Future<http.Response> registerUser(SignUpUserPost user) async {
    final url = Uri.parse('$baseUrl/ar/Account/Register');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(user.toJson()),
    );
    log('${response.body}, Status Code: ${response.statusCode}');
    requestLog(
      url: url.toString(),
      httpType: 'POST',
      headers: headers,
      requestBody: user.toJson(),
      statusCode: response.statusCode,
      responseBody: response.body,
    );
    return response;
  }

  Future<http.Response> loginUser(String phoneNumber, String password) async {
    final url = Uri.parse('$baseUrl/ar/Account/Login');
    final body = {"userName": phoneNumber, "password": password};
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({"userName": phoneNumber, "password": password}),
    );
    requestLog(
      url: url.toString(),
      httpType: 'POST',
      headers: headers,
      requestBody: body,
      statusCode: response.statusCode,
      responseBody: response.body,
    );
    return response;
  }

  Future<http.Response> verifyOtp(String phoneNumber, String otp) async {
    final url = Uri.parse('$baseUrl/ar/Account/VerifyCode');
    final body = {'phoneNumber': phoneNumber, 'code': otp};
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    requestLog(
      url: url.toString(),
      httpType: 'POST',
      headers: headers,
      requestBody: body,
      statusCode: response.statusCode,
      responseBody: response.body,
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
    requestLog(
      url: url.toString(),
      httpType: 'POST',
      headers: headers,
      requestBody: {'phoneNumber': phoneNumber},
      statusCode: response.statusCode,
      responseBody: response.body,
    );
    return response;
  }

  Future<http.Response> forgetPassword(String phoneNumber) async {
    final url = Uri.parse('$baseUrl/ar/Account/ForgotPassword');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({'phoneNumber': phoneNumber}),
    );
    log('Forget Password response: ${response.body}');
    return response;
  }

  Future<http.Response> resetPssword(
    String code,
    String password,
    String confirmPasswod,
  ) async {
    final url = Uri.parse('$baseUrl/ar/Account/ResetPassword');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        'code': code,
        'password': password,
        'confirmPassword': confirmPasswod,
      }),
    );
    log('Forget Password response: ${response.body}');
    return response;
  }
}
