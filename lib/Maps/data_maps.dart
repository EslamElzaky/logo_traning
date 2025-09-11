import 'package:geolocator/geolocator.dart';

// class locationMaps {
//   static Future<Position> determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('خدمة الموقع مقفولة');
//     }
//     permission = await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         throw Exception('تم رفض إذن الموقع');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       throw Exception('إذن الموقع مرفوض نهائيًا');
//     }
//     return await Geolocator.getCurrentPosition(
//       locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
//     );
//   }
// }
