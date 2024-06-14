import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onDelete;

  const LogoutDialog({super.key, required this.onDelete});

  static void show(BuildContext context, VoidCallback onDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutDialog(onDelete: onDelete);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.cancel_outlined,
                size: 80,
                color: AppColors.redText,
              ),
            ),
          ),
          16.sbh,
          Column(
            children: [
              Text(
                'Are you sure?',
                style: textStyleW700(
                  size.width * 0.040,
                  AppColors.blackText,
                ),
              ),
              5.sbh,
              Text(
                'Do you want to delete',
                style: textStyleW400(
                  size.width * 0.035,
                  AppColors.blackText,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Cancel',
                          style: textStyleW700(
                              size.width * 0.035, AppColors.blackText),
                        ),
                      ),
                    ),
                    5.sbw,
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.redText,
                          shadowColor: AppColors.redText,
                          elevation: 3,
                        ),
                        onPressed: () {
                          onDelete();
                          Get.back();
                        },
                        child: Text(
                          'Delete',
                          style: textStyleW700(
                              size.width * 0.035, AppColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
