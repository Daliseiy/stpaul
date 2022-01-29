import 'package:get/get.dart';
import 'package:stpaulanglicanchurh/controllers/home_controller.dart';
import 'package:stpaulanglicanchurh/screens/about/about.dart';
import 'package:stpaulanglicanchurh/screens/home/home.dart';
import 'package:stpaulanglicanchurh/screens/projects/projects.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(),
    );
  }
}

class AppPages {
  AppPages._();

  static const INITIAL = 'home';

  static final routes = [
    GetPage(
      name: 'home',
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: 'about',
      page: () => AboutPage(),
    ),
    GetPage(
      name: 'give',
      page: () => ProjectPage(),
    ),
  ];
}
