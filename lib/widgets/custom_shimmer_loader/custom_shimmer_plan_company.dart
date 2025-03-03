import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';

class CustomShimmerPlanCompany extends StatelessWidget {
  final double width;
  final double height;

  const CustomShimmerPlanCompany({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        color: AppColors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: AppColors.grayHighforshimmer,
            highlightColor: AppColors.grayLightforshimmer,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.grayHighforshimmer,
                    ),
                    10.sbw,
                    Container(
                      height: 14,
                      width: width * 1.8,
                      color: AppColors.grayHighforshimmer,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
