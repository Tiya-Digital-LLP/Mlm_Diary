import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:html/parser.dart' as htmlParser;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_admin_company_entity.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/custom_company_comment.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:text_link/text_link.dart';
import 'package:url_launcher/url_launcher.dart';

class MlmcompanyNotificationDetail extends StatefulWidget {
  const MlmcompanyNotificationDetail({super.key});

  @override
  State<MlmcompanyNotificationDetail> createState() =>
      _MlmCompaniesDetailsState();
}

class _MlmCompaniesDetailsState extends State<MlmcompanyNotificationDetail> {
  final CompanyController controller = Get.put(CompanyController());
  dynamic post;
  final PostTimeFormatter postTimeFormatter = PostTimeFormatter();
  // like
  late RxBool isLiked;
  late RxInt likeCount;
// bookmark
  late RxBool isBookmarked;
  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments as Map<String, dynamic>?;
    initializeLikes();
    initializeBookmarks();
    if (arguments != null) {
      post = GetAdminCompanyData.fromJson(arguments);
      if (post != null) {
        final int postId = post!.id ?? 0;
        if (postId != 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.getAdminCompany(
              postId,
            );
            controller.countViewCompany(postId, context);
          });
        }
      }
    }

    // ignore: unrelated_type_equality_checks
    controller.likeCountMap == 0;
  }

  void initializeLikes() {
    if (controller.companyAdminList.isNotEmpty) {
      isLiked = RxBool(controller.companyAdminList[0].likedByUser ?? false);
      likeCount = RxInt(controller.companyAdminList[0].totallike ?? 0);
    } else {
      isLiked = RxBool(false);
      likeCount = RxInt(0);
    }
  }

  void initializeBookmarks() {
    if (controller.companyAdminList.isNotEmpty) {
      isBookmarked =
          RxBool(controller.companyAdminList[0].bookmarkedByUser ?? false);
    } else {
      isBookmarked = RxBool(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'MLM Companies',
      ),
      body: Obx(() {
        if (controller.companyAdminList.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          final data = controller.companyAdminList.first;
          return SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: AppColors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: data.imageUrl ?? '',
                                        height: 60.0,
                                        width: 60.0,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            Image.asset(Assets.imagesAdminlogo),
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  data.title ?? 'N/A',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.blackText,
                                    fontSize: size.width * 0.040,
                                  ),
                                ),
                              ),
                            ),
                            5.sbh,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Location',
                                        style: textStyleW400(
                                            size.width * 0.035, AppColors.grey),
                                      ),
                                      const SizedBox(
                                        width: 07,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    data.location ?? 'N/A',
                                    style: textStyleW400(size.width * 0.035,
                                        AppColors.blackText),
                                  ),
                                ],
                              ),
                            ),
                            10.sbh,
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: AppColors.white,
                                border: const Border(
                                    bottom: BorderSide(color: Colors.grey)),
                              ),
                            ),
                            10.sbh,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Phone',
                                              style: textStyleW400(
                                                  size.width * 0.035,
                                                  AppColors.grey),
                                            ),
                                            const SizedBox(
                                              width: 07,
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            final String? countryCode =
                                                data.country;
                                            final String? mobileNumber =
                                                data.phone;

                                            if (mobileNumber == null ||
                                                mobileNumber.isEmpty) {
                                              showToasterrorborder(
                                                  'No Any Url Found', context);
                                              if (kDebugMode) {
                                                print('Tap without number');
                                              }
                                            } else {
                                              final Uri phoneUri = Uri(
                                                scheme: 'tel',
                                                path:
                                                    '$countryCode$mobileNumber', // Combine country code and mobile
                                              );
                                              launchUrl(phoneUri);
                                              if (kDebugMode) {
                                                print(
                                                    'Tap with number: $countryCode$mobileNumber');
                                              }
                                            }
                                          },
                                          child: Text(
                                            '${data.country ?? 'N/A'} - ${data.phone ?? 'N/A'}',
                                            style: textStyleW400(
                                                size.width * 0.035,
                                                AppColors.blackText),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Email',
                                            style: textStyleW400(
                                                size.width * 0.035,
                                                AppColors.grey),
                                          ),
                                          const SizedBox(
                                            width: 07,
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          final String? email = data.email;

                                          if (email != null &&
                                              email.isNotEmpty) {
                                            final Uri emailUri = Uri(
                                              scheme: 'mailto',
                                              path: email,
                                            );
                                            launchUrl(emailUri);
                                            if (kDebugMode) {
                                              print('Tap with email: $email');
                                            }
                                          } else {
                                            showToasterrorborder(
                                                'No Email Found', context);
                                            if (kDebugMode) {
                                              print('Tap without email');
                                            }
                                          }
                                        },
                                        child: Text(
                                          data.email?.isNotEmpty == true
                                              ? data.email!
                                              : 'N/A',
                                          style: textStyleW400(
                                              size.width * 0.035,
                                              AppColors.blackText),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            10.sbh,
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: AppColors.white,
                                border: const Border(
                                    bottom: BorderSide(color: Colors.grey)),
                              ),
                            ),
                            10.sbh,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Website',
                                              style: textStyleW400(
                                                  size.width * 0.035,
                                                  AppColors.grey),
                                            ),
                                            const SizedBox(
                                              width: 07,
                                            ),
                                          ],
                                        ),
                                        LinkText(
                                          text: data.website?.isNotEmpty == true
                                              ? data.website!
                                              : 'N/A',
                                          style: textStyleW400(
                                            size.width * 0.035,
                                            AppColors.blackText
                                                .withOpacity(0.5),
                                          ),
                                          linkStyle: const TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                if (data.fblink != null) {
                                                  _launchURL(
                                                      data.fblink.toString());
                                                  if (kDebugMode) {
                                                    print(
                                                        'URL: ${data.fblink}');
                                                  }
                                                } else {
                                                  showToasterrorborder(
                                                      "No Any Url Fond",
                                                      context);
                                                }
                                              },
                                              child: SvgPicture.asset(
                                                  Assets.svgLogosFacebook)),
                                          12.sbw,
                                          InkWell(
                                              onTap: () {
                                                if (data.inlink != null) {
                                                  _launchURL(
                                                      data.inlink.toString());
                                                  if (kDebugMode) {
                                                    print(
                                                        'URL: ${data.inlink}');
                                                  }
                                                } else {
                                                  showToasterrorborder(
                                                      "No Any Url Fond",
                                                      context);
                                                }
                                              },
                                              child: SvgPicture.asset(
                                                  Assets.svgInstagram)),
                                          12.sbw,
                                          InkWell(
                                            onTap: () {
                                              if (data.liklink != null) {
                                                _launchURL(
                                                    data.liklink.toString());
                                                if (kDebugMode) {
                                                  print('URL: ${data.liklink}');
                                                }
                                              } else {
                                                showToasterrorborder(
                                                    "No Any Url Fond", context);
                                              }
                                            },
                                            child: SvgPicture.asset(
                                                Assets.svgLogosLinkedinIcon),
                                          ),
                                          12.sbw,
                                          InkWell(
                                              onTap: () {
                                                if (data.youlink != null) {
                                                  _launchURL(
                                                      data.youlink.toString());
                                                  if (kDebugMode) {
                                                    print(
                                                        'URL: ${data.youlink}');
                                                  }
                                                } else {
                                                  showToasterrorborder(
                                                      "No Any Url Fond",
                                                      context);
                                                }
                                              },
                                              child: SvgPicture.asset(
                                                  Assets.svgYoutube)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            10.sbh,
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: AppColors.white,
                                border: const Border(
                                    bottom: BorderSide(color: Colors.grey)),
                              ),
                            ),
                            10.sbh,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    postTimeFormatter
                                        .formatPostTime(data.createdate ?? ''),
                                    style: textStyleW400(size.width * 0.035,
                                        AppColors.blackText.withOpacity(0.8)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.017,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: AppColors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'About Your Business',
                                    style: textStyleW400(
                                        size.width * 0.035, AppColors.grey),
                                  ),
                                  5.sbh,
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: _buildHtmlContent(
                                        data.description ?? '', size),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      }),
      bottomNavigationBar: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CustomLottieAnimation(
              child: Lottie.asset(
                Assets.lottieLottie,
              ),
            ),
          );
        } else if (controller.companyAdminList.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          final data = controller.companyAdminList.first;
          return Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Obx(
                        () => SizedBox(
                          height: size.height * 0.028,
                          width: size.height * 0.028,
                          child: GestureDetector(
                            onTap: () async {
                              bool newLikedValue = !isLiked.value;
                              isLiked.value = newLikedValue;
                              likeCount.value = newLikedValue
                                  ? likeCount.value + 1
                                  : likeCount.value - 1;

                              await controller.toggleLike(
                                  data.id ?? 0, context);
                            },
                            child: Icon(
                              // Observe like status
                              isLiked.value
                                  ? Icons.thumb_up_off_alt_sharp
                                  : Icons.thumb_up_off_alt_outlined,
                              color:
                                  isLiked.value ? AppColors.primaryColor : null,
                              size: size.height * 0.032,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 7,
                      ),
                      // ignore: unrelated_type_equality_checks
                      likeCount.value == 0
                          ? const SizedBox.shrink()
                          : InkWell(
                              onTap: () {},
                              child: Text(
                                '${likeCount.value}',
                                style: textStyleW600(
                                    size.width * 0.038, AppColors.blackText),
                              ),
                            ),
                      const SizedBox(
                        width: 15,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => showFullScreenDialogCompany(
                              context,
                              data.id!,
                            ),
                            child: SizedBox(
                              height: size.height * 0.028,
                              width: size.height * 0.028,
                              child: SvgPicture.asset(Assets.svgComment),
                            ),
                          ),
                          5.sbw,
                          Text(
                            '${data.totalcomment}',
                            style: TextStyle(
                              fontFamily: "Metropolis",
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.038,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        height: size.height * 0.028,
                        width: size.height * 0.028,
                        child: SvgPicture.asset(Assets.svgView),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        data.pgcnt.toString(),
                        style: textStyleW600(
                            size.width * 0.040, AppColors.blackText),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Obx(
                        () => SizedBox(
                          height: size.height * 0.028,
                          width: size.height * 0.028,
                          child: GestureDetector(
                            onTap: () async {
                              bool newBookmarkedValue = !isBookmarked.value;
                              isBookmarked.value = newBookmarkedValue;

                              await controller.toggleBookMark(
                                  data.id ?? 0, context);
                            },
                            child: SvgPicture.asset(
                              isBookmarked.value
                                  ? Assets.svgCheckBookmark
                                  : Assets.svgSavePost,
                              height: size.height * 0.032,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: size.height * 0.028,
                        width: size.height * 0.028,
                        child: SvgPicture.asset(Assets.svgSend),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildHtmlContent(String htmlContent, Size size) {
    final parsedHtml = htmlParser.parse(htmlContent);
    final text = parsedHtml.body?.text ?? '';

    return LinkText(
      text: text,
      style: textStyleW400(
        size.width * 0.035,
        AppColors.blackText.withOpacity(0.8),
      ),
      linkStyle: const TextStyle(
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
    );
  }

  void _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
