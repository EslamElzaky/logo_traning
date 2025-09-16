import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logo_app_traning/model/regester_model.dart';

class ApiService {
  static const String baseUrl = 'https://crmtest.massadrhr.com:8006/ar/api/';
  Map<String, String> headers = {
    'platform': 'android',
    'version': '7.0.0',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    "source": "1",
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

  Future<http.Response> request({
    required String url,
    required String method,
    Map<String, dynamic>? body,
  }) async {
    http.Response response;
    final Url = Uri.parse('$baseUrl$url');

    if (method.toLowerCase() == 'get') {
      response = await http.get(Url, headers: headers);
    } else if (method.toLowerCase() == "post") {
      response = await http.post(Url, headers: headers, body: jsonEncode(body));
    } else {
      throw Exception("Unsupported method: $method");
    }

    requestLog(
      url: Url.toString(),
      httpType: method,
      headers: headers,
      statusCode: response.statusCode,
      responseBody: response.body,
    );
    return response;
  }

  Future<http.Response> registerUser(SignUpUserPost user) async {
    final response = await ApiService().request(
      method: "post",
      url: 'Account/Register',
      body: user.toJson(),
    );

    log('${response.body}, Status Code: ${response.statusCode}');

    return response;
  }

  Future<http.Response> loginUser(String phoneNumber, String password) async {
    final response = await ApiService().request(
      method: "post",
      url: 'Account/Login',
      body: {"userName": phoneNumber, "password": password},
    );

    return response;
  }

  Future<dynamic> verifyOtp(
    String phoneNumber,
    String otp,
    String password,
    String userId,
  ) async {
    final response = await request(
      method: "post",
      url: 'Account/VerifyCode',
      body: {
        'phoneNumber': phoneNumber,
        'code': otp,
        'password': password,
        'userId': userId,
      },
    );

    return response;
  }

  Future<http.Response> regenerateOtp(String phoneNumber) async {
    final response = await request(
      method: "post",
      url: 'Account/ReGenrateCode',
      body: {'phoneNumber': phoneNumber},
    );
    return response;
  }

  Future<http.Response> forgetPassword(String phoneNumber) async {
    final response = await request(
      method: "post",
      url: 'Account/ForgotPassword',
      body: {'phoneNumber': phoneNumber},
    );
    return response;
  }

  Future<http.Response> resetPssword(
    String code,
    String password,
    String confirmPasswod,
    String phoneNumber,
  ) async {
    final response = await request(
      method: "post",
      url: 'Account/ResetPassword',
      body: {
        'phoneNumber': phoneNumber,
        'code': code,
        'password': password,
        'confirmPassword': confirmPasswod,
      },
    );

    return response;
  }

  Future<http.Response> getSlider() async {
    final response = await request(method: "get", url: 'Slider');

    return response;
  }

  Future<http.Response> getService() async {
    final response = await request(
      method: "get",
      url: 'Service/ServicesForService?serviceType=1',
    );

    return response;
  }

  Future<http.Response> getCity() async {
    final response = await request(url: 'City/Active', method: 'get');
    return response;
  }

  Future<http.Response> getHouseType() async {
    final response = await request(
      url: 'ContactAddress/HousingTypes',
      method: 'get',
    );
    return response;
  }

  Future<http.Response> getHouseFloor() async {
    final response = await request(
      url: 'ContactAddress/HousingFloors',
      method: 'get',
    );
    return response;
  }

  Future<http.Response> getDistricts(String cityId) async {
    final response = await request(
      url: 'City/Districts?cityId=$cityId',
      method: 'get',
    );
    return response;
  }

  Future<http.Response> validationCity(String cityId) async {
    final response = await request(
      url: 'City/CheckCityAvailabilityForService?cityId=$cityId&serviceType=1',
      method: 'get',
    );
    log("VALIDATE CITY URL: ${response.request?.url}");

    return response;
  }

  Future<http.Response> validationDistricts(String districtId) async {
    final response = await request(
      url: 'City/IsDistrictAvailableForService?districtId=$districtId',
      method: 'get',
    );
    return response;
  }

  Future<http.Response> getPolygon(String disttrictId) async {
    final response = await request(
      url: 'City/GetPolygonPath?districtId=$disttrictId',
      method: 'get',
    );
    return response;
  }
}
