import 'package:flutter/material.dart';
import 'package:logo_app_traning/helper/custom_app_bar.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_dropdown.dart';
import 'package:logo_app_traning/helper/custom_navigation_bottom.dart';
import 'package:logo_app_traning/helper/custom_text_field.dart';

class SelectLocaction extends StatefulWidget {
  const SelectLocaction({super.key});
  static String id = 'selectLocation';
  @override
  State<SelectLocaction> createState() => _SelectLocactionState();
}

class _SelectLocactionState extends State<SelectLocaction> {
  @override
  Widget build(BuildContext context) {
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
                items: [
                  'الرياض',
                  'جده',
                  'مكه',
                  'المدينه',
                  'الدمام',
                  'الطائف',
                  'الخبر',
                  'اليرموك',
                  'حي الباديه',
                ],
                labelText: "اختر المدينه",
                value: null,
                onChanged: (value) {},
              ),
              SizedBox(height: 15),
              CustomDropdownField(
                items: [
                  'الرياض',
                  'جده',
                  'مكه',
                  'المدينه',
                  'الدمام',
                  'الطائف',
                  'الخبر',
                  'اليرموك',
                  'حي الباديه',
                ],
                labelText: "اختر الحي",
                value: null,
                onChanged: (value) {},
              ),
              SizedBox(height: 15),
              CustomDropdownField(
                items: [
                  'الرياض',
                  'جده',
                  'مكه',
                  'المدينه',
                  'الدمام',
                  'الطائف',
                  'الخبر',
                  'اليرموك',
                  'حي الباديه',
                ],
                labelText: "نوع المنزل",
                value: null,
                onChanged: (value) {},
              ),
              SizedBox(height: 15),
              CustomFormTextField(labelText: 'رقم المنزل'),
              SizedBox(height: 15),
              // Container(
              //   width: double.infinity,
              //   height: 200,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.black),
              //   ),
              // ),
              CustomFormTextField(
                labelText: 'معلم اومكان مميز قريب من عنوانك',
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
                      Navigator.pushNamed(context, 'selectLocationMaps');
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
  }
}
