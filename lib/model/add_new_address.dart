class AddNewAddress {
  String? contactId;
  String? houseNo;
  int? houseType;
  int? floorNo;
  String? apartmentNo;
  String? cityId;
  String? districtId;
  String? latitude;
  String? longitude;
  String? addressNotes;
  int? type;

  AddNewAddress({
    this.contactId,
    this.type,
    this.houseNo,
    this.houseType,
    this.floorNo,
    this.apartmentNo,
    this.cityId,
    this.districtId,
    this.latitude,
    this.longitude,
    this.addressNotes,
  });

  factory AddNewAddress.fromJson(Map<String, dynamic> json) => AddNewAddress(
    contactId: json['contactId'],
    houseNo: json['houseNo'],
    houseType: json['houseType'],
    floorNo: json['floorNo'],
    apartmentNo: json['apartmentNo'],
    cityId: json['cityId'],
    districtId: json['districtId'],
    latitude: json['latitude'],
    longitude: json['longitude'],
    addressNotes: json['addressNotes'],
    type: json['type'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = type;
    data['contactId'] = contactId;
    data['houseNo'] = houseNo;
    data['houseType'] = houseType;
    data['floorNo'] = floorNo;
    data['apartmentNo'] = apartmentNo;
    data['cityId'] = cityId;
    data['districtId'] = districtId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['addressNotes'] = addressNotes;
    return data;
  }
}
