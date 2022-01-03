import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stpaulanglicanchurh/components/navbar/navigation_bar.dart';
import 'package:stpaulanglicanchurh/components/navbar/side_menu.dart';
import 'package:stpaulanglicanchurh/controllers/controller.dart';

import '../../responsive.dart';

class ProjectPage extends StatelessWidget {
  ProjectPage({Key? key}) : super(key: key);
  MenuController _controller = Get.put(
    MenuController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.scaffoldkey,
      drawer: !Responsive.isDesktop(context) ? SideMenu() : Drawer(),
      drawerEnableOpenDragGesture: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            NavigationBar(
              color: Colors.black,
              controller: _controller,
            )
          ],
        ),
      ),
    );
  }
}
