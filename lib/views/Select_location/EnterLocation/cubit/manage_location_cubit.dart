import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logo_app_traning/helper/api_servic.dart';
import 'package:logo_app_traning/views/Select_location/EnterLocation/enter_location_model_city.dart';

part 'manage_location_state.dart';

class ManageLocationCubit extends Cubit<ManageLocationState> {
  ManageLocationCubit() : super(ManageLocationInitial());

  Future<void> loadTitelData() async {
    emit(ManageLocationLoading());
    List<GetTitelModel> cities = [];
    List<GetTitelModel> houseTypes = [];
    List<GetTitelModel> houseFloors = [];
    try {
      final cityResponse = await ApiService().getCity();
      if (cityResponse.statusCode == 200) {
        final body = jsonDecode(cityResponse.body);
        final List<dynamic> data = body["data"];
        cities = data.map((e) => GetTitelModel.fromJson(e)).toList();
      }

      final houseResponse = await ApiService().getHouseType();
      if (houseResponse.statusCode == 200) {
        final body = jsonDecode(houseResponse.body);
        final List<dynamic> data = body["data"];
        houseTypes = data.map((e) => GetTitelModel.fromJson(e)).toList();
      }

      final floorResponse = await ApiService().getHouseFloor();
      if (floorResponse.statusCode == 200) {
        final body = jsonDecode(floorResponse.body);
        final List<dynamic> data = body["data"];
        houseFloors = data.map((e) => GetTitelModel.fromJson(e)).toList();
      }

      emit(
        ManageLocationSuccess(
          cities: cities,
          houseTypes: houseTypes,
          houseFloors: houseFloors,
          districts: [],
        ),
      );
    } catch (e) {
      log("Error in loadInitialData: $e");
      emit(ManageLocationFailure("Error in loadTitelData: $e"));
    }
  }

  Future<void> fetchDistricts(String cityId) async {
    try {
      final response = await ApiService().getDistricts(cityId);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List<dynamic> data = body["data"];

        final districts = data.map((e) => GetTitelModel.fromJson(e)).toList();

        if (state is ManageLocationSuccess) {
          final current = state as ManageLocationSuccess;
          emit(current.copyWith(districts: districts));
        } else {
          emit(ManageLocationFailure("فشل تحميل الاحياء"));
        }
      }
    } catch (e) {
      emit(ManageLocationFailure("Error in fetchDistricts: $e"));
    }
  }


  void selectCity(GetTitelModel city) {
    if (state is ManageLocationSuccess) {
      final current = state as ManageLocationSuccess;
      emit(
        current.copyWith(
          selectedCity: city,
          selectedDistrict: null,
          districts: [],
        ),
      );
      fetchDistricts(city.id ?? "");
    }
  }

  void selectDistrict(GetTitelModel district) {
    if (state is ManageLocationSuccess) {
      final current = state as ManageLocationSuccess;
      emit(current.copyWith(selectedDistrict: district));
    }
  }

  void selectHouseType(GetTitelModel type) {
    if (state is ManageLocationSuccess) {
      final current = state as ManageLocationSuccess;
      emit(current.copyWith(selectedHouseType: type));
    }
  }

  void selectHouseFloor(GetTitelModel floor) {
    if (state is ManageLocationSuccess) {
      final current = state as ManageLocationSuccess;
      emit(current.copyWith(selectedHouseFloor: floor));
    }
  }
}
