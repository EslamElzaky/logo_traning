import 'package:flutter/material.dart';
import 'package:logo_app_traning/helper/custom_app_bar.dart';
import 'package:logo_app_traning/helper/custom_dropdown.dart';

class SelectOver extends StatelessWidget {
  const SelectOver({super.key});
  static String id = 'selectOver';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        text: 'صمم عرضك',
        icon: Icons.notifications,
        backeIcon: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomDropdownField(
              items: [
                'سعوديه',
                'فليبين',
                'جيبوتيه',
                'استراليه',
                'يمنيه',
                'باكستانية',
                'هنديه',
                ' صينية',
              ],
              labelText: 'الجنسيه',
              value: null,
              onChanged: (value) {},
            ),
            SizedBox(height: 20),
            CustomDropdownField(
              items: [
                'شهر',
                'شهرين',
                '3 شهور',
                '6 شهور',
                'سنه',
                'سنه ونصف',
                ' سنتان',
              ],
              labelText: 'مدة العقد',
              value: null,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
