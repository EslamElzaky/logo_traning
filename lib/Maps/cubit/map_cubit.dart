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

        // 2- تحويله لـ double
        final numbers = cleaned.map((e) => double.parse(e)).toList();

        // 3- كل اتنين (lat, lng) نعمل LatLng
        final points = <LatLng>[];
        for (int i = 0; i < numbers.length; i += 2) {
          points.add(LatLng(numbers[i], numbers[i + 1]));
        }

        print(points);
        final polygon = Polygon(
          polygonId: PolygonId(destrictId),
          points: points,
          fillColor: Colors.red,

          strokeWidth: 100,
        );
        print('Polygon created with ${points.length} points');
        print('First point: ${points.first}');

        emit(state.copyWith(polygons: {polygon}));
      }
    } catch (e) {
      log("خطأ في تحميل البوليغون: $e");
    }
  }
}
