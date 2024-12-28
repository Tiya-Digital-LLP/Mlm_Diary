import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/app_colors.dart';

class BorderContainer extends StatelessWidget {
  final Widget child;
  final bool isError;
  final bool byDefault;
  final double height;

  const BorderContainer({
    super.key,
    required this.child,
    this.isError = false,
    this.byDefault = true,
    this.height = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: byDefault
              // ignore: deprecated_member_use
              ? AppColors.containerBorder.withOpacity(0.4)
              : isError
                  ? AppColors.redText
                  : AppColors.greenBorder,
        ),
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: child,
    );
  }
}
