import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:shimmer/shimmer.dart';

class CustomGridItem extends StatelessWidget {
  const CustomGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(13.05),
        boxShadow: [
          BoxShadow(
            color: AppColors.boxShadowforshimmer,
            blurRadius: 16.32,
            offset: const Offset(0, 3.26),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          10.sbw,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.grayHighforshimmer,
                radius: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.grayHighforshimmer),
                ),
              ),
              10.sbh,
              Shimmer.fromColors(
                baseColor: AppColors.grayHighforshimmer,
                highlightColor: AppColors.grayLightforshimmer,
                child: Container(
                  width: 60,
                  height: 10,
                  color: AppColors.grayHighforshimmer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
