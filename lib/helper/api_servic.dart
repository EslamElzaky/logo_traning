import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logo_app_traning/model/regester_model.dart';

class ApiService {
  static const String baseUrl = 'https://crmdemo.excp.sa:8004/Api';
  Map<String, String> headers = {
    'platform': 'android',
    'version': '7.0.0',
    'Content-Type': 'application/json',
  };
  Future<http.Response> registerUser(SignUpUserPost user) async {
    final url = Uri.parse(
      '$baseUrl/ar/Account/Register',
    ); 
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
      body: jsonEncode({'userName': phoneNumber, 'password': password}),
    );
    return response;
  }
}
