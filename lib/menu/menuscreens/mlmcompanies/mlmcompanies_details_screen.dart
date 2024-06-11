import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:html/parser.dart' as htmlParser;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_admin_company_entity.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:text_link/text_link.dart';
import 'package:url_launcher/url_launcher.dart';

class MlmCompaniesDetails extends StatefulWidget {
  const MlmCompaniesDetails({super.key});

  @override
  State<MlmCompaniesDetails> createState() => _MlmCompaniesDetailsState();
}

class _MlmCompaniesDetailsState extends State<MlmCompaniesDetails> {
  final CompanyController controller = Get.put(CompanyController());
  final post = Get.arguments as GetAdminCompanyData;

  @override
  void initState() {
    super.initState();
    // ignore: unrelated_type_equality_checks
    controller.likeCountMap == 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.countViewCompany(post.id ?? 0, context);
    });
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
      body: SingleChildScrollView(
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
                                    imageUrl: post.image ?? '',
                                    height: 60.0,
                                    width: 60.0,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
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
                              post.name ?? 'N/A',
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
                                post.location ?? 'N/A',
                                style: textStyleW400(
                                    size.width * 0.035, AppColors.blackText),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Text(
                                      post.phone ?? '',
                                      style: textStyleW400(size.width * 0.035,
                                          AppColors.blackText),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Email',
                                        style: textStyleW400(
                                            size.width * 0.035, AppColors.grey),
                                      ),
                                      const SizedBox(
                                        width: 07,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    post.email ?? '',
                                    style: textStyleW400(size.width * 0.035,
                                        AppColors.blackText),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Text(
                                      post.website ?? '',
                                      style: textStyleW400(size.width * 0.035,
                                          AppColors.blackText),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            if (post.fblink != null) {
                                              _launchURL(
                                                  post.fblink.toString());
                                              if (kDebugMode) {
                                                print('URL: ${post.fblink}');
                                              }
                                            } else {
                                              showToasterrorborder(
                                                  "No Any Url Fond", context);
                                            }
                                          },
                                          child: SvgPicture.asset(
                                              Assets.svgLogosFacebook)),
                                      12.sbw,
                                      InkWell(
                                          onTap: () {
                                            if (post.inlink != null) {
                                              _launchURL(
                                                  post.inlink.toString());
                                              if (kDebugMode) {
                                                print('URL: ${post.inlink}');
                                              }
                                            } else {
                                              showToasterrorborder(
                                                  "No Any Url Fond", context);
                                            }
                                          },
                                          child: SvgPicture.asset(
                                              Assets.svgInstagram)),
                                      12.sbw,
                                      InkWell(
                                        onTap: () {
                                          if (post.liklink != null) {
                                            _launchURL(post.liklink.toString());
                                            if (kDebugMode) {
                                              print('URL: ${post.liklink}');
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
                                            if (post.youlink != null) {
                                              _launchURL(
                                                  post.youlink.toString());
                                              if (kDebugMode) {
                                                print('URL: ${post.youlink}');
                                              }
                                            } else {
                                              showToasterrorborder(
                                                  "No Any Url Fond", context);
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
                                'Last Updated on 25 May, 2023',
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
                                    post.description ?? '', size),
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
      ),
      bottomNavigationBar: Container(
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
                  SizedBox(
                    height: size.height * 0.028,
                    width: size.height * 0.028,
                    child: GestureDetector(
                      onTap: () => controller.toggleLike(post.id ?? 0, context),
                      child: Icon(
                        // Observe like status
                        controller.likedStatusMap[post.id ?? 0] ?? false
                            ? Icons.thumb_up_off_alt_sharp
                            : Icons.thumb_up_off_alt_outlined,
                        color: controller.likedStatusMap[post.id ?? 0] ?? false
                            ? AppColors.primaryColor
                            : null,
                        size: size.height * 0.032,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  // ignore: unrelated_type_equality_checks
                  controller.likeCountMap == 0
                      ? const SizedBox.shrink()
                      : Text(
                          post.totallike.toString(),
                          style: textStyleW600(
                              size.width * 0.040, AppColors.blackText),
                        ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    height: size.height * 0.028,
                    width: size.height * 0.028,
                    child: SvgPicture.asset(Assets.svgComment),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    "24k",
                    style:
                        textStyleW600(size.width * 0.040, AppColors.blackText),
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
                    "286",
                    style:
                        textStyleW600(size.width * 0.040, AppColors.blackText),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: size.height * 0.028,
                    width: size.height * 0.028,
                    child: GestureDetector(
                      onTap: () => controller.toggleBookMark(post.id ?? 0),
                      child: Icon(
                        // Observe like status
                        controller.bookmarkStatusMap[post.id ?? 0] ?? false
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color:
                            controller.bookmarkStatusMap[post.id ?? 0] ?? false
                                ? AppColors.primaryColor
                                : null,
                        size: size.height * 0.032,
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
      ),
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
