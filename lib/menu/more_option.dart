// ignore_for_file: camel_case_types, non_constant_identifier_names, use_build_context_synchronously

import 'dart:core';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/controller/profile_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class MoreOptionScreen extends StatefulWidget {
  const MoreOptionScreen({super.key});

  @override
  State<MoreOptionScreen> createState() => _moreState();
}

class Choice {
  const Choice({required this.title, required this.icon, required this.id});

  final String title;
  final String icon;
  final String id;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Account Setting', icon: Assets.svgProfile, id: '1'),
  Choice(title: 'Manage Classified', icon: Assets.svgGrid3, id: '2'),
  Choice(title: 'Manage News', icon: Assets.svgClipboardText, id: '3'),
  Choice(title: 'MLM Database', icon: Assets.svgArchive, id: '4'),
  Choice(title: 'Manage Blog', icon: Assets.svgDocumentText, id: '5'),
  Choice(title: 'MLM Companies', icon: Assets.svgBuilding4, id: '6'),
  Choice(title: 'Favourite', icon: Assets.svgBookmark, id: '7'),
  Choice(title: 'Advertising', icon: Assets.svgPresentionChart, id: '8'),
  Choice(title: 'Following/ Followers', icon: Assets.svgProfile2user, id: '9'),
  Choice(
      title: 'Manage Question/ Answer',
      icon: Assets.svgMessageQuestion,
      id: '10'),
  Choice(title: 'MLM Videos', icon: Assets.svgPlayCircle, id: '11'),
  Choice(title: 'Tutorial Video', icon: Assets.svgVideoOctagon, id: '12'),
  Choice(title: 'Plan & Company Interest', icon: Assets.svgStar, id: '13'),
  Choice(title: 'Premium Plan', icon: Assets.svgShield, id: '14'),
  Choice(title: 'App Share', icon: Assets.svgSend2, id: '15'),
  Choice(title: 'Refer & Earn', icon: Assets.svgDollarCircle, id: '16'),
];

class _moreState extends State<MoreOptionScreen> {
  final ProfileController controller = Get.put(ProfileController());

  String? packageName;

