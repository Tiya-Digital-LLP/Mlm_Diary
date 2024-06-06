import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';

class MyProfileCard extends StatefulWidget {
  final String userImage;
  final String userName;
  final String postCaption;
  final String postImage;
  final VoidCallback onDelete;
  final String dateTime;

  const MyProfileCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.postCaption,
    required this.postImage,
    required this.onDelete,
    required this.dateTime,
  });

  @override
  State<MyProfileCard> createState() => _MyProfileCardState();
}

class _MyProfileCardState extends State<MyProfileCard> {
  late PostTimeFormatter postTimeFormatter;

  @override
  void initState() {
    super.initState();
    postTimeFormatter = PostTimeFormatter();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.035, vertical: size.height * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0XFFCCC9C9),
                    radius: size.width * 0.07,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: widget.userImage,
                        height: 97,
                        width: 105,
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.userName,
                            style: textStyleW700(
                                size.width * 0.043, AppColors.blackText),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Added Classified",
                            style: textStyleW400(size.width * 0.037,
                                AppColors.blackText.withOpacity(0.5)),
                          ),
                        ],
                      ),
                      Text(
                        postTimeFormatter.formatPostTime(widget.dateTime),
                        style: textStyleW400(size.width * 0.035,
                            AppColors.blackText.withOpacity(0.5)),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                widget.postCaption,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackText,
                  fontSize: size.width * 0.045,
                ),
              ),
              SizedBox(
                height: size.height * 0.012,
              ),
              Container(
                height: size.height * 0.28,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.postImage,
                  height: 97,
                  width: 105,
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(
                height: size.height * 0.017,
              ),
              Row(
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
                        child: SvgPicture.asset(Assets.svgLike),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        "50k",
                        style: TextStyle(
                            fontFamily: "Metropolis",
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.045),
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
                        style: TextStyle(
                            fontFamily: "Metropolis",
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.045),
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
            ],
          ),
          Positioned(
            top: 0,
            right: -16,
            child: PopupMenuButton(
              color: AppColors.white,
              elevation: 9,
              icon: const Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    onTap: () {
                      Get.toNamed(Routes.editpost);
                    },
                    value: 'edit',
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.svgEditSquare),
                        8.sbw,
                        const Text('Edit'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                    value: 'delete',
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.svgDelete),
                        8.sbw,
                        const Text('Delete'),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
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
                decoration: const BoxDecoration(
                  // color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Center(
                    child: Icon(
                  Icons.cancel_outlined,
                  size: 80,
                  color: AppColors.redText,
                )),
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
                    'Do you want to delete',
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
                                  backgroundColor: AppColors.redText,
                                  shadowColor: AppColors.redText,
                                  elevation: 3,
                                ),
                                onPressed: () {
                                  widget.onDelete();
                                  Get.back();
                                },
                                child: Text(
                                  'Delete',
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
}
