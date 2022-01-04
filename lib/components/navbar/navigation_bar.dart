import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stpaulanglicanchurh/controllers/controller.dart';
import '../../constant.dart';
import '../../responsive.dart';
import 'web_menu.dart';

class NavigationBar extends StatelessWidget {
  final Color color;
  final MenuController controller;

  NavigationBar({Key? key, required this.color, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //constraints: BoxConstraints(maxWidth: 1000),
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(
              onPressed: () {
                controller.openOrCloseDrawer();
              },
              icon: Icon(Icons.menu),
              color: Colors.white,
            ),
          Text(
            'St Paul Anglican',
            style: TextStyle(color: Colors.white),
          ),
          /*
          Image.asset(
            'assets/logos/logo1.png',
            height: 35,
            width: 150,
            fit: BoxFit.fitHeight,
            color: Colors.white,
          ), */
          Spacer(),
          if (Responsive.isDesktop(context))
            WebMenu(
              color: color,
            ),
          Spacer(),
          ElevatedButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  elevation: 3.0,
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding)),
              child: Text('Give'))
        ],
      ),
    );
  }
}
