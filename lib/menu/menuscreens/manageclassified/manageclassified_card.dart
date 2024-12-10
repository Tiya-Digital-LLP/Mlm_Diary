import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/custom/custom_commment.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/manageclassified/controller/manage_classified_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/logout_dialog/custom_logout_dialog.dart';

class ManageClassifiedCard extends StatefulWidget {
  const ManageClassifiedCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.postTitle,
    required this.dateTime,
    required this.classifiedId,
    required this.postCaption,
    required this.postTime,
    required this.onDelete,
    required this.controller,
    required this.viewcounts,
    required this.likedCount,
    required this.commentcount,
    required this.likedbyuser,
    required this.bookmarkedbyuser,
  });
  final String userImage;
  final String userName;
  final String postTitle;
  final String dateTime;
  final int classifiedId;

  final String postCaption;
  final String postTime;
  final VoidCallback onDelete;
  final ManageClasifiedController controller;
  final int viewcounts;
  final int likedCount;
  final int commentcount;
  final bool likedbyuser;
  final bool bookmarkedbyuser;

  @override
  State<ManageClassifiedCard> createState() => _ManageClassifiedCardState();
}

class _ManageClassifiedCardState extends State<ManageClassifiedCard> {
  late PostTimeFormatter postTimeFormatter;

  //liked
  late RxBool isLiked;
  late RxInt likeCount;

  @override
  void initState() {
    super.initState();
    postTimeFormatter = PostTimeFormatter();
    initializeLikes();
  }

  void initializeLikes() {
    isLiked = RxBool(widget.likedbyuser);
    likeCount = RxInt(widget.likedCount);
  }

  void toggleLike() async {
    bool newLikedValue = !isLiked.value;
    isLiked.value = newLikedValue;
    likeCount.value = newLikedValue ? likeCount.value + 1 : likeCount.value - 1;

    await widget.controller.toggleLike(widget.classifiedId);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Replace Image.asset with CachedNetworkImage
                CachedNetworkImage(
                  imageUrl:
                      '${widget.userImage}?t=${DateTime.now().millisecondsSinceEpoch}',
                  height: 97,
                  width: 105,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                10.sbw,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.postTitle,
                        style: textStyleW700(
                            size.width * 0.038, AppColors.blackText),
                      ),
                      Text(
                        widget.postCaption,
                        style: textStyleW400(size.width * 0.035,
                            AppColors.blackText.withOpacity(0.8)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          onTap: toggleLike,
                          child: Icon(
                            isLiked.value
                                ? Icons.thumb_up_off_alt_sharp
                                : Icons.thumb_up_off_alt_outlined,
                            color:
                                isLiked.value ? AppColors.primaryColor : null,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    likeCount.value == 0
                        ? const SizedBox.shrink()
                        : Text(
                            likeCount.value.toString(),
                            style: textStyleW600(
                                size.width * 0.038, AppColors.blackText),
                          ),
                    const SizedBox(
                      width: 15,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => showFullScreenDialog(
                            context,
                            widget.classifiedId,
                          ),
                          child: SizedBox(
                            height: size.height * 0.028,
                            width: size.height * 0.028,
                            child: SvgPicture.asset(Assets.svgComment),
                          ),
                        ),
                        5.sbw,
                        Text(
                          '${widget.commentcount}',
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
                      widget.viewcounts.toString(),
                      style: TextStyle(
                          fontFamily: "Metropolis",
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.038),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        bool success = await widget.controller
                            .boostOnTopClassifiedPremium(
                                widget.classifiedId, context);
                        if (success) {
                          showDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                contentPadding: EdgeInsets.zero,
                                content: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 80,
                                        decoration: const BoxDecoration(
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
                                          ),
                                        ),
                                      ),
                                      16.sbh,
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Text(
                                          'You wanted to premium classified to top so you have to pay. For Details',
                                          style: textStyleW600(
                                            size.width * 0.032,
                                            AppColors.blackText,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text(
                                                      'Cancel',
                                                      style: textStyleW700(
                                                          size.width * 0.035,
                                                          AppColors.blackText),
                                                    ),
                                                  ),
                                                ),
                                                5.sbw,
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor: AppColors
                                                          .primaryColor,
                                                      shadowColor: AppColors
                                                          .primaryColor,
                                                      elevation: 3,
                                                    ),
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text(
                                                      'Pay Now',
                                                      style: textStyleW700(
                                                          size.width * 0.035,
                                                          AppColors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          //
                        }
                      },
                      child: Ink(
                        height: size.height * 0.030,
                        width: size.height * 0.030,
                        child: SvgPicture.asset(Assets.svgPostBoost),
                      ),
                    ),
                    10.sbw,
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.manageClassifiedplusicon,
                          arguments: widget.classifiedId,
                        );
                        widget.controller.fetchClassifiedDetail(
                            widget.classifiedId, context);
                      },
                      child: Ink(
                        height: size.height * 0.030,
                        width: size.height * 0.030,
                        child: SvgPicture.asset(Assets.svgPostEdit),
                      ),
                    ),
                    10.sbw,
                    InkWell(
                      onTap: () {
                        LogoutDialog.show(context, () {
                          widget.onDelete();
                        });
                      },
                      child: Ink(
                        height: size.height * 0.030,
                        width: size.height * 0.030,
                        child: SvgPicture.asset(Assets.svgPostDelete),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          10.sbh,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.white,
              border: const Border(bottom: BorderSide(color: Colors.grey)),
            ),
          ),
          10.sbh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    widget.controller
                        .boostOnTopClassified(widget.classifiedId, context);
                  },
                  child: Container(
                    width: 120,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: AppColors.primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        'Post on top',
                        style:
                            textStyleW500(size.width * 0.035, AppColors.white),
                      ),
                    ),
                  ),
                ),
                20.sbw,
                Text(
                  postTimeFormatter.formatPostTime(widget.dateTime),
                  style: textStyleW500(
                      size.width * 0.028, AppColors.blackText.withOpacity(0.5)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
