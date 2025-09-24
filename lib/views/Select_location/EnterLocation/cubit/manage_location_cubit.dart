import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logo_app_traning/Global/global_variable.dart';
import 'package:logo_app_traning/helper/api_servic.dart';
import 'package:logo_app_traning/model/add_new_address.dart';
import 'package:logo_app_traning/views/Select_location/EnterLocation/enter_location_model_city.dart';

part 'manage_location_state.dart';

class ManageLocationCubit extends Cubit<ManageLocationState> {
  ManageLocationCubit() : super(ManageLocationState());
  String? apFlate;
  String? apDesc;
  static ManageLocationCubit get(context) => BlocProvider.of(context);

  void initcontroller() {}
  Future<void> loadTitelData() async {
    emit(state.copyWith(status: LocationStatus.loading));
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
        state.copyWith(
          cities: cities,
          houseTypes: houseTypes,
          houseFloors: houseFloors,
          status: LocationStatus.success,
        ),
      );
    } catch (e) {
      log("Error in loadInitialData: $e");
      emit(
        state.copyWith(
          status: LocationStatus.failure,
          message: 'خطأ في تحميل البيانات، حاول مرة اخرى',
        ),
      );
    }
  }

  Future<void> fetchDistricts(String cityId) async {
    try {
      final response = await ApiService().getDistricts(cityId);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List<dynamic> data = body["data"];

        final districts = data.map((e) => GetTitelModel.fromJson(e)).toList();
        emit(
          state.copyWith(districts: districts, status: LocationStatus.success),
        );
        // if (state is ManageLocationSuccess) {
        //   final current = state as ManageLocationSuccess;
        //   emit(current.copyWith(districts: districts));
      } else {
        emit(
          state.copyWith(
            status: LocationStatus.failure,
            message: 'فشل في تحميل الاحياء',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: LocationStatus.failure,
          message: 'Error in fetchDistricts: $e',
        ),
      );
    }
  }

  void selectCity(GetTitelModel city) {
    emit(
      state.copyWith(selectedCity: city, selectedDistrict: null, districts: []),
    );
    if (city.id != null) {
      fetchDistricts(city.id!);
    }
  }

  void selectDistrict(GetTitelModel district) {
    emit(state.copyWith(selectedDistrict: district));
  }

  void selectHouseType(GetTitelModel type) {
    emit(state.copyWith(selectedHouseType: type));
  }

  void selectHouseFloor(GetTitelModel floor) {
    emit(state.copyWith(selectedHouseFloor: floor));
  }

  Future<void> validateCity(String cityId) async {
    try {
      final response = await ApiService().validationCity(cityId);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final apiStatus = body["status"];

        if (apiStatus == 200) {
          final city = state.cities.firstWhere((c) => c.id == cityId);
          emit(
            state.copyWith(
              selectedCity: city,
              status: LocationStatus.success,
              message: 'المدينة متاحة للخدمة',
            ),
          );
          await fetchDistricts(cityId);
        } else if (apiStatus == 300) {
          emit(
            state.copyWith(
              status: LocationStatus.failure,
              message: body["message"] ?? "هذه المدينة غير متاحة للخدمة",
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: LocationStatus.failure,
              message: "استجابة غير متوقعة من السيرفر (${apiStatus ?? 'null'})",
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            status: LocationStatus.failure,
            message: "فشل الاتصال بالسيرفر (كود ${response.statusCode})",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: LocationStatus.failure,
          message: "خطأ أثناء التحقق من المدينة: $e",
        ),
      );
    }
  }

  Future<void> validateDistrict(String districtId) async {
    try {
      final response = await ApiService().validationDistricts(districtId);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final apiStatus = body["status"];

        final district = state.districts.firstWhereOrNull(
          (d) => d.id == districtId,
        );
        emit(
          state.copyWith(
            selectedDistrict: district,
            status: LocationStatus.success,
            message: "هذا الحي متاح للخدمة",
          ),
        );
      } else if (response.statusCode == 300) {
        emit(
          state.copyWith(
            status: LocationStatus.failure,
            message: body["message"] ?? " هذا الحي غير متاح للخدمة",
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: LocationStatus.failure,
            message: "فشل الاتصال بالسيرفر",
          ),
        );
      }
    } catch (e, s) {
      log('$e', stackTrace: s);
      emit(
        state.copyWith(
          status: LocationStatus.failure,
          message: " خطأ أثناء التحقق من الحي: $e",
        ),
      );
    }
  }

  void setApartmentNo(TextEditingController value) {
    // emit(state.copyWith(apartmentNo: value));
  }

  void setAddressNotes(TextEditingController value) {
    // emit(state.copyWith(addressNotes: value));
  }

  Future<void> saveAddress(
    LatLng pos, {
    String? apartmentNo,
    String? description,
  }) async {
    // emit(state.copyWith(status: LocationStatus.loading));

    try {
      // بناء الموديل من القيم المخزنة في الـ state
      final newAddress = AddNewAddress(
        contactId: GlobalData.crmUserId,
        houseNo: state.selectedHouseType?.value,
        houseType: int.tryParse(state.selectedHouseType?.id ?? "0"),
        floorNo: int.tryParse(state.selectedHouseFloor?.id ?? "0"),
        apartmentNo: apartmentNo,
        cityId: state.selectedCity?.id,
        districtId: state.selectedDistrict?.id,
        latitude: pos.latitude.toString(),
        longitude: pos.longitude.toString(),
        addressNotes: description,
        type: 1,
      );
      emit(state.copyWith(status: LocationStatus.loading));
      log(jsonEncode(newAddress.toJson()));
      final response = await ApiService().addAddress(newAddress);
       final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        emit(
          state.copyWith(
            status: LocationStatus.success,
            message: body["data"] ?? "تم إضافة عنوان جديد بنجاح ",
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: LocationStatus.failure,
            message: body["message"]?? "فشل في إضافة العنوان",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: LocationStatus.failure, message: "حصل خطأ: $e"),
      );
    }
  }
}
