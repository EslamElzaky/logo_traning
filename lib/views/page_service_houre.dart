import 'package:flutter/material.dart';
import 'package:logo_app_traning/helper/custom_app_bar.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_drawr.dart';
import 'package:logo_app_traning/helper/custom_navigation_bottom.dart';
import 'package:logo_app_traning/helper/custom_view_item.dart';

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
      appBar: customAppBar(text: 'اختر الخدمه', icon: Icons.notifications),
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
            ViewItems(
              onTap: () {
                DialogView(context);
              },
              titel: "عامله تنظيف",
              subtitel: "تقدم الخدمة بعقودشهريه من شهرالي24شهر",
            ),
            SizedBox(height: 20),
            ViewItems(
              onTap: () {
                DialogView(context);
              },
              titel: "عامله تنظيف بالمواد المطلوبة",
              subtitel: "تقدم الخدمة بعقودشهريه من شهرالي24شهر",
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void DialogView(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          // title: Text('هذه الخدمه للعائلات فقط'),
          contentTextStyle: TextStyle(color: Colors.white),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/Layer 2.png', width: 56, height: 48),
              SizedBox(height: 20),
              Text(
                'هذه الخدمة تقدم للعائلات فقط',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                'نعتذر علي عدم تقديم الخدمه في حاله عدم وجود سيدة بالمنزل',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    size: 100,
                    color: Colors.white,
                    colorText: Colors.black,
                    text: 'رجوع',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  CustomButton(
                    size: 100,
                    text: 'التالي',
                    color: Colors.black,
                    onTap: () {
                      Navigator.pushNamed(context, 'pageLocation');
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
