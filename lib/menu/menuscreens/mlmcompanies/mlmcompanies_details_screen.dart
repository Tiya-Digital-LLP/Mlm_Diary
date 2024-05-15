import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/modal_class/mlmcompany_class.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';

class MlmCompaniesDetails extends StatefulWidget {
  final MlmCompanyList post;
  const MlmCompaniesDetails({super.key, required this.post});

  @override
  State<MlmCompaniesDetails> createState() => _MlmCompaniesDetailsState();
}

class _MlmCompaniesDetailsState extends State<MlmCompaniesDetails> {
  final CompanyController controller = Get.put(CompanyController());
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
                                Image.asset(
                                  widget.post.userImage,
                                  width: 100,
                                  height: 100,
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
                              widget.post.postTitle,
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
                                widget.post.location,
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
                                        'Phone',
                                        style: textStyleW400(
                                            size.width * 0.035, AppColors.grey),
                                      ),
                                      const SizedBox(
                                        width: 07,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "+91 74223 23432",
                                    style: textStyleW400(size.width * 0.035,
                                        AppColors.blackText),
                                  ),
                                ],
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
                                    "info@seacret.com",
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
                                        'Website',
                                        style: textStyleW400(
                                            size.width * 0.035, AppColors.grey),
                                      ),
                                      const SizedBox(
                                        width: 07,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "www.allcupcoatings.com",
                                    style: textStyleW400(size.width * 0.035,
                                        AppColors.blackText),
                                  ),
                                ],
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
                                      SvgPicture.asset(Assets.svgLogosFacebook),
                                      12.sbw,
                                      SvgPicture.asset(Assets.svgInstagram),
                                      12.sbw,
                                      SvgPicture.asset(
                                          Assets.svgLogosLinkedinIcon),
                                      12.sbw,
                                      SvgPicture.asset(Assets.svgYoutube),
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
                              Text(
                                widget.post.postCaption,
                                style: textStyleW400(
                                    size.width * 0.035, AppColors.blackText),
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
            child: Obx(
              () => Row(
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
                          onTap: () => controller.toggleLike(),
                          child: Icon(
                            controller.isLiked.value
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: controller.isLiked.value
                                ? AppColors.primaryColor
                                : null,
                            size: size.height * 0.030,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      controller.likeCount.value == 0
                          ? const SizedBox.shrink()
                          : Text(
                              controller.likeCount.value.toString(),
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
                        style: textStyleW600(
                            size.width * 0.040, AppColors.blackText),
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
                        style: textStyleW600(
                            size.width * 0.040, AppColors.blackText),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: size.height * 0.028,
                        width: size.height * 0.028,
                        child: SvgPicture.asset(Assets.svgSavePost),
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
            )),
      ),
    );
  }
}
