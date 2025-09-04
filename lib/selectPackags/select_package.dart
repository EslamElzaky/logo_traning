import 'package:flutter/material.dart';
import 'package:logo_app_traning/helper/custom_app_bar.dart';
import 'package:logo_app_traning/helper/custom_button.dart';
import 'package:logo_app_traning/helper/custom_card_package.dart';
import 'package:logo_app_traning/helper/custom_navigation_bottom.dart';
import 'package:logo_app_traning/selectPackags/custom_container_item.dart';

class Selectpackage extends StatefulWidget {
  const Selectpackage({super.key});
  static String id = 'selectPackage';

  @override
  State<Selectpackage> createState() => _SelectpackageState();
}

class _SelectpackageState extends State<Selectpackage> {
  final List<String> countries = [
    'الفلبين',
    'اندونيسيا',
    'بنجلاديش',
    'باكستان',
    'تايلاند',
    'الهند',
    'الصين',
    'السودان',
    'اوزباكستان',
    'استراليا',
    'اثيوبيا',
    'غانا',
  ];
  final List<String> time = ['صباحي', 'مسائي'];
  final List<String> package = [
    'شهر',
    'شهرين',
    '3 شهور',
    '6 شهور',
    'سنه',
    'سنه ونصف',
    ' سنتان',
  ];

  int selectedIndex = 0;
  bool isHoursFour = true;
  bool isMorning = true;
  bool isVisited = true;
  int selectedpackage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        text: 'اختار باقتك',
        icon: Icons.notifications,
        backeIcon: Icons.arrow_back,
      ),
      floatingActionButton: Container(
        height: 105,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffFFFFFF),
              Color(0xFFFFFFFF).withValues(alpha: .5),
              Color(0xFFFFFFff).withValues(alpha: 0),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),

        child: Align(
          alignment: Alignment.bottomCenter,
          child: CustomButton(
            size: 250,
            text: 'صمم باقة تناسبك',
            onTap: () {
              Navigator.pushNamed(context, 'selectOver');
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الجنسيه',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: ContainerItem(
                        text: countries[index],
                        isSelected: selectedIndex == index,
                      ),
                    );
                  },
                ),
              ),

              Text(
                'الفترة',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMorning = true;
                        });
                      },
                      child: ContainerItem(
                        text: 'صباحي',
                        isSelected: isMorning,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMorning = false;
                        });
                      },
                      child: ContainerItem(
                        text: 'مسائي',
                        isSelected: !isMorning,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'مواعيد التوصيل',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'الفتره الصباحية : من 8 ص الي 5 م',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      ' الفتره المسائية : من 5 م الي 9 م',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'عدد الساعات',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isHoursFour = true;
                      });
                    },
                    child: ContainerItem(
                      text: '   4 ساعة',
                      isSelected: isHoursFour,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isHoursFour = false;
                      });
                    },
                    child: ContainerItem(
                      text: '  8 ساعة',
                      isSelected: !isHoursFour,
                    ),
                  ),
                ],
              ),
              Text(
                'توقيت الزياره',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisited = true;
                      });
                    },
                    child: ContainerItem(
                      text: "من 8ص الي 10ص",
                      isSelected: isVisited,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisited = false;
                      });
                    },
                    child: ContainerItem(
                      text: " من10ص الي 12ص",
                      isSelected: !isVisited,
                    ),
                  ),
                ],
              ),
              Text(
                'مدة الباقة',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: package.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedpackage = index;
                        });
                      },
                      child: ContainerItem(
                        text: package[index],
                        isSelected: selectedpackage == index,
                      ),
                    );
                  },
                ),
              ),
              PackageItem(
                title: "بـاقة زيارة واحدة أسبوعيًا لمدة 3 شهور",
                oldPrice: "12,800.00 ريال",
                newPrice: "9,800.00 ريال",
              ),
              PackageItem(
                title: "بـاقة زيارة واحدة أسبوعيًا لمدة 6 شهور",
                oldPrice: "25,600.00 ريال",
                newPrice: "19,600.00 ريال",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
