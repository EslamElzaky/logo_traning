import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logo_app_traning/helper/api_servic.dart';
import 'package:logo_app_traning/helper/custom_app_bar.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_dropdown.dart';
import 'package:logo_app_traning/helper/custom_navigation_bottom.dart';
import 'package:logo_app_traning/helper/custom_snack_bar.dart';
import 'package:logo_app_traning/helper/custom_text_field.dart';
import 'package:logo_app_traning/views/Select_location/EnterLocation/cubit/manage_location_cubit.dart';
import 'package:logo_app_traning/views/Select_location/EnterLocation/enter_location_model_city.dart';

class SelectLocaction extends StatelessWidget {
  const SelectLocaction({super.key});
  static String id = 'selectLocation';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageLocationCubit()..loadTitelData(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<ManageLocationCubit, ManageLocationState>(
            listener: (context, state) {
              if (state is ManageLocationFailure) {
                showSnackBar(state.message, Colors.amberAccent);
              }
            },
            builder: (context, state) {
              if (state is ManageLocationLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ManageLocationSuccess) {
                final cubit = context.read<ManageLocationCubit>();

                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: customAppBar(
                    text: 'اختار عنوان جديد',
                    icon: Icons.notifications,
                    backeIcon: Icons.arrow_back,
                  ),
                  body: SingleChildScrollView(
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
                            value: state.selectedCity?.value,
                            onChanged: (value) async {
                              final city = state.cities.firstWhere(
                                (c) => c.value == value,
                              );
                              if (city.id == null) return;
                            
                              cubit.selectCity(city);
                            },
                          ),
                          SizedBox(height: 15),
                          CustomDropdownField(
                            items: state.selectedCity == null
                                ? []
                                : state.districts.isEmpty
                                ? ["لا يوجد أحياء في هذه المدينة"]
                                : state.districts
                                      .map((district) => district.value ?? "")
                                      .toList(),
                            labelText: "اختر الحي",
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
                                orElse: () => state.districts.first,
                              );
                              if (district.id == null) return;
                              
                              cubit.selectDistrict(district);
                            },
                          ),
                          SizedBox(height: 15),
                          CustomDropdownField(
                            menuMaxHeight: 200,
                            items: state.houseTypes
                                .map((house) => house.value ?? "")
                                .toList(),
                            labelText: "نوع المنزل",
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
                                onTap: () {
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
                  bottomNavigationBar: BottomBar(),
                );
              } else if (state is ManageLocationFailure) {
                return Center(child: Text(state.message));
              }
              return SizedBox();
            },
          );
        },
      ),
    );
  }
}
