part of 'manage_location_cubit.dart';

abstract class ManageLocationState {}

final class ManageLocationInitial extends ManageLocationState {}

final class ManageLocationLoading extends ManageLocationState {}

final class ManageLocationSuccess extends ManageLocationState {
  final List<GetTitelModel> cities;
  final List<GetTitelModel> houseTypes;
  final List<GetTitelModel> houseFloors;
  final List<GetTitelModel> districts;

  final GetTitelModel? selectedCity;
  final GetTitelModel? selectedDistrict;
  final GetTitelModel? selectedHouseType;
  final GetTitelModel? selectedHouseFloor;

  ManageLocationSuccess({
    required this.cities,
    required this.houseTypes,
    required this.houseFloors,
    required this.districts,
    this.selectedCity,
    this.selectedDistrict,
    this.selectedHouseType,
    this.selectedHouseFloor,
  });

  ManageLocationSuccess copyWith({
    List<GetTitelModel>? cities,
    List<GetTitelModel>? houseTypes,
    List<GetTitelModel>? houseFloors,
    List<GetTitelModel>? districts,
    GetTitelModel? selectedCity,
    GetTitelModel? selectedDistrict,
    GetTitelModel? selectedHouseType,
    GetTitelModel? selectedHouseFloor,
  }) {
    return ManageLocationSuccess(
      cities: cities ?? this.cities,
      houseTypes: houseTypes ?? this.houseTypes,
      houseFloors: houseFloors ?? this.houseFloors,
      districts: districts ?? this.districts,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedHouseType: selectedHouseType ?? this.selectedHouseType,
      selectedHouseFloor: selectedHouseFloor ?? this.selectedHouseFloor,
    );
  }
}

final class ManageLocationFailure extends ManageLocationState {
  final String message;
  ManageLocationFailure(this.message);
}
