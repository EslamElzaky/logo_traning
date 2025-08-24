import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:logo_app_traning/generated/l10n.dart';
import 'package:logo_app_traning/helper/custom_drawr.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logo_app_traning/helper/custom_navigation_bottom.dart';
import 'package:logo_app_traning/helper/custom_view_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static String id = 'homeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int sliderIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        title: Text(
          S.of(context).titel_home,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: [_sliderItem(), _sliderItem(), _sliderItem()],
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      sliderIndex = index;
                    });
                    log('$sliderIndex');
                  },
                  height: 190,
                  enlargeFactor: 0.5,
                  viewportFraction: 1,
                  // autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: index == sliderIndex
                        ? circleIcon(Colors.grey)
                        : circleIcon(),
                  );
                }),
              ),
              SizedBox(height: 10),
              Text(
                "خدماتنا المميزة",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                "مجموعة خدمات لا غنى عنها",
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),

              SizedBox(height: 10),
              ViewItems(
                onTap: () {
                  Navigator.pushNamed(context, 'serviceHoure');
                },
                titel: 'خدمة بالساعه',
                subtitel: 'خدمات منزليه بنظام الساعات ',
              ),
              SizedBox(height: 20),
              ViewItems(
                titel: 'خدمة مقيمة',
                subtitel: 'نظام الباقات الشهرية والسنوية ',
              ),
              SizedBox(height: 40),
              Center(
                child: Text(
                  'نسعد بتواصلكم معنا من خلال',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  socialIcon(FontAwesomeIcons.facebook, () {}),
                  socialIcon(FontAwesomeIcons.whatsapp, () {}),
                  socialIcon(FontAwesomeIcons.instagram, () {}),
                  socialIcon(FontAwesomeIcons.tiktok, () {}),
                  socialIcon(FontAwesomeIcons.linkedinIn, () {}),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  Container _sliderItem() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image, size: 60, color: Colors.grey[700]),
            Text(
              'صوره مصصممه خصيصا للعروض',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget circleIcon([Color? color]) {
    return Container(
      height: 18,
      width: 18,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  Widget socialIcon(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        heroTag: null,
        onPressed: onPressed,
        backgroundColor: Colors.grey[300],
        elevation: 1,
        mini: true, // لو عايزها صغيرة
        child: Icon(icon, size: 30, color: Colors.black),
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(urlImage, fit: BoxFit.fill, width: double.infinity),
    ),
  );
}
