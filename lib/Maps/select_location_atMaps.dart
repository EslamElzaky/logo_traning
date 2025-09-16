import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logo_app_traning/Maps/cubit/map_cubit.dart';

import 'package:logo_app_traning/helper/custom_app_bar.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_navigation_bottom.dart';

class SelectLocationAtmaps extends StatelessWidget {
const  SelectLocationAtmaps({super.key});
  static String id = 'selectLocationMaps';

  // Polygon polygon = Polygon(
  //   polygonId: PolygonId('1'),
  //   points: [
  //     LatLng(26.261606, 50.199802),
  //     LatLng(26.266378, 50.213363),
  //     LatLng(26.251137, 50.215423),
  //     LatLng(26.249829, 50.202634),
  //     LatLng(26.253832, 50.203407),
  //     LatLng(26.261606, 50.199802),
  //   ],
  // );
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit()..getCurrentLocation(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(
          text: 'حدد موقعك علي الخريطه',
          icon: Icons.notifications,
          backeIcon: Icons.arrow_back,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<MapCubit, MapState>(
                  builder: (context, state) {
                    if (state.stutes == MapStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      );
                    } else if (state.stutes == MapStatus.failure) {
                      return Center(
                        child: Text(
                          state.message ?? "حدث خطأ أثناء تحميل الموقع",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (state.stutes == MapStatus.success &&
                        state.myCameraPosition != null) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: GoogleMap(
                              polygons: state.polygons ,
                              initialCameraPosition: state.myCameraPosition!,
                              mapType: MapType.normal,
                              myLocationEnabled: true,
                              zoomControlsEnabled: false,
                              myLocationButtonEnabled: false,
                              onMapCreated: (GoogleMapController controller) {
                                context.read<MapCubit>().setMapController(
                                  controller,
                                );
                              },
                              markers: state.markers,
                              onTap: (LatLng pos) {
                                context.read<MapCubit>().addMarker(pos);
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 35,
                            right: 9,
                            child: FloatingActionButton(
                              child: const Icon(Icons.place),
                              onPressed: () async {
                                context.read<MapCubit>().animateToMyLocation();
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    // Always return a widget
                    return const SizedBox.shrink();
                  },
                ),
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    size: 100,
                    text: 'السابق',
                    colorText: Colors.black,
                    color: Colors.white,
                  ),
                  CustomButton(
                    size: 150,
                    text: 'حفظ واستكمال',
                    onTap: () {
                      Navigator.pushNamed(context, 'selectPackage');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
