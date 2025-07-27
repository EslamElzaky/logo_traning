class SignUpUserPost {
  SignUpUserPost({
    this.userName,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
    
  });

  String? userName;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? password;
  String? confirmPassword;
 

  factory SignUpUserPost.fromJson(Map<String, dynamic> json) => SignUpUserPost(
    userName: json["userName"] ?? null,
    firstName: json["firstName"] ?? null,
    middleName: json["middleName"] ?? null,
    lastName: json["lastName"] ?? null,
    email: json["email"] ?? null,
    password: json["password"] ?? null,
    confirmPassword: json["confirmPassword"] ?? null,
   
  );

  Map<String, dynamic> toJson() => {
    "userName": userName ?? null,
    "firstName": firstName ?? null,
    "middleName": middleName ?? null,
    "lastName": lastName ?? null,
    "email": email ?? null,
    "password": password ?? null,
    "confirmPassword": confirmPassword ?? null,
    
  };
}
