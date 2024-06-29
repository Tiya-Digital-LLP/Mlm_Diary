import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_user_profile_entity.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMeSection extends StatelessWidget {
  final Size size;
  final userProfile = Get.arguments as GetUserProfileUserProfile;
  AboutMeSection({required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Follow me on',
                        style:
                            textStyleW400(size.width * 0.035, AppColors.grey)),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (userProfile.wplink != null) {
                              _launchURL(userProfile.wplink.toString());
                              if (kDebugMode) {
                                print('URL: ${userProfile.wplink}');
                              }
                            } else {
                              showToasterrorborder("No Any Url Fond", context);
                            }
                          },
                          icon: SvgPicture.asset(
                            Assets.svgLogosWhatsappIcon,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (userProfile.fblink != null) {
                              _launchURL(userProfile.fblink.toString());
                              if (kDebugMode) {
                                print('URL: ${userProfile.fblink}');
                              }
                            } else {
                              showToasterrorborder("No Any Url Fond", context);
                            }
                          },
                          icon: SvgPicture.asset(
                            Assets.svgLogosFacebook,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (userProfile.instalink != null) {
                              _launchURL(userProfile.instalink.toString());
                              if (kDebugMode) {
                                print('URL: ${userProfile.instalink}');
                              }
                            } else {
                              showToasterrorborder("No Any Url Fond", context);
                            }
                          },
                          icon: SvgPicture.asset(
                            Assets.svgInstagram,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (userProfile.lilink != null) {
                              _launchURL(userProfile.lilink.toString());
                              if (kDebugMode) {
                                print('URL: ${userProfile.lilink}');
                              }
                            } else {
                              showToasterrorborder("No Any Url Fond", context);
                            }
                          },
                          icon: SvgPicture.asset(
                            Assets.svgLogosLinkedinIcon,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (userProfile.youlink != null) {
                              _launchURL(userProfile.youlink.toString());
                              if (kDebugMode) {
                                print('URL: ${userProfile.youlink}');
                              }
                            } else {
                              showToasterrorborder("No Any Url Fond", context);
                            }
                          },
                          icon: SvgPicture.asset(
                            Assets.svgYoutube,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (userProfile.telink != null) {
                              _launchURL(userProfile.telink.toString());
                              if (kDebugMode) {
                                print('URL: ${userProfile.telink}');
                              }
                            } else {
                              showToasterrorborder("No Any Url Fond", context);
                            }
                          },
                          icon: SvgPicture.asset(
                            Assets.svgTelegram,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (userProfile.twiterlink != null) {
                              _launchURL(userProfile.twiterlink.toString());
                              if (kDebugMode) {
                                print('URL: ${userProfile.twiterlink}');
                              }
                            } else {
                              showToasterrorborder("No Any Url Fond", context);
                            }
                          },
                          icon: SvgPicture.asset(
                            Assets.svgTwitter,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: Colors.grey),
          10.sbh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About me',
                    style: textStyleW400(size.width * 0.035, AppColors.grey)),
                Text(
                  userProfile.aboutyou ?? 'N/A',
                  style: textStyleW500(size.width * 0.035, AppColors.blackText),
                ),
              ],
            ),
          ),
          10.sbh,
          const Divider(color: Colors.grey),
          10.sbh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About Company',
                    style: textStyleW400(size.width * 0.035, AppColors.grey)),
                Text(
                  userProfile.aboutcompany ?? 'N/A',
                  style: textStyleW500(size.width * 0.035, AppColors.blackText),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.017),
        ],
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
