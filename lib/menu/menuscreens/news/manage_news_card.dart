import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/custom_news_comment.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/logout_dialog/custom_logout_dialog.dart';

class ManageNewsCard extends StatefulWidget {
  final String userImage;
  final String userName;
  final String postTitle;
  final String postCaption;
  final String postImage;
  final VoidCallback onDelete;
  final String dateTime;
  final int viewcounts;
  final int likedCount;
  final int newsId;
  final int newsstatus;
  final int commentcount;
  final bool likedbyuser;
  final bool bookmarkedbyuser;

  final ManageNewsController controller;

  const ManageNewsCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.postTitle,
    required this.postCaption,
    required this.postImage,
    required this.onDelete,
    required this.dateTime,
    required this.viewcounts,
    required this.likedCount,
    required this.newsId,
    required this.controller,
    required this.newsstatus,
    required this.commentcount,
    required this.likedbyuser,
    required this.bookmarkedbyuser,
  });

  @override
  State<ManageNewsCard> createState() => _ManageNewsCardState();
}

class _ManageNewsCardState extends State<ManageNewsCard> {
  late PostTimeFormatter postTimeFormatter;
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

    await widget.controller.toggleLike(widget.newsId, context);
  }

  String getStatusText(int status) {
    switch (status) {
      case 0:
        return 'Pending';
      case 1:
        return 'Approved';
      case 2:
        return 'Rejected';
      default:
        return 'Unknown';
    }
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.orange.withOpacity(0.5);
      case 1:
        return Colors.green.withOpacity(0.5);
      case 2:
        return Colors.red.withOpacity(0.5);
      default:
        return Colors.grey.withOpacity(0.5);
    }
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
                Image.network(
                  '${widget.userImage}?t=${DateTime.now().millisecondsSinceEpoch}',
                  height: 97,
                  width: 105,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                  headers: const {'Cache-Control': 'no-cache'},
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
                      )
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
                    SizedBox(
                      height: size.height * 0.028,
                      width: size.height * 0.028,
                      child: GestureDetector(
                        onTap: toggleLike,
                        child: Icon(
                          isLiked.value
                              ? Icons.thumb_up_off_alt_sharp
                              : Icons.thumb_up_off_alt_outlined,
                          color: isLiked.value ? AppColors.primaryColor : null,
                        ),
                      ),
                    ),
                    7.sbw,
                    Text(
                      '${likeCount.value}',
                      style: textStyleW600(
                          size.width * 0.038, AppColors.blackText),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => showFullScreenDialogNews(
                            context,
                            widget.newsId,
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
                      '${widget.viewcounts}',
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
                        Get.toNamed(
                          Routes.newsplusicon,
                          arguments: widget.newsId,
                        );
                        await widget.controller.fetchMyNews(
                          newsId: widget.newsId,
                        );
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: getStatusColor(widget.newsstatus),
                  ),
                  child: Center(
                    child: Text(
                      getStatusText(widget.newsstatus),
                      style: textStyleW600(
                          size.width * 0.035, AppColors.blackText),
                    ),
                  ),
                ),
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
