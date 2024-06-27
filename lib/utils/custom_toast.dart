import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:toastification/toastification.dart';

class CustomToast extends StatelessWidget {
  final String message;
  final VoidCallback onClose;

  const CustomToast({
    super.key,
    required this.message,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 10,
            width: 1,
            color: Colors.green,
          ),
          SvgPicture.asset(
            Assets.svgFail,
            width: 24.0,
            height: 24.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onClose,
            child: const Icon(
              Icons.cancel_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

// verified with border
void showToastverifedborder(
  String message,
) {
  toastification.show(
    alignment: Alignment.bottomCenter,
    backgroundColor: AppColors.white,
    type: ToastificationType.success,
    style: ToastificationStyle.flatColored,
    showProgressBar: false,
    autoCloseDuration: const Duration(seconds: 3),
    icon: Image.asset(
      Assets.imagesChecked,
      height: 30,
    ),
    closeOnClick: true,
    primaryColor: Colors.green,
    title: Text(message),
  );
}

// error with border
void showToasterrorborder(
  String message,
) {
  toastification.show(
    alignment: Alignment.bottomCenter,
    backgroundColor: AppColors.white,
    type: ToastificationType.error,
    style: ToastificationStyle.flatColored,
    showProgressBar: false,
    autoCloseDuration: const Duration(seconds: 3),
    icon: Image.asset(
      Assets.imagesCancel,
      height: 35,
    ),
    primaryColor: Colors.red,
    title: Text(message),
  );
}
