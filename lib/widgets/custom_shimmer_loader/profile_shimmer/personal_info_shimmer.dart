import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';

class PersonalInfoShimmer extends StatelessWidget {
  const PersonalInfoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Shimmer for profile image
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.grayHighforshimmer,
          ),
        ),
        30.sbw,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmer for user name
              Container(
                height: size.width * 0.045,
                width: size.width * 0.4,
                color: AppColors.grayHighforshimmer,
                margin: const EdgeInsets.only(bottom: 8),
              ),
              // Shimmer for location (city, state, country)
              Container(
                height: size.width * 0.035,
                width: size.width * 0.6,
                color: AppColors.grayHighforshimmer,
                margin: const EdgeInsets.only(bottom: 8),
              ),
              // Shimmer for company name
              Container(
                height: size.width * 0.035,
                width: size.width * 0.5,
                color: AppColors.grayHighforshimmer,
                margin: const EdgeInsets.only(bottom: 8),
              ),
              // Shimmer for plan
              Container(
                height: size.width * 0.035,
                width: size.width * 0.3,
                color: AppColors.grayHighforshimmer,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
