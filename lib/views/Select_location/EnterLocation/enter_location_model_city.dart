class GetTitelModel {
  final String? id;
  final String? value;

  GetTitelModel({this.id, this.value});

  factory GetTitelModel.fromJson(Map<String, dynamic> json) {
    return GetTitelModel(
      id: json['key'].toString(),
      value: json['value'].toString(),
    );
  }
}
