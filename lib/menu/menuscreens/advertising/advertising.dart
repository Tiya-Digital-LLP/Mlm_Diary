// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/firstscreen/home_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/terms&condition/controller/terms_controller.dart';
import 'package:mlmdiary/menu/menuscreens/tutorialvideo/controller/tutorial_video_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:mlmdiary/widgets/normal_button.dart';

class Advertising extends StatefulWidget {
  const Advertising({super.key});

  @override
  State<Advertising> createState() => _AdwithusState();
}

class ChoiceCopy {
  const ChoiceCopy({
    required this.title,
    required this.type,
    required this.price,
    required this.size,
    required this.icon,
    required this.app,
    required this.web,
  });

  final String title;
  final String type;
  final String price;
  final String size;
  final String icon;
  final String app;
  final String web;
}

const List<ChoiceCopy> choiceCopy = <ChoiceCopy>[
  ChoiceCopy(
    title: 'Homepage Banner Ads',
    type: 'Image or Video',
    price: 'App & Web ₹40000/- Per Month',
    size: '1170 X 200 (pixels)',
    icon: Assets.imagesAdwithus3,
    app: 'App ₹25000/- Per Month',
    web: 'Web ₹25000/- Per Month',
  ),
  ChoiceCopy(
    title: 'Pop-up Banner Ads',
    type: 'Image',
    price: 'App & Web ₹60000/- Per Month',
    size: '500 X 500 (pixels)',
    icon: Assets.imagesAdwithus1,
    app: 'App ₹40000/- Per Month',
    web: 'Web ₹40000/- Per Month',
  ),
  ChoiceCopy(
    title: 'Premium Classified',
    type: 'Image',
    price: 'App & Web ₹15000/- Per Month',
    size: '550 X 200 (pixels)',
    icon: Assets.imagesAdwithus2,
    app: '',
    web: '',
  ),
  ChoiceCopy(
    title: 'Customize Ads',
    type:
        'Send Notifications to All Users or Customize Users with Locations in terms of Classified, Blog, and News, Company Promotions, and Any other type of Notification ad.',
    price: 'App & Web ₹5000/- Per Notification',
    size: '',
    icon: Assets.imagesAdWithUs4,
    app: '',
    web: '',
  ),
  ChoiceCopy(
    title: 'Social, WhatsApp, Email, Marketing to Users',
    type:
        'Send Notifications to All Users or Customize Users with Locations in terms of Classified, Blog, and News, Company Promotions, and Any other type of Notification ad.',
    price: 'As Per Requirement (Customize)',
    size: '',
    icon: Assets.imagesAdWithUs5,
    app: '',
    web: '',
  ),
];

class _AdwithusState extends State<Advertising>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TermsController _termsController = Get.put(TermsController());
  final TutorialVideoController videoController =
      Get.put(TutorialVideoController());
  static const String position = 'advertisewithus';
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _termsController.fetchTermsAndConditions();
    videoController.fetchVideo(position, context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.all(size.height * 0.012),
          child: Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                homeScreenController.newIndex.value = 0;
                homeScreenController.tappedIndex.value = 0;
                Get.back();
              },
              customBorder: const CircleBorder(),
              child: SvgPicture.asset(Assets.svgBack),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Advertising',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: size.width * 0.048,
            color: Colors.black,
            fontFamily: Assets.fontsSatoshiRegular,
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              if (position.isEmpty) {
                await videoController.fetchVideo('', context);
                Get.toNamed(Routes.tutorialvideo, arguments: {'position': ''});
              } else if (position == 'advertisewithus') {
                await videoController.fetchVideo('advertisewithus', context);
                Get.toNamed(Routes.tutorialvideo,
                    arguments: {'position': 'advertisewithus'});
              }
            },
            child: SvgPicture.asset(
              Assets.svgPlay,
              height: size.width * 0.08,
              width: size.width * 0.08,
            ),
          ),
          const SizedBox(width: 18),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                category(),
                Text(
                  'Terms & Condition',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: size.width * 0.048,
                    color: Colors.black,
                    fontFamily: Assets.fontsSatoshiRegular,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(42.26),
                        color: AppColors.primaryColor,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        Tab(text: 'Blog'),
                        Tab(text: 'Classified'),
                        Tab(text: 'News'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'This is our Blog',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Builder(
                    builder: (context) {
                      return Obx(() {
                        if (_termsController.isLoading.value) {
                          return CustomLottieAnimation(
                            child: Lottie.asset(Assets.lottieLottie),
                          );
                        } else if (_termsController.termsAndConditions.value !=
                            null) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              HtmlUnescape().convert(_termsController
                                  .termsAndConditions.value
                                  .toString()),
                            ),
                          );
                        } else {
                          return const Text(
                            'Failed to load terms and conditions',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.red,
                            ),
                          );
                        }
                      });
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'This is our News',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget category() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: choiceCopy.length,
        itemBuilder: (context, index) {
          ChoiceCopy record = choiceCopy[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: ShapeDecoration(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.05),
                ),
                shadows: [
                  BoxShadow(
                    color: AppColors.grey,
                    blurRadius: 16.32,
                    offset: const Offset(0, 3.26),
                    spreadRadius: 0,
                  )
                ]),
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
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13.05)),
                              ),
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
                                            color: AppColors.grey),
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
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                record.title,
                                style: TextStyle(
                                  color: AppColors.blackText,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.24,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              record.size.isNotEmpty
                                  ? SizedBox(
                                      height: 15,
                                      child: Text('Type:',
                                          style: TextStyle(
                                            color: AppColors.blackText,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.24,
                                          ),
                                          maxLines: 2,
                                          softWrap: false))
                                  : const SizedBox(),
                              Text(
                                record.type,
                                style: record.size.isNotEmpty
                                    ? TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackText,
                                      )
                                    : TextStyle(
                                        color: AppColors.blackText,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.24,
                                      ),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              record.size.isNotEmpty
                                  ? Text(
                                      'Size:',
                                      style: TextStyle(
                                          color: AppColors.blackText,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.24,
                                          fontFamily:
                                              'assets/fonst/Metropolis-Black.otf'),
                                    )
                                  : const SizedBox(),
                              record.size.isNotEmpty
                                  ? Text(record.size,
                                      style: TextStyle(
                                        color: AppColors.blackText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -0.24,
                                      ))
                                  : const SizedBox(),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Price:',
                                style: TextStyle(
                                  color: AppColors.blackText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.24,
                                ),
                              ),
                              record.app.isNotEmpty
                                  ? Text(record.app,
                                      style: TextStyle(
                                        color: AppColors.blackText,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -0.24,
                                      ))
                                  : const SizedBox(),
                              3.sbh,
                              record.web.isNotEmpty
                                  ? Text(record.web,
                                      style: TextStyle(
                                        color: AppColors.blackText,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -0.24,
                                      ))
                                  : const SizedBox(),
                              3.sbh,
                              Text(
                                record.price,
                                style: TextStyle(
                                  color: AppColors.blackText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: NormalButton(
                    onPressed: () {
                      Get.toNamed(Routes.contactus);
                    },
                    text: 'Contact Us',
                    isLoading: isLoading,
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
