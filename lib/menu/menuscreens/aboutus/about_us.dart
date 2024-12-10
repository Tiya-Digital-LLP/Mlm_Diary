import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/aboutus/controller/about_us_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final AboutUsController aboutUsController = Get.put(AboutUsController());

  @override
  void initState() {
    super.initState();
    aboutUsController.fetchAboutUs();
  }

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
          child: Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(Assets.svgBack),
            ),
          ),
        ),
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'About us',
              style: textStyleW700(size.width * 0.048, AppColors.blackText),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (aboutUsController.isLoading.value) {
          return Center(
            child: CustomLottieAnimation(
              child: Lottie.asset(Assets.lottieLottie),
            ),
          );
        } else {
          final aboutUs = aboutUsController.aboutUs.value.about;
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              if (aboutUs.title1.isNotEmpty)
                _buildSection(aboutUs.title1, aboutUs.description1),
              if (aboutUs.title2.isNotEmpty)
                _buildSection(aboutUs.title2, aboutUs.description2),
              if (aboutUs.title3.isNotEmpty)
                _buildSection(aboutUs.title3, aboutUs.description3),
              if (aboutUs.title4.isNotEmpty)
                _buildSection(aboutUs.title4, aboutUs.description4),
              if (aboutUs.title5 != null && aboutUs.title5.isNotEmpty)
                _buildSection(aboutUs.title5, aboutUs.description5),
            ],
          );
        }
      }),
    );
  }

  Widget _buildSection(String title, String description) {
    return Card(
      color: Colors.white,
      elevation: 9,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textStyleW700(16, AppColors.blackText),
            ),
            8.sbh,
            HtmlWidget(description),
          ],
        ),
      ),
    );
  }
}
