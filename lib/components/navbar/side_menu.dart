import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stpaulanglicanchurh/controllers/controller.dart';
import '../../../../constant.dart';

class SideMenu extends StatelessWidget {
  MenuController _controller = Get.put(MenuController(), tag: '_SideMenuKey');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: primaryColor,
        child: Obx(
          () => ListView(
            children: [
              DrawerHeader(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Image.asset(
                    'assets/logos/logo1.png',
                    height: 35,
                    width: 50,
                    fit: BoxFit.scaleDown,
                    color: Colors.white,
                  ),
                ),
              ),
              ...List.generate(
                _controller.menuItems.length,
                (index) => DrawerItem(
                  isActive: index == _controller.selectedIndex,
                  title: _controller.menuItems[index],
                  press: () {
                    _controller.setMenuIndex(index);
                    Navigator.popAndPushNamed(
                        context, _controller.route[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
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