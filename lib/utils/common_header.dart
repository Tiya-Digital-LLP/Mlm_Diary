import 'package:flutter/material.dart';
import 'package:mlmdiary/generated/assets.dart';

class CommonHeader extends StatelessWidget {
  final Function onBackTap;
  const CommonHeader({super.key, required this.onBackTap});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top +
              size.height * 0.007 +
              size.height * 0.05,
        ),
        Image.asset(
          Assets.imagesLogo,
          width: size.width * 0.7,
        ),
      ],
    );
  }
}
