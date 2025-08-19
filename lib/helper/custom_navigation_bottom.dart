
  import 'package:flutter/material.dart';

Padding BottomBar() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: BottomNavigationBar(
        backgroundColor: Colors.grey[400],
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(
            icon: circleIcon(Colors.blueGrey),
            activeIcon: circleIcon(Colors.black),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: circleIcon(Colors.blueGrey),
            activeIcon: circleIcon(Colors.black),
            label: "تعاقداتي",
          ),
          BottomNavigationBarItem(
            icon: circleIcon(Colors.blueGrey),
            activeIcon: circleIcon(Colors.black),
            label: 'طلباتي',
          ),
          BottomNavigationBarItem(
            icon: circleIcon(Colors.blueGrey),
            activeIcon: circleIcon(Colors.black),
            label: "العروض",
          ),
          BottomNavigationBarItem(
            icon: circleIcon(Colors.blueGrey),
            activeIcon: circleIcon(Colors.black),
            label: "اتصل بنا",
          ),
        ],
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