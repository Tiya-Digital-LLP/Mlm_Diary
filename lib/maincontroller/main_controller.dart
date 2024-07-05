import 'package:get/get.dart';

class NavigationController extends GetxController {
  var isNavigating = false.obs;

  void setNavigating(bool value) {
    isNavigating.value = value;
  }
}
