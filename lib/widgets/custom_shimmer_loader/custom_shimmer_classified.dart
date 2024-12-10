import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';

class CustomShimmerClassified extends StatelessWidget {
  final double width;
  final double height;

  const CustomShimmerClassified({
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: User image and name
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.grayHighforshimmer,
                    ),
                    10.sbw,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 14,
                            width: width * 0.4,
                            color: AppColors.grayHighforshimmer,
                            margin: const EdgeInsets.only(bottom: 8),
                          ),
                          Container(
                            height: 12,
                            width: width * 0.3,
                            color: AppColors.grayHighforshimmer,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                // Post title
                Container(
                  height: 14,
                  width: width * 0.8,
                  color: AppColors.grayHighforshimmer,
                  margin: const EdgeInsets.only(bottom: 8),
                ),
                // Post caption
                Container(
                  height: 12,
                  width: width * 0.9,
                  color: AppColors.grayHighforshimmer,
                  margin: const EdgeInsets.only(bottom: 8),
                ),
                Container(
                  height: 12,
                  width: width * 0.7,
                  color: AppColors.grayHighforshimmer,
                ),
                SizedBox(height: height * 0.02),
                // Post image
                Container(
                  height: height * 0.26,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.grayHighforshimmer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(height: height * 0.02),
                // Bottom row: Likes, comments, views, and actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            color: AppColors.grayHighforshimmer,
                            shape: BoxShape.circle,
                          ),
                        ),
                        10.sbw,
                        Container(
                          height: 12,
                          width: width * 0.1,
                          color: AppColors.grayHighforshimmer,
                        ),
                        15.sbw,
                        Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            color: AppColors.grayHighforshimmer,
                            shape: BoxShape.circle,
                          ),
                        ),
                        10.sbw,
                        Container(
                          height: 12,
                          width: width * 0.1,
                          color: AppColors.grayHighforshimmer,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            color: AppColors.grayHighforshimmer,
                            shape: BoxShape.circle,
                          ),
                        ),
                        10.sbw,
                        Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            color: AppColors.grayHighforshimmer,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
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
