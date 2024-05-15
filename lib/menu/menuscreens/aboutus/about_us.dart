import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  boxShadow: [customBoxShadow()],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.imagesLogo,
                    ),
                    Text(
                      'Welcome to MLM Diary',
                      style: textStyleW700(
                          size.width * 0.045, AppColors.blackText),
                    ),
                    10.sbh,
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          textAlign: TextAlign.left,
                          'We are very glad to launch MLMDiary.com, a website providing a bridge between the Leading MLM Companies and all those peoples who are connected with Network Marketing Industry. We aim to cater a wide range of MLM business group by collaborating MLM Leaders, MLM trainers, MLM Companies and MLM service providers.',
                          style: textStyleW400(
                              size.width * 0.032, AppColors.blackText),
                        ),
                      ),
                    ),
                    20.sbh,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: AppColors.white,
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.blackText.withOpacity(0.2))),
                        ),
                      ),
                    ),
                    10.sbh,
                    Text(
                      'Who we are?',
                      style: textStyleW700(
                          size.width * 0.045, AppColors.blackText),
                    ),
                    10.sbh,
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          textAlign: TextAlign.left,
                          'Introducing MLMDiary.com, a new effort by leading business marketing company to offer an informative website on MLM business. With our ideas and vision we assure you to offer latest information on MLM business. Our management team puts round the clock effort to ensure that the members of MLM Diary get latest information on the current happenings of MLM business.',
                          style: textStyleW400(
                              size.width * 0.032, AppColors.blackText),
                        ),
                      ),
                    ),
                    10.sbh,
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          textAlign: TextAlign.left,
                          'Simply register yourself to our website for free and receive latest information on MLM business.',
                          style: textStyleW400(
                              size.width * 0.032, AppColors.blackText),
                        ),
                      ),
                    ),
                    20.sbh,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          boxShadow: [customBoxShadow()],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Our Vision',
                                style: textStyleW700(
                                    size.width * 0.045, AppColors.blackText),
                              ),
                            ),
                            10.sbh,
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  textAlign: TextAlign.left,
                                  'To create awareness about the Network Marketing Industry to each and every people who are connected with MLM Business. Through the reliable sources of MLM Diary we help people to make them aware of best company having stability in market, best products in cost-effective prices and best plan through which people can help other people to make a bright future in today’s competitive market.',
                                  style: textStyleW400(
                                      size.width * 0.032, AppColors.blackText),
                                ),
                              ),
                            ),
                            100.sbh,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: -10,
                    right: 15,
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: SvgPicture.asset(Assets.svgOurVision),
                    ),
                  ),
                ],
              ),
            ),
            16.sbh,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          boxShadow: [customBoxShadow()],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Our Mission',
                                style: textStyleW700(
                                    size.width * 0.045, AppColors.blackText),
                              ),
                            ),
                            10.sbh,
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  textAlign: TextAlign.left,
                                  '\n\u2022 To create awareness of MLM business over the \n   internet.\n\u2022 To create a networking platform for people \n   associated with MLM business.\n\u2022 To provide latest information, news, reviews of MLM \n   business to the people.\n\u2022 To offer some exciting gifts and prizes to active \n   members.',
                                  style: textStyleW400(
                                      size.width * 0.032, AppColors.blackText),
                                ),
                              ),
                            ),
                            100.sbh,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: -30,
                    right: 15,
                    child: SizedBox(
                        width: 150,
                        height: 150,
                        child: SvgPicture.asset(Assets.svgOurMission)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
