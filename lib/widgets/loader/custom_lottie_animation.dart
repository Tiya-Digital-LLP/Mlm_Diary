import 'package:flutter/material.dart';

class CustomLottieAnimation extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final BoxFit fit;

  const CustomLottieAnimation({
    super.key,
    required this.child,
    this.width = 100,
    this.height = 100,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FittedBox(
        fit: fit,
        child: child,
      ),
    );
  }
}
