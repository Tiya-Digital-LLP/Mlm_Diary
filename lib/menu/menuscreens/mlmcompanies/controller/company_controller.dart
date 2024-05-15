import 'dart:async';

import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class CompanyController extends GetxController {
  var isLiked = false.obs;
  var likeCount = 0.obs;
// FIELDS ERROR

  // ENABLED TYPING VALIDATION

  // RxBool isEmailOtpTyping = false.obs;

  // READ ONLY FIELDS

  void toggleLike() {
    isLiked.value = !isLiked.value;
    if (isLiked.value) {
      likeCount.value++;
    } else {
      likeCount.value--;
    }
  }

  final RxInt timerValue = 30.obs;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerValue.value > 0) {
        timerValue.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    timerValue.value = 30;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
