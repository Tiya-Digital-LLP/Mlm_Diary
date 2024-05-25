import 'package:get/get.dart';

class AuthController extends GetxController {
  var apiToken = ''.obs;

  void setApiToken(String token) {
    apiToken.value = token;
  }
}
