import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
      await Geolocator.openLocationSettings();
      return Future.error('خدمة الموقع مقفولة');
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
    if (state.controllerGoogel != null &&
        state.controllerGoogel!.isCompleted &&
        state.myCameraPosition != null) {
      final controller = await state.controllerGoogel!.future;
      log(state.myCameraPosition.runtimeType.toString());
      controller.animateCamera(
        CameraUpdate.newCameraPosition(state.myCameraPosition!),
      );
    }
  }
}
