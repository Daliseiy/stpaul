import 'package:flutter/material.dart';

import 'package:stpaulanglicanchurh/controllers/controller.dart';
import '../../constant.dart';
import '../../responsive.dart';
import 'web_menu.dart';

class NavBar extends StatelessWidget {
  final Color color;
  final MenuController controller;

  NavBar({Key? key, required this.color, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(maxWidth: 1000),
      //width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(
              onPressed: () {
                controller.openOrCloseDrawer();
              },
              icon: Icon(Icons.menu),
              color: Colors.white,
              iconSize: 32,
            ),
          SizedBox(
            width: defaultPadding,
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, 'home'),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/cathedral.png',
                  height: 32,
                ),
                Text(
                  'St Paul\'s Anglican Church',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Responsive.isDesktop(context)
                          ? defaultPadding * 1.7
                          : defaultPadding,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Spacer(),
          if (Responsive.isDesktop(context))
            WebMenu(
              color: color,
            ),
        ],
      ),
    );
  }
}
