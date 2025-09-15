part of 'map_cubit.dart';

enum MapStatus { initial, loading, success, failure }

class MapState extends Equatable {
  final Completer<GoogleMapController> controllerGoogel =
      Completer<GoogleMapController>();
  final Position? position;
  final CameraPosition? myCameraPosition;
  final Set<Marker> markers;
  final String? message;
  final MapStatus stutes;

  MapState({
    this.markers = const {},
    this.position,
    this.myCameraPosition,
    this.message,
    this.stutes = MapStatus.initial,
  });

  MapState copyWith({
    Set<Marker>? markers,
    Position? position,
    CameraPosition? myCameraPosition,
    String? message,
    MapStatus? stutes,
  }) {
    return MapState(
      markers: markers ?? this.markers,
      position: position ?? this.position,
      myCameraPosition: myCameraPosition ?? this.myCameraPosition,
      stutes: stutes ?? this.stutes,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    position,
    myCameraPosition,
    controllerGoogel,
    message,
    stutes,
    markers,
  ];
}
