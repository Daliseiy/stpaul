import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stpaulanglicanchurh/controllers/controller.dart';
import '../../../../constant.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xff001242),
        child: ListView(
          children: [
            DrawerHeader(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/icons/cathedral.png',
                      height: 32,
                      fit: BoxFit.scaleDown,
                      color: Colors.white,
                    ),
                    Text(
                      'St Paul\'s Anglican Church',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: defaultPadding + 8,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: defaultPadding),
              onTap: () => Navigator.pushNamed(context, 'home'),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: defaultPadding),
              onTap: () => Navigator.pushNamed(context, 'about'),
              title: Text(
                'About',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: defaultPadding),
              onTap: () => Navigator.pushNamed(context, 'give'),
              title: Text(
                'Give',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  navigate(int index) {
    if (index == 0) {
      Get.toNamed('about');
    } else if (index == 1) {
      Get.toNamed('give');
    }
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback press;

  const DrawerItem({
    Key? key,
    required this.title,
    required this.isActive,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: defaultPadding),
        selected: isActive,
        selectedTileColor: primaryColor,
        onTap: press,
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
