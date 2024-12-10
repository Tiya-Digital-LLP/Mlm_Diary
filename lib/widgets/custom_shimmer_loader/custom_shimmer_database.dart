import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mlmdiary/utils/app_colors.dart';

class ShimmerUserProfileCard extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerUserProfileCard({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
          baseColor: AppColors.grayHighforshimmer,
          highlightColor: AppColors.grayLightforshimmer,
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shimmer for user image
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: AppColors.grayHighforshimmer,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: width * 0.05),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Shimmer for user name
                        Container(
                          height: 14,
                          width: width * 0.4,
                          color: AppColors.grayHighforshimmer,
                          margin: const EdgeInsets.only(bottom: 8),
                        ),
                        // Shimmer for location
                        Container(
                          height: 12,
                          width: width * 0.3,
                          color: AppColors.grayHighforshimmer,
                          margin: const EdgeInsets.only(bottom: 8),
                        ),
                        // Shimmer for designation
                        Container(
                          height: 12,
                          width: width * 0.3,
                          color: AppColors.grayHighforshimmer,
                          margin: const EdgeInsets.only(bottom: 8),
                        ),
                        // Shimmer for plan text
                        Container(
                          height: 12,
                          width: width * 0.35,
                          color: AppColors.grayHighforshimmer,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Shimmer for "View Profile" text
                    Container(
                      height: 12,
                      width: width * 0.25,
                      color: AppColors.grayHighforshimmer,
                      margin: const EdgeInsets.only(right: 10),
                    ),
                    // Shimmer for arrow icon
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        color: AppColors.grayHighforshimmer,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
