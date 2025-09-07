import 'dart:convert';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:logo_app_traning/views/HomePage/home_service_model.dart';
import 'package:logo_app_traning/views/HomePage/home_slider_model.dart';
import 'package:logo_app_traning/generated/l10n.dart';
import 'package:logo_app_traning/helper/api_servic.dart';
import 'package:logo_app_traning/helper/custom_app_bar.dart';
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
  List<HomeSliderModel> sliders = [];
  List<HomeServiceModel> services = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSliders();
    fetchService();
  }

  Future<void> fetchSliders() async {
    try {
      final response = await ApiService().getSlider();
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        log("Data JSON: ${jsonEncode(body["data"])}");
        // الـ data اللي جوا الـ json
        final List<dynamic> data = body["data"];

        setState(() {
          sliders = data.map((e) => HomeSliderModel.fromJson(e)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        log("Failed to load sliders: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      log("Error: $e");
    }
  }

  Future<void> fetchService() async {
    try {
      final response = await ApiService().getService();
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List<dynamic> data = body["data"];

        setState(() {
          services = data.map((e) => HomeServiceModel.fromJson(e)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        log("Failed to load sliders: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      log("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      appBar: customAppBar(
        text: S.of(context).titel_home,
        icon: Icons.notifications,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : sliders.isEmpty
          ? _buildOldHomeContent()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      items: sliders.map((slider) {
                        return _sliderItem(slider: slider);
                      }).toList(),
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            sliderIndex = index;
                          });
                          log('$sliderIndex');
                        },
                        height: 190,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        autoPlay: true,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(sliders.length, (index) {
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
                    Column(
                      children: services.map((service) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ViewItems(
                            titel: service.name ?? "بدون اسم",
                            subtitel: service.description ?? "",
                            imageUrl: service.iconUrl ?? "",
                            onTap: () {
                              // تقدر تحدد الصفحة حسب id
                              Navigator.pushNamed(context, 'serviceHoure');
                            },
                          ),
                        );
                      }).toList(),
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

  Container _sliderItem({HomeSliderModel? slider}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: slider?.image != null
            ? Image.network(
                slider!.image!,
                fit: BoxFit.cover,
                width: double.infinity,
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, size: 60, color: Colors.grey[700]),
                    Text(
                      slider?.name ?? "صوره مصممه للعروض ",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
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
        mini: true,
        child: Icon(icon, size: 30, color: Colors.black),
      ),
    );
  }

  // ==============================
  Widget _buildOldHomeContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: [_sliderItem(), _sliderItem(), _sliderItem()],
              options: CarouselOptions(
                height: 190,
                viewportFraction: 1,
                enlargeCenterPage: true,
                autoPlay: true,
                enlargeFactor: 0.5,
                onPageChanged: (index, reason) {
                  setState(() {
                    sliderIndex = index;
                  });
                  log('$sliderIndex');
                },
              ),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 10),
            const Text(
              "خدماتنا المميزة",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Text(
              "مجموعة خدمات لا غنى عنها",
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            ViewItems(
              imageUrl: '',
              onTap: () {
                Navigator.pushNamed(context, 'serviceHoure');
              },
              titel: 'خدمة بالساعه',
              subtitel: 'خدمات منزليه بنظام الساعات ',
            ),
            const SizedBox(height: 20),
            ViewItems(
              imageUrl: '',
              titel: 'خدمة مقيمة',
              subtitel: 'نظام الباقات الشهرية والسنوية ',
            ),
            const SizedBox(height: 40),
            const Center(
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
    );
  }
}
