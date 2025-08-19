import 'package:flutter/material.dart';
import 'package:logo_app_traning/generated/l10n.dart';
import 'package:logo_app_traning/helper/custom_drawr.dart';
import 'package:logo_app_traning/helper/custom_navigation_bottom.dart';
import 'package:logo_app_traning/helper/custom_view_item.dart';
import 'package:logo_app_traning/views/home_view.dart';

class ServiceHoure extends StatefulWidget {
  const ServiceHoure({super.key});
  static String id = 'serviceHoure';
  @override
  State<ServiceHoure> createState() => _ServiceHoureState();
}

class _ServiceHoureState extends State<ServiceHoure> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomBar(),
      drawer: CustomDrawer(),
      appBar: AppBar(
      
        title: Text(
          'اختر الخدمه',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.notifications, size: 35),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اختر الخدمه المطلوبه',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),

            SizedBox(height: 10),
            ViewItems(titel: "عامله تنظيف", subtitel: "تقدم الخدمة بعقودشهريه من شهرالي24شهر"),
            SizedBox(height: 20),
            ViewItems(titel:  "عامله تنظيف بالمواد المطلوبة", subtitel: "تقدم الخدمة بعقودشهريه من شهرالي24شهر"),
          ],
        ),
      ),
    );
  }
}
