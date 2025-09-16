import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logo_app_traning/Maps/cubit/map_cubit.dart';
import 'package:logo_app_traning/helper/api_servic.dart';
import 'package:logo_app_traning/helper/custom_app_bar.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_dropdown.dart';
import 'package:logo_app_traning/helper/custom_navigation_bottom.dart';
import 'package:logo_app_traning/helper/custom_snack_bar.dart';
import 'package:logo_app_traning/helper/custom_text_field.dart';
import 'package:logo_app_traning/views/Select_location/EnterLocation/cubit/manage_location_cubit.dart';

class SelectLocaction extends StatelessWidget {
  const SelectLocaction({super.key});
  static String id = 'selectLocation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        text: 'اختار عنوان جديد',
        icon: Icons.notifications,
        backeIcon: Icons.arrow_back,
      ),
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => ManageLocationCubit()..loadTitelData(),
        child: BlocConsumer<ManageLocationCubit, ManageLocationState>(
          listenWhen: (previous, current) =>
              previous.message != current.message ||
              previous.selectedCity?.id != current.selectedCity?.id ||
              previous.selectedDistrict?.id != current.selectedDistrict?.id,
          listener: (context, state) {
            if (state.status == LocationStatus.failure &&
                state.message != null) {
              showSnackBar(state.message!, Colors.amberAccent);
            } else if (state.status == LocationStatus.success &&
                state.message != null) {
              showSnackBar(
                state.message!,
                const Color.fromRGBO(76, 175, 80, 1),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<ManageLocationCubit>();

            return Stack(
              children: [
                // المحتوى الأساسي
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CustomDropdownField(
                          menuMaxHeight: 300,
                          items: state.cities
                              .map((city) => city.value ?? "")
                              .toSet()
                              .toList(),
                          labelText: "اختر المدينه",
                          isEnabled: true,
                          value: state.selectedCity?.value,
                          onChanged: (value) async {
                            final city = state.cities.firstWhere(
                              (c) => c.value == value,
                            );
                            cubit.selectCity(city);
                            if (city.id != null) {
                              await cubit.validateCity(city.id!);
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        CustomDropdownField(
                          isEnabled: true,
                          labelText: "اختر الحي",
                          items: state.selectedCity == null
                              ? []
                              : state.districts.isEmpty
                              ? ["لا يوجد أحياء في هذه المدينة"]
                              : state.districts
                                    .map((district) => district.value ?? "")
                                    .toSet()
                                    .toList(),
                          value: state.selectedCity == null
                              ? null
                              : state.districts.isEmpty
                              ? "لا يوجد أحياء في هذه المدينة"
                              : (state.districts.any(
                                      (d) =>
                                          d.value ==
                                          state.selectedDistrict?.value,
                                    )
                                    ? state.selectedDistrict?.value
                                    : null),
                          onChanged: (value) async {
                            if (state.districts.isEmpty) return;
                            final district = state.districts.firstWhere(
                              (d) => d.value == value,
                            );
                            cubit.selectDistrict(district);
                            if (district.id != null) {
                              await cubit.validateDistrict(district.id!);
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        CustomDropdownField(
                          menuMaxHeight: 200,
                          items: state.houseTypes
                              .map((house) => house.value ?? "")
                              .toList(),
                          labelText: "نوع المنزل",
                          isEnabled: true,
                          value: state.selectedHouseType?.value,
                          onChanged: (value) {
                            final type = state.houseTypes.firstWhere(
                              (h) => h.value == value,
                              orElse: () => state.houseTypes.first,
                            );
                            cubit.selectHouseType(type);
                          },
                        ),
                        SizedBox(height: 15),
                        if (state.selectedHouseType?.value == "عمارة") ...[
                          CustomDropdownField(
                            items: state.houseFloors
                                .map((floor) => floor.value ?? "")
                                .toList(),
                            labelText: 'رقم الطابق',
                            isEnabled: true,
                            value: state.selectedHouseFloor?.value,
                            onChanged: (value) {
                              final floor = state.houseFloors.firstWhere(
                                (f) => f.value == value,
                                orElse: () => state.houseFloors.first,
                              );
                              cubit.selectHouseFloor(floor);
                            },
                          ),
                          SizedBox(height: 15),
                          CustomFormTextField(
                            labelText: 'رقم الشقه',
                            hintText: 'رقم الشقه',
                          ),
                        ],
                        SizedBox(height: 15),
                        CustomFormTextField(
                          labelText: 'معلم اومكان مميز قريب من عنوانك',
                          hintText: 'معلم اومكان مميز قريب من عنوانك',
                          maxLines: 4,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              size: 100,
                              text: 'السابق',
                              color: Colors.white,
                              colorText: Colors.black,
                            ),
                            CustomButton(
                              size: 100,
                              text: 'التالي',
                              onTap: () async {
                                final districtId = context
                                    .read<ManageLocationCubit>()
                                    .state
                                    .selectedDistrict
                                    ?.id;
                                log("dddddd$districtId");
                                context.read<MapCubit>().loadPolygon(
                                  districtId!,
                                );
                                Navigator.pushNamed(
                                  context,
                                  'selectLocationMaps',
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Full-screen loading overlay
                if (state.status == LocationStatus.loading)
                  AbsorbPointer(
                    absorbing: true,
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
