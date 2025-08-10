import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // اسم المستخدم
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'محمد مصطفى',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // لون النص
                ),
              ),
            ),

            // رصيد المحفظة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'رصيد المحفظة',
                      style: TextStyle(color: Colors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          '80,228.58 ريال',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.copy, size: 16, color: Colors.black),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // العناصر
            Expanded(
              child: ListView(
                children: [
                  _buildDrawerItem('لوحة المعلومات', Icons.dashboard),
                  _buildDrawerItem('الإشعارات', Icons.notifications),
                  _buildDrawerItem('تعليقاتي', Icons.comment),
                  _buildDrawerItem('طلباتي', Icons.shopping_bag),
                  _buildDrawerItem('طلبات الأفراد', Icons.group),
                  _buildDrawerItem('زياراتي', Icons.location_on),
                  _buildDrawerItem('تذاكر الدعم والمساعدة', Icons.support_agent),
                  _buildDrawerItem('اتصل بنا', Icons.call),
                  _buildDrawerItem('English', Icons.language),
                  _buildDrawerItem('تسجيل الخروج', Icons.logout),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.black), // لون الأيقونة
      title: Text(
        title,
        style: TextStyle(color: Colors.black), // لون النص
      ),
      onTap: () {
        // اضف التنقل أو الأوامر هنا
      },
    );
  }
}
