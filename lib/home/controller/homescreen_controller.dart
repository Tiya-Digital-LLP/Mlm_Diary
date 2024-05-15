import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isSearchBarVisible = false.obs;

  void toggleSearchBarVisibility() {
    isSearchBarVisible.value = !isSearchBarVisible.value;
  }
}
