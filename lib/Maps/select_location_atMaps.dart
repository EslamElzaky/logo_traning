import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logo_app_traning/Maps/cubit/map_cubit.dart';
import 'package:logo_app_traning/helper/custom_app_bar.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_navigation_bottom.dart';

class SelectLocationAtmaps extends StatelessWidget {
  SelectLocationAtmaps({super.key});
  static String id = 'selectLocationMaps';
  Polygon polygon = Polygon(
    strokeWidth: 1,
    polygonId: PolygonId('1'),
    fillColor: Colors.grey.withValues(alpha: .5),
    holes: [
      [
        LatLng(31.031520189427106, 31.39390700984557),
        LatLng(31.032592169677883, 31.384148985532846),
        LatLng(31.03645119866889, 31.380479301175928),
        LatLng(31.04016715284924, 31.39232237341872),
      ],
    ],
    points: [
      LatLng(31.041810701706908, 31.37330673629649),
      LatLng(31.05667281137016, 31.406584101266013),
      LatLng(31.030376730518313, 31.39782689995973),
      LatLng(31.026160107182132, 31.370971482620444),
    ],
  );

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
                              polygons: {polygon},
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
                            // : Center(
                            //     child: Container(
                            //       child: CircularProgressIndicator(color: Colors.black),
                            //     ),
                            //   ),
                            //  Image.asset(
                            //   'assets/images/download.png',
                            //   fit: BoxFit.cover,
                            //   width: double.infinity,
                            // ),
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
