class GetAddressesModel {
  String? id;
  String? displayValue;
  String? cityId;
  GetAddressesModel({this.id, this.cityId, this.displayValue});
  factory GetAddressesModel.fromJason(Map<String, dynamic> json) =>
      GetAddressesModel(
        id: json['id'],
        cityId: json['cityId'],
        displayValue: json['displayValue'],
      );
}
