// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/terms&condition/controller/terms_controller.dart';
import 'package:mlmdiary/menu/menuscreens/tutorialvideo/controller/tutorial_video_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custon_test_app_bar.dart';
import 'package:mlmdiary/widgets/normal_button.dart';

class Advertising extends StatefulWidget {
  const Advertising({super.key});

  @override
  State<Advertising> createState() => _AdwithusState();
}

class Choice {
  const Choice(
      {required this.title,
      required this.type,
      required this.price,
      required this.size,
      required this.icon});

  final String title;
  final String type;
  final String price;
  final String size;
  final String icon;
}

List<Choice> choices = <Choice>[
  const Choice(
      title: 'Homepage Banner Advertisement',
      type: 'Image or Video',
      price: '₹25000/- Per Month',
      size: '1170 X 200 (pixels)',
      icon: Assets.imagesAdwithus3),
  const Choice(
      title: 'Pop-up Banner Advertisement',
      type: 'Image',
      price: '₹40000/- Per Month',
      size: '500 X 500 (pixels)',
      icon: Assets.imagesAdwithus1),
  const Choice(
      title: 'Premium Classified',
      type: 'Image',
      price: '₹5000/- Per Month',
      size: '550 X 200 (pixels)',
      icon: Assets.imagesAdwithus2),
];

class _AdwithusState extends State<Advertising>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TermsController _termsController = Get.put(TermsController());
  final TutorialVideoController videoController =
      Get.put(TutorialVideoController());
  static const String position = 'advertisewithus';
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _termsController.fetchTermsAndConditions();
    videoController.fetchVideo(position, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustonTestAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'MLM Advertising',
        onTap: () {},
        position: position,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            category(),
          ],
        ),
      ),
    );
  }

  Widget category() {
    final Size size = MediaQuery.of(context).size;

    return ListView.builder(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: choices.length,
        itemBuilder: (context, index) {
          Choice record = choices[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: ShapeDecoration(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.05),
                ),
                shadows: [customBoxShadow()]),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      record.size.isNotEmpty
                          ? Container(
                              width: 112.68,
                              height: 228,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(13.05)),
                                  child: Image(
                                    image: AssetImage(record.icon),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, object, trace) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.background),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 134,
                              height: 152.11,
                              margin: const EdgeInsets.only(
                                  top: 22, left: 10, bottom: 20, right: 6),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(record.icon),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      15.sbw,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                record.title,
                                style: textStyleW700(
                                    size.width * 0.042, AppColors.blackText),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              10.sbh,
                              record.size.isNotEmpty
                                  ? SizedBox(
                                      height: 15,
                                      child: Text('Type:',
                                          style: textStyleW500(
                                              size.width * 0.028,
                                              AppColors.blackText),
                                          maxLines: 2,
                                          softWrap: false))
                                  : const SizedBox(),
                              5.sbh,
                              Text(
                                record.type,
                                style: record.size.isNotEmpty
                                    ? textStyleW600(
                                        size.width * 0.042, AppColors.blackText)
                                    : textStyleW500(size.width * 0.032,
                                        AppColors.blackText),
                                textAlign: TextAlign.justify,
                              ),
                              5.sbh,
                              record.size.isNotEmpty
                                  ? Text(
                                      'Size:',
                                      style: textStyleW500(size.width * 0.032,
                                          AppColors.blackText),
                                    )
                                  : const SizedBox(),
                              record.size.isNotEmpty
                                  ? Text(record.size,
                                      style: textStyleW600(size.width * 0.042,
                                          AppColors.blackText))
                                  : const SizedBox(),
                              5.sbh,
                              Text(
                                'Price:',
                                style: textStyleW500(
                                    size.width * 0.032, AppColors.blackText),
                              ),
                              Text(
                                record.price,
                                style: textStyleW600(
                                    size.width * 0.042, AppColors.blackText),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: NormalButton(
                        onPressed: () {
                          Get.toNamed(Routes.contactus);
                        },
                        text: 'Contact Us'),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
