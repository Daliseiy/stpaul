import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MenuController extends GetxController {
  RxInt _selectedIndex = 0.obs;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int get selectedIndex => _selectedIndex.value;
  List<String> get menuItems => ['Home', 'Projects', 'About Us'];
  List<String> get route => ['home', 'projects', 'about'];
  GlobalKey<ScaffoldState> get scaffoldkey => _scaffoldKey;

  void openOrCloseDrawer() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void disposeKey() {
    _scaffoldKey.currentState!.dispose();
  }

  void setMenuIndex(int index) {
    _selectedIndex.value = index;
  }
}