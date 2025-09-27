import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logo_app_traning/Maps/cubit/map_cubit.dart';
import 'package:logo_app_traning/helper/custom_app_bar.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_navigation_bottom.dart';
import 'package:logo_app_traning/views/Select_location/EnterLocation/cubit/manage_location_cubit.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;

class SelectLocationAtmaps extends StatelessWidget {
  const SelectLocationAtmaps({super.key});
  static String id = 'selectLocationMaps';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    final apartmentNo = args?["apartmentNo"];
    final description = args?["description"];
    return Scaffold(
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
                    print(
                      "عدد البوليغونات بعد التحديث: ${state.polygons.length}",
                    );
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: GoogleMap(
                            polygons: state.polygons,
                            initialCameraPosition: state.myCameraPosition!,
                            mapType: MapType.normal,
                            zoomControlsEnabled: false,
                            myLocationButtonEnabled: false,
                            onMapCreated: (GoogleMapController controller) {
                              context.read<MapCubit>().setMapController(
                                controller,
                              );
                            },
                            markers: state.markers,
                            onTap: (LatLng pos) {
                              bool isInside = false;
                              for (var polygon in state.polygons) {
                                final polyPoints = polygon.points
                                    .map(
                                      (p) => mp.LatLng(p.latitude, p.longitude),
                                    )
                                    .toList();

                                if (mp.PolygonUtil.containsLocation(
                                  mp.LatLng(pos.latitude, pos.longitude),
                                  polyPoints,
                                  true, // البوليغون مغلق
                                )) {
                                  isInside = true;
                                  break;
                                }
                              }
                              if (isInside) {
                                context.read<MapCubit>().addMarker(pos);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "المكان الذي اخترته خارج المنطقة المحددة",
                                    ),
                                    backgroundColor: Colors.yellowAccent,
                                  ),
                                );
                              }
                            },
                            // onTap: (LatLng pos) {
                            //   context.read<MapCubit>().addMarker(pos);
                            // },
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
                  onTap: () async {
                    final mapState = context.read<MapCubit>().state;

                    if (mapState.markers.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("من فضلك حدد موقعك على الخريطة"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    final pos = mapState.markers.last.position;

                    await context.read<ManageLocationCubit>().saveAddress(
                      apartmentNo: apartmentNo,
                      description: description,
                      pos,
                    );
                    Navigator.pushNamed(context, 'selectPackage');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
