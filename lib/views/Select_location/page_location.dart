import 'package:flutter/material.dart';
import 'package:logo_app_traning/helper/custom_app_bar.dart';

class PageLocation extends StatelessWidget {
  const PageLocation({super.key});
  static String id = 'pageLocation';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        text: 'اختر العنوان',
        icon: Icons.notifications,
        backeIcon: Icons.arrow_back,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.pushNamed(context, 'selectLocation');
        },
        child: Icon(Icons.add),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(children: [
          
        ],
      ),
    );
  }
}
