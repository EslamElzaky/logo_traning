import 'package:flutter/material.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_navigation_bottom.dart';

class StaticMapPage extends StatelessWidget {
  final double lat = 24.7136; // خط العرض
  final double lng = 46.6753; // خط الطول
  final String apiKey = "YOUR_GOOGLE_MAPS_API_KEY";

  @override
  Widget build(BuildContext context) {
    // String url

    return Scaffold(
      appBar: AppBar(title: const Text("خريطة ثابتة")),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // شكل دائري/مستطيل
          child: Image.network(""),
        ),
      ),
    );
  }
}

class SelectLocationAtmaps extends StatelessWidget {
  const SelectLocationAtmaps({super.key});
  static String id = 'selectLocationMaps';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/download.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
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
    );
  }
}
