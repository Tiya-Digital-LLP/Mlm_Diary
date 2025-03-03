// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/blog/custom_blog_comment.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/logout_dialog/custom_logout_dialog.dart';

class ManageBlogCard extends StatefulWidget {
  final String userImage;
  final String userName;
  final String postTitle;
  final String postCaption;
  final String postImage;
  final VoidCallback onDelete;
  final String dateTime;
  final int likedCount;
  final int viewcounts;
  final int blogId;
  final int blogstatus;
  final int commentcount;

  final int bookmarkCount;
  final bool likedbyuser;
  final bool bookmarkedbyuser;

  final ManageBlogController controller;
  final String updatedateTime;

  const ManageBlogCard(
      {super.key,
      required this.userImage,
      required this.userName,
      required this.postTitle,
      required this.postCaption,
      required this.postImage,
      required this.onDelete,
      required this.dateTime,
      required this.likedCount,
      required this.controller,
      required this.viewcounts,
      required this.bookmarkCount,
      required this.blogId,
      required this.blogstatus,
      required this.commentcount,
      required this.likedbyuser,
      required this.bookmarkedbyuser,
      required this.updatedateTime});

  @override
  State<ManageBlogCard> createState() => _ManageBlogCardState();
}

class _ManageBlogCardState extends State<ManageBlogCard> {
  late RxBool isLiked;
  late RxBool isBookmarked;

  late RxInt likeCount;
  late RxInt bookmarkCount;

  late PostTimeFormatter postTimeFormatter;

  @override
  void initState() {
    super.initState();
    postTimeFormatter = PostTimeFormatter();
    initializeLikes();
    initializeBookmarks();
  }

  void initializeLikes() {
    isLiked = RxBool(widget.likedbyuser);
    likeCount = RxInt(widget.likedCount);
  }

  void toggleLike() async {
    bool newLikedValue = !isLiked.value;
    isLiked.value = newLikedValue;
    likeCount.value = newLikedValue ? likeCount.value + 1 : likeCount.value - 1;

    await widget.controller.toggleLike(widget.blogId, context);
  }

  void initializeBookmarks() {
    isBookmarked =
        RxBool(widget.controller.bookmarkStatusMap[widget.blogId] ?? false);
    bookmarkCount = RxInt(widget.controller.bookmarkCountMap[widget.blogId] ??
        widget.bookmarkCount);
  }

  void toggleBookmark() async {
    bool newBookmarkedValue = !isBookmarked.value;
    isBookmarked.value = newBookmarkedValue;
    bookmarkCount.value =
        newBookmarkedValue ? bookmarkCount.value + 1 : bookmarkCount.value - 1;

    await widget.controller.toggleBookMark(widget.blogId, context);
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: widget.postImage,
                    height: 97,
                    width: 105,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                10.sbw,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Html(
                          data: widget.postTitle,
                          style: {
                            "html": Style(
                              lineHeight: const LineHeight(1),
                              maxLines: 1,
                              fontFamily: satoshiFontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: FontSize.medium,
                              color: AppColors.blackText,
                            ),
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Html(
                          data: widget.postCaption,
                          style: {
                            "html": Style(
                              lineHeight: const LineHeight(1.2),
                              maxLines: 2,
                              fontFamily: satoshiFontFamily,
                              fontWeight: FontWeight.w400,
                              fontSize: FontSize.small,
                              color: AppColors.blackText,
                            ),
                          },
                        ),
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
                        size.width * 0.038,
                        AppColors.blackText,
                        isMetropolis: true,
                      ),
                    ),
                    15.sbw,
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => showFullScreenDialogBlog(
                            context,
                            widget.blogId,
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
                          style: textStyleW600(
                            size.width * 0.038,
                            AppColors.blackText,
                            isMetropolis: true,
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
                      style: textStyleW600(
                        size.width * 0.038,
                        AppColors.blackText,
                        isMetropolis: true,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Material(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(
                            Routes.blogplusicon,
                            arguments: widget.blogId,
                          );
                          widget.controller.fetchBlogDetailforManagePlusBlog(
                              widget.blogId, context);
                        },
                        child: Ink(
                          height: size.height * 0.030,
                          width: size.height * 0.030,
                          child: SvgPicture.asset(Assets.svgPostEdit),
                        ),
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
                    color: getStatusColor(widget.blogstatus),
                  ),
                  child: Center(
                    child: Text(
                      getStatusText(widget.blogstatus),
                      style: textStyleW700(
                        size.width * 0.035,
                        AppColors.blackText,
                        isMetropolis: true,
                      ),
                    ),
                  ),
                ),
                Text(
                  postTimeFormatter.formatPostTime(
                    DateTime.parse(widget.dateTime).isAtSameMomentAs(
                            DateTime.parse(widget.updatedateTime))
                        ? widget.dateTime
                        : widget.updatedateTime,
                  ),
                  style: textStyleW400(
                    size.width * 0.035,
                    AppColors.blackText.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