  @override
  void initState() {
    super.initState();
    controller.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Menu',
              style: textStyleW700(size.width * 0.048, AppColors.blackText),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.background,
      body: Obx(() {
        final userProfile = controller.userProfile.value.userProfile;

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (userProfile == null) {
          return Center(
            child: Text(
              controller.isLoading.value ? 'Loading...' : 'Data not found',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
        }
        return SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    Routes.profilescreen,
                    arguments: controller.userProfile.value.userProfile,
                  );
                },
                child: Container(
                  height: 75,
                  padding: const EdgeInsets.only(left: 17),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.05),
                    ),
                    shadows: [customBoxShadow()],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: CircleAvatar(
                          radius: 30,
                          child: CachedNetworkImage(
                            imageUrl:
                                userProfile.imagePath ?? Assets.imagesIcon,
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                            placeholder: (context, url) => Container(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      10.sbw,
                      Obx(() {
                        if (controller.isLoading.value) {
                          return const CircularProgressIndicator();
                        }

                        return Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                userProfile.name ?? 'N/A',
                                style: textStyleW700(
                                    size.width * 0.040, AppColors.blackText),
                              ),
                              Text(
                                userProfile.company ?? 'N/A',
                                style: textStyleW400(
                                    size.width * 0.032, AppColors.blackText),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              category(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.contactus);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(5.0, 0.0, 8.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.5),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(13.5)),
                            boxShadow: [customBoxShadow()],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 55,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text('Contact Us/Feedback',
                                              style: textStyleW700(
                                                  size.width * 0.032,
                                                  AppColors.blackText)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.contactus);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 17,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.aboutus);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(5.0, 0.0, 8.0, 0.0),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.05),
                      ),
                      child: Container(
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.05),
                          ),
                          shadows: [customBoxShadow()],
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 55,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text('About MLM Diary',
                                              style: textStyleW700(
                                                  size.width * 0.032,
                                                  AppColors.blackText)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.aboutus);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 17,
                                  )),
                            ]),
                      ),
                    )
                  ]),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.notificatiosetting);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(5.0, 0.0, 8.0, 0.0),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.05),
                      ),
                      child: Container(
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.05),
                          ),
                          shadows: [customBoxShadow()],
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 55,
                                child: Center(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Text('Notification Settings',
                                                style: textStyleW700(
                                                    size.width * 0.032,
                                                    AppColors.blackText)),
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.notificatiosetting);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 17,
                                  )),
                            ]),
                      ),
                    )
                  ]),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.advertisewithus);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(5.0, 0.0, 8.0, 0.0),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.05),
                      ),
                      child: Container(
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.05),
                          ),
                          shadows: [customBoxShadow()],
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 55,
                                child: Center(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Text('Terms & Condition',
                                                style: textStyleW700(
                                                    size.width * 0.032,
                                                    AppColors.blackText)),
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.advertisewithus);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 17,
                                  )),
                            ]),
                      ),
                    )
                  ]),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showLogoutDialog(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(5.0, 0.0, 8.0, 0.0),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.05),
                      ),
                      child: Container(
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.05),
                          ),
                          shadows: [customBoxShadow()],
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 55,
                                child: Center(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Text('Logout',
                                                style: textStyleW700(
                                                    size.width * 0.032,
                                                    AppColors.blackText)),
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    _showLogoutDialog(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 17,
                                  )),
                            ]),
                      ),
                    )
                  ]),
                ),
              ),
              10.sbh,
              Center(
                child: Text(
                  'Follow MLM DIARY',
                  style: textStyleW700(size.width * 0.032, AppColors.blackText),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: SvgPicture.asset(Assets.svgLogosWhatsappIcon,
                          height: 26, width: 26),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: SvgPicture.asset(Assets.svgLogosFacebook,
                          height: 26, width: 26),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: SvgPicture.asset(Assets.svgInstagram,
                          height: 26, width: 26),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: SvgPicture.asset(Assets.svgLogosLinkedinIcon,
                          height: 26, width: 26),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: SvgPicture.asset(Assets.svgYoutube,
                          height: 26, width: 26),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: SvgPicture.asset(Assets.svgTelegram,
                          height: 26, width: 26),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: SvgPicture.asset(Assets.svgTwitter,
                          height: 26, width: 26),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'App Version',
                    style:
                        textStyleW500(size.width * 0.032, AppColors.blackText),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Check Latest Update',
                      style: textStyleW500(
                          size.width * 0.032, AppColors.primaryColor),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
      }),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1, color: AppColors.blackText.withOpacity(0.2)))),
        height: 70,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.mlmnews);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        child: Text(
                          'MLM News',
                          style: textStyleW700(
                            size.width * 0.028,
                            AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    8.sbw,
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.mlmblog);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        child: Text(
                          'MLM Blog',
                          style: textStyleW700(
                            size.width * 0.028,
                            AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    8.sbw,
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.quationanswer);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        child: Text(
                          'Question/Answer',
                          style: textStyleW700(
                            size.width * 0.028,
                            AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    8.sbw,
                    GestureDetector(
                      onTap: () {
                        shareApp(
                          url:
                              "https://play.google.com/store/apps/details?id=$packageName",
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        child: Text(
                          'App Share',
                          style: textStyleW700(
                            size.width * 0.028,
                            AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final Size size = MediaQuery.of(context).size;

        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    Assets.imagesLogoutCheck,
                    height: 50,
                  ),
                ),
              ),
              16.sbh,
              Column(
                children: [
                  Text(
                    'Are you sure?',
                    style: textStyleW700(
                      size.width * 0.040,
                      AppColors.blackText,
                    ),
                  ),
                  5.sbh,
                  Text(
                    'Do you want to logout',
                    style: textStyleW400(
                      size.width * 0.035,
                      AppColors.blackText,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: TextButton(
                                style: ElevatedButton.styleFrom(),
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  'Cancel',
                                  style: textStyleW700(
                                      size.width * 0.035, AppColors.blackText),
                                ))),
                        5.sbw,
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  shadowColor: AppColors.primaryColor,
                                  elevation: 3,
                                ),
                                onPressed: () {
                                  Get.toNamed(Routes.login);
                                },
                                child: Text(
                                  'Logout',
                                  style: textStyleW700(
                                      size.width * 0.035, AppColors.white),
                                ))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget category() {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: FutureBuilder(
        future: TickerFuture.complete(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: MediaQuery.of(context).size.aspectRatio * 4.2,
                crossAxisCount: 2,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: choices.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Choice record = choices[index];
                return GestureDetector(
                  onTap: () async {
                    switch (record.id) {
                      case '1':
                        Get.toNamed(
                          Routes.accountsettingscreen,
                          arguments: {'controller': controller},
                        );
                        break;
                      case '2':
                        Get.toNamed(Routes.mlmclassified);
                        break;
                      case '3':
                        Get.toNamed(Routes.managenews);
                        break;
                      case '5':
                        Get.toNamed(Routes.manageblog);
                        break;
                      case '6':
                        Get.toNamed(Routes.mlmcompanies);
                        break;
                      case '7':
                        Get.toNamed(Routes.favourite);
                        break;
                      case '8':
                        Get.toNamed(Routes.advertising);
                        break;
                      case '9':
                        Get.toNamed(Routes.followers);
                        break;
                      case '10':
                        Get.toNamed(Routes.managequationanswer);
                        break;
                      case '11':
                        Get.toNamed(Routes.video);
                        break;
                      case '12':
                        Get.toNamed(Routes.tutorialvideo);
                        break;
                      case '13':
                        Get.toNamed(Routes.planandcompanyinterest);
                        break;
                      case '14':
                        Get.toNamed(Routes.premiumplan);
                        break;
                      case '15':
                        shareApp(
                          url:
                              "https://play.google.com/store/apps/details?id=$packageName",
                        );
                        break;
                      case '16':
                        Get.toNamed(Routes.referearn);
                        break;
                      default:
                        if (kDebugMode) {
                          print('No route defined for id: ${record.id}');
                        }
                    }
                  },
                  child: Card(
                    elevation: 2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.05),
                    ),
                    child: Container(
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.05),
                        ),
                        shadows: [customBoxShadow()],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: SvgPicture.asset(
                                record.icon,
                                height: 32,
                              ),
                            ),
                            10.sbh,
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(record.title,
                                  style: textStyleW700(
                                      size.width * 0.032, AppColors.blackText)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void shareApp({
    required String url,
  }) async {
    final ByteData bytesImage = await rootBundle.load(Assets.imagesLogo);
    final bytes = bytesImage.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/image.jpg';
    await File(path).writeAsBytes(bytes);

    await Share.shareXFiles([XFile(path)],
        // ignore: prefer_interpolation_to_compose_strings
        text:
            'Plastic4trade Global B2B Polymer Raw Material Trading, Buy & Sale, Recycle Plastic Scrap, Rate, News, Update for Manufacturer, Trader, Exporter, Importer, Business App'
            "\n"
            '\n'
            'Download App'
            '\n'
            'Android:'
            '\n'
            'https://play.google.com/store/apps/details?id=${packageName ?? ''}'
            '\n'
            '\n'
            'iOS:'
            '\n'
            'https://apps.apple.com/app/plastic4trade/id6450507332');
  }
}
