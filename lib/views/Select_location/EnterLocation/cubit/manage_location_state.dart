part of 'manage_location_cubit.dart';

enum LocationStatus { initial, loading, success, failure }

class ManageLocationState extends Equatable {
  final List<GetTitelModel> cities;
  final List<GetTitelModel> houseTypes;
  final List<GetTitelModel> houseFloors;
  final List<GetTitelModel> districts;
  final String? apartmentNo;
  final String? addressNotes;

  final GetTitelModel? selectedCity;
  final GetTitelModel? selectedDistrict;
  final GetTitelModel? selectedHouseType;
  final GetTitelModel? selectedHouseFloor;
  final String? message;
  final LocationStatus status;

  const ManageLocationState({
    this.cities = const [],
    this.apartmentNo,
    this.addressNotes,
    this.houseTypes = const [],
    this.houseFloors = const [],
    this.districts = const [],
    this.selectedCity,
    this.selectedDistrict,
    this.selectedHouseType,
    this.selectedHouseFloor,
    this.status = LocationStatus.initial,
    this.message,
  });

  ManageLocationState copyWith({
    List<GetTitelModel>? cities,
    List<GetTitelModel>? houseTypes,
    List<GetTitelModel>? houseFloors,
    List<GetTitelModel>? districts,
    GetTitelModel? selectedCity,
    GetTitelModel? selectedDistrict,
    GetTitelModel? selectedHouseType,
    GetTitelModel? selectedHouseFloor,
    LocationStatus? status,
    String? message,
  }) {
    return ManageLocationState(
      cities: cities ?? this.cities,
      houseTypes: houseTypes ?? this.houseTypes,
      houseFloors: houseFloors ?? this.houseFloors,
      districts: districts ?? this.districts,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedHouseType: selectedHouseType ?? this.selectedHouseType,
      selectedHouseFloor: selectedHouseFloor ?? this.selectedHouseFloor,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    cities,
    districts,
    houseTypes,
    houseFloors,
    selectedCity,
    selectedDistrict,
    selectedHouseType,
    selectedHouseFloor,
    status,
    message,
  ];
}
