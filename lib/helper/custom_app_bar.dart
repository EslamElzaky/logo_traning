import 'package:flutter/material.dart';

class customAppBar extends StatelessWidget implements PreferredSizeWidget {
  const customAppBar({
    super.key,
    required this.text,
    required this.icon,
    this.backeIcon,
  });
  final String text;
  final IconData icon;
  final IconData? backeIcon;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.grey,
      leading: backeIcon != null
          ? IconButton(
              icon: Icon(backeIcon),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,

      actions: icon != null
          ? [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(icon, size: 35),
              ),
            ]
          : null,
    );
  }
}
