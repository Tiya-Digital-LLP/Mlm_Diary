import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';

class TutorialVideo extends StatefulWidget {
  const TutorialVideo({super.key});

  @override
  State<TutorialVideo> createState() => _TutorialVideoState();
}

class _TutorialVideoState extends State<TutorialVideo> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.all(size.height * 0.012),
          child: const Align(
            alignment: Alignment.topLeft,
            child: CustomBackButton(),
          ),
        ),
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tutorial Video',
              style: textStyleW700(size.width * 0.048, AppColors.blackText),
            ),
          ],
        ),
      ),
    );
  }
}
