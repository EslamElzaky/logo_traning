import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logo_app_traning/helper/api_servic.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapState());

  void setMapController(GoogleMapController controller) {
    state.controllerGoogel.complete(controller);
  }

  Future<void> getCurrentLocation() async {
    try {
      emit(state.copyWith(stutes: MapStatus.loading));

      final pos = await determinePosition();
      log('my Position$pos');
      final cameraPos = CameraPosition(
        bearing: 0.0,
        target: LatLng(pos.latitude, pos.longitude),
        tilt: 0.0,
        zoom: 17,
      );

      emit(
        state.copyWith(
          position: pos,
          myCameraPosition: cameraPos,
          stutes: MapStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(stutes: MapStatus.failure, message: e.toString()));
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.requestPermission();
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('تم رفض إذن الموقع');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('إذن الموقع مرفوض نهائيًا');
    }
    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  Future<void> animateToMyLocation() async {
    if (state.controllerGoogel.isCompleted && state.myCameraPosition != null) {
      final controller = await state.controllerGoogel.future;
      log(state.myCameraPosition.runtimeType.toString());
      controller.animateCamera(
        CameraUpdate.newCameraPosition(state.myCameraPosition!),
      );
    }
  }

  Future<void> addMarker(LatLng position) async {
    final marker = Marker(
      markerId: MarkerId(position.toString()),
      position: position,
    );
    emit(
      state.copyWith(
        markers: {marker},
        // myCameraPosition: CameraPosition(target: position, zoom: 19),
      ),
    );
    final controller = await state.controllerGoogel.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 19),
      ),
    );
  }

  Future<void> loadPolygon(String destrictId) async {
    try {
      final response = await ApiService().getPolygon(destrictId);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final String raw = body["data"];
        final cleaned = raw
            .replaceAll('[', '')
            .replaceAll(']', '')
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();

        final numbers = cleaned.map((e) => double.parse(e)).toList();

        final points = <LatLng>[];
        for (int i = 0; i < numbers.length; i += 2) {
          // points.add(LatLng(numbers[i + 1], numbers[i]));
          points.add(LatLng(numbers[i], numbers[i + 1]));
        }
        log(points.toString());

        print(points);
        final polygon = Polygon(
          polygonId: PolygonId(destrictId),
          points: points,
          fillColor: Colors.blue.withOpacity(0.3),
          strokeColor: Colors.black,
          strokeWidth: 1,
        );
        print("قبل التحديث: ${state.polygons.length}");

        emit(state.copyWith(polygons: {polygon}, stutes: MapStatus.success));

        // emit(state.copyWith(polygons: {polygon}, stutes: MapStatus.success));
        print("بعد التحديث (مش هيبان الجديد هنا): ${state.polygons.length}");

        print('Polygon created with ${points.length} points');
        print('First point: ${points.first}');
        log('تم إنشاء المضلع بنجاح بعدد ${points.length} نقطة');
      }
    } catch (e) {
      log("خطأ في تحميل البوليغون: $e");
    }
  }

  // Future<void> loadPolygon(String districtId) async {
  //   emit(state.copyWith(stutes: MapStatus.loading));

  //   try {
  //     final response = await ApiService().getPolygon(districtId);

  //     if (response.statusCode == 200) {
  //       final body = jsonDecode(response.body);
  //       final String raw = body["data"];

  //       // تنظيف البيانات بشكل أكثر فعالية
  //       final cleaned = raw
  //           .replaceAll(RegExp(r'[\[\]]'), '') // إزالة الأقواس
  //           .split(',')
  //           .map((e) => e.trim())
  //           .where((e) => e.isNotEmpty)
  //           .toList();

  //       // التحقق من أن عدد العناصر زوجي
  //       if (cleaned.length % 2 != 0) {
  //         emit(
  //           state.copyWith(
  //             stutes: MapStatus.failure,
  //             message: "بيانات المضلع غير صحيحة",
  //           ),
  //         );
  //         return;
  //       }

  //       // تحويل البيانات إلى أرقام
  //       final numbers = cleaned.map((e) => double.tryParse(e) ?? 0.0).toList();

  //       final points = <LatLng>[];
  //       for (int i = 0; i < numbers.length; i += 2) {
  //         points.add(LatLng(numbers[i], numbers[i + 1]));
  //       }
  //       log(points.toString());

  //       final polygon = Polygon(
  //         polygonId: PolygonId(districtId),
  //         points: points,
  //         strokeWidth: 3,
  //         strokeColor: Colors.blue,
  //         fillColor: Colors.blue.withOpacity(0.15),
  //       );

  //       emit(state.copyWith(polygons: {polygon}));

  //       log('تم إنشاء المضلع بنجاح بعدد ${points.length} نقطة');
  //     } else {
  //       emit(
  //         state.copyWith(
  //           stutes: MapStatus.failure,
  //           message: "فشل في جلب البيانات: ${response.statusCode}",
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     log("خطأ في تحميل البوليغون: $e");
  //     emit(
  //       state.copyWith(
  //         stutes: MapStatus.failure,
  //         message: "حدث خطأ أثناء تحميل المضلع",
  //       ),
  //     );
  //   }
  // }
}
