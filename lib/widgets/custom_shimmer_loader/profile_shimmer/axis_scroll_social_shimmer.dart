import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AxisScrollSocialShimmer extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsetsGeometry? margin;

  const AxisScrollSocialShimmer({
    super.key,
    required this.width,
    required this.height,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
