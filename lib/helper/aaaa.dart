//  Future<http.Response> validationCity(String cityId) async {
//     final response = await request(
//       url: '/ar/api/City/CheckCityAvailabilityForService?cityId=$cityId',
//       method: 'get',
//     );
//     return response;
//   }
//   Future<http.Response> validationDistrict(String districtId) async {
//     final response = await request(
//       url: '/ar/api/City/IsDistrictAvailableForService?districtId==$districtId',
//       method: 'get',
//     );
//     return response;
//   }

//   Future<void> validateCity(String? cityId) async {
//     try {
//       final response = await ApiService().validationCity(cityId!);
//       final body = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         if (state is ManageLocationSuccess) {
//           final current = state as ManageLocationSuccess;
//           final city = current.cities.firstWhere((c) => c.id == cityId);
//           emit(current.copyWith(selectedCity: city));
//         }
//       } else {
//         emit(ManageLocationFailure("الحي خارج نطاق الخدمة"));
//       }
//     } catch (e) {
//       emit(ManageLocationFailure("حدث خطأ في الاتصال بالإنترنت"));
//     }
//   }

//   Future<void> validateDistrict(String? districtId) async {
//     try {
//       final response = await ApiService().validationDistrict(districtId!);
//       final body = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         if (state is ManageLocationSuccess) {
//           final current = state as ManageLocationSuccess;
//           final district = current.districts.firstWhere(
//             (d) => d.id == districtId,
//           );
//           emit(current.copyWith(selectedDistrict: district));
//         }
//       } else {
//         emit(ManageLocationFailure("الحي خارج نطاق الخدمة"));
//       }
//     } catch (e) {
//       emit(ManageLocationFailure("حدث خطأ في الاتصال بالإنترنت"));
//     }
//   }
// import 'package:equatable/equatable.dart';
// import 'enter_location_model_city.dart';

// enum LocationStatus { initial, loading, success, failure }

// class ManageLocationState extends Equatable {
//   final List<GetTitelModel> cities;
//   final List<GetTitelModel> districts;
//   final List<GetTitelModel> houseTypes;
//   final List<GetTitelModel> houseFloors;

//   final GetTitelModel? selectedCity;
//   final GetTitelModel? selectedDistrict;
//   final GetTitelModel? selectedHouseType;
//   final GetTitelModel? selectedHouseFloor;

//   final LocationStatus status;
//   final String? message;

//   const ManageLocationState({
//     this.cities = const [],
//     this.districts = const [],
//     this.houseTypes = const [],
//     this.houseFloors = const [],
//     this.selectedCity,
//     this.selectedDistrict,
//     this.selectedHouseType,
//     this.selectedHouseFloor,
//     this.status = LocationStatus.initial,
//     this.message,
//   });

//   ManageLocationState copyWith({
//     List<GetTitelModel>? cities,
//     List<GetTitelModel>? districts,
//     List<GetTitelModel>? houseTypes,
//     List<GetTitelModel>? houseFloors,
//     GetTitelModel? selectedCity,
//     GetTitelModel? selectedDistrict,
//     GetTitelModel? selectedHouseType,
//     GetTitelModel? selectedHouseFloor,
//     LocationStatus? status,
//     String? message,
//   }) {
//     return ManageLocationState(
//       cities: cities ?? this.cities,
//       districts: districts ?? this.districts,
//       houseTypes: houseTypes ?? this.houseTypes,
//       houseFloors: houseFloors ?? this.houseFloors,
//       selectedCity: selectedCity ?? this.selectedCity,
//       selectedDistrict: selectedDistrict ?? this.selectedDistrict,
//       selectedHouseType: selectedHouseType ?? this.selectedHouseType,
//       selectedHouseFloor: selectedHouseFloor ?? this.selectedHouseFloor,
//       status: status ?? this.status,
//       message: message ?? this.message,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         cities,
//         districts,
//         houseTypes,
//         houseFloors,
//         selectedCity,
//         selectedDistrict,
//         selectedHouseType,
//         selectedHouseFloor,
//         status,
//         message,
//       ];
// }

// import 'dart:developer';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:logo_app_traning/helper/api_servic.dart';
// import 'enter_location_model_city.dart';
// import 'manage_location_state.dart';

// class ManageLocationCubit extends Cubit<ManageLocationState> {
//   ManageLocationCubit() : super(const ManageLocationState());

//   static ManageLocationCubit get(context) => BlocProvider.of(context);

//   /// تحميل البيانات الأساسية: المدن، أنواع المنازل، الطوابق
//   Future<void> loadTitelData() async {
//     emit(state.copyWith(status: LocationStatus.loading));
//     try {
//       final cities = await ApiService.getCities();
//       final houseTypes = await ApiService.getHouseTypes();
//       final houseFloors = await ApiService.getHouseFloors();

//       emit(state.copyWith(
//         cities: cities,
//         houseTypes: houseTypes,
//         houseFloors: houseFloors,
//         status: LocationStatus.success,
//       ));
//     } catch (e) {
//       log('Error loading title data: $e');
//       emit(state.copyWith(
//         status: LocationStatus.failure,
//         message: 'خطأ في تحميل البيانات، حاول مرة اخرى',
//       ));
//     }
//   }

//   /// اختيار المدينة
//   Future<void> selectCity(GetTitelModel city) async {
//     emit(state.copyWith(
//       selectedCity: city,
//       status: LocationStatus.loading,
//       districts: [],
//       selectedDistrict: null,
//     ));

//     try {
//       final districts = await ApiService.getDistricts(city.id ?? '');
//       if (districts.isEmpty) {
//         // لو المدينة خارج التغطية
//         emit(state.copyWith(
//           status: LocationStatus.failure,
//           message: 'هذه المدينة خارج التغطية',
//           districts: [],
//         ));
//       } else {
//         emit(state.copyWith(
//           districts: districts,
//           status: LocationStatus.success,
//         ));
//       }
//     } catch (e) {
//       log('Error fetching districts: $e');
//       emit(state.copyWith(
//         status: LocationStatus.failure,
//         message: 'حدث خطأ في الاتصال',
//       ));
//     }
//   }

//   /// اختيار الحي
//   void selectDistrict(GetTitelModel district) {
//     emit(state.copyWith(selectedDistrict: district));
//   }

//   /// اختيار نوع المنزل
//   void selectHouseType(GetTitelModel houseType) {
//     emit(state.copyWith(selectedHouseType: houseType));
//   }

//   /// اختيار رقم الطابق
//   void selectHouseFloor(GetTitelModel floor) {
//     emit(state.copyWith(selectedHouseFloor: floor));
//   }
// }
