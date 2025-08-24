class Regester {
  Data? data;
  int? status;
  Null? code;
  Null? message;
  Null? location;

  Regester({this.data, this.status, this.code, this.message, this.location});

  Regester.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
    code = json['code'];
    message = json['message'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    data['location'] = this.location;
    return data;
  }
}

class Data {
  String? phoneNumber;
  String? password;
  Null? code;
  String? userId;
  bool? rememberMe;

  Data(
      {this.phoneNumber,
      this.password,
      this.code,
      this.userId,
      this.rememberMe});

  Data.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    code = json['code'];
    userId = json['userId'];
    rememberMe = json['rememberMe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['password'] = this.password;
    data['code'] = this.code;
    data['userId'] = this.userId;
    data['rememberMe'] = this.rememberMe;
    return data;
  }
}