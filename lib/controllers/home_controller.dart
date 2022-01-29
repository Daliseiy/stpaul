import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  navigateToPage(int index) {
    if (index == 0) {
      Get.toNamed('about');
    } else if (index == 1) {
      Get.toNamed('give');
    }
  }
}
