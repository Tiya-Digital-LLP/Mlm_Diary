import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';

class CustomShimmerQuestion extends StatelessWidget {
  final double width;
  final double height;

  const CustomShimmerQuestion({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Top Row: User Image and Details
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Circle shimmer for user image
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.grayHighforshimmer,
                    ),
                  ),
                  10.sbw,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Shimmer for user name
                        Container(
                          height: 14,
                          width: width * 0.5,
                          color: AppColors.grayHighforshimmer,
                          margin: const EdgeInsets.only(bottom: 8),
                        ),
                        // Shimmer for post time and text
                        Row(
                          children: [
                            Container(
                              height: 12,
                              width: width * 0.3,
                              color: AppColors.grayHighforshimmer,
                              margin: const EdgeInsets.only(right: 8),
                            ),
                            Container(
                              height: 12,
                              width: width * 0.3,
                              color: AppColors.grayHighforshimmer,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              10.sbh,
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 14,
                  width: width * 0.7,
                  color: AppColors.grayHighforshimmer,
                  margin: const EdgeInsets.only(bottom: 10),
                ),
              ),
              // Bottom Row: Like, Reply, Views, and Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Like button shimmer
                      Container(
                        height: 24,
                        width: 24,
                        color: AppColors.grayHighforshimmer,
                        margin: const EdgeInsets.only(right: 7),
                      ),
                      // Like count shimmer
                      Container(
                        height: 14,
                        width: width * 0.1,
                        color: AppColors.grayHighforshimmer,
                        margin: const EdgeInsets.only(right: 15),
                      ),
                      // Reply button shimmer
                      Container(
                        height: 24,
                        width: 24,
                        color: AppColors.grayHighforshimmer,
                        margin: const EdgeInsets.only(right: 7),
                      ),
                      // Reply count shimmer
                      Container(
                        height: 14,
                        width: width * 0.1,
                        color: AppColors.grayHighforshimmer,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Bookmark icon shimmer
                      Container(
                        height: 24,
                        width: 24,
                        color: AppColors.grayHighforshimmer,
                        margin: const EdgeInsets.only(right: 10),
                      ),
                      // Share icon shimmer
                      Container(
                        height: 24,
                        width: 24,
                        color: AppColors.grayHighforshimmer,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
