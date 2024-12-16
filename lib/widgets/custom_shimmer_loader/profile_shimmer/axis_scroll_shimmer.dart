import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';

class AxisScrollShimmer extends StatelessWidget {
  final double width;

  const AxisScrollShimmer({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 30,
            width: width * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColors.grayHighforshimmer,
            ),
          ),
          20.sbw,
          Row(
            children: [
              _shimmerColumn(width),
              20.sbw,
              _shimmerColumn(width),
              20.sbw,
              _shimmerColumn(width),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shimmerColumn(double width) {
    return Column(
      children: [
        Container(
          height: 14,
          width: width * 0.1,
          color: AppColors.grayHighforshimmer,
          margin: const EdgeInsets.only(bottom: 4),
        ),
        Container(
          height: 12,
          width: width * 0.15,
          color: AppColors.grayHighforshimmer,
        ),
      ],
    );
  }
}
