import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/custom_post_comment.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/post_like_list_content.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/logout_dialog/custom_logout_dialog.dart';

class MyProfileCard extends StatefulWidget {
  final String userImage;
  final String userName;
  final String postCaption;
  final String postImage;
  final VoidCallback onDelete;
  final String dateTime;
  final int likedCount;
  final int postId;
  final EditPostController controller;
  final int bookmarkCount;
  final int commentcount;
  final String updatedateTime;

  const MyProfileCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.postCaption,
    required this.postImage,
    required this.onDelete,
    required this.dateTime,
    required this.likedCount,
    required this.postId,
    required this.controller,
    required this.bookmarkCount,
    required this.commentcount,
    required this.updatedateTime,
  });

  @override
  State<MyProfileCard> createState() => _MyProfileCardState();
}

class _MyProfileCardState extends State<MyProfileCard> {
  late PostTimeFormatter postTimeFormatter;

  late RxBool isLiked;
  late RxBool isBookmarked;

  late RxInt likeCount;
  late RxInt bookmarkCount;

  @override
  void initState() {
    super.initState();
    postTimeFormatter = PostTimeFormatter();
    initializeLikes();
    initializeBookmarks();
  }

  void initializeLikes() {
    isLiked = RxBool(widget.controller.likedStatusMap[widget.postId] ?? false);
    likeCount = RxInt(
        widget.controller.likeCountMap[widget.postId] ?? widget.likedCount);
  }

  void toggleLike() async {
    bool newLikedValue = !isLiked.value;
    isLiked.value = newLikedValue;
    likeCount.value = newLikedValue ? likeCount.value + 1 : likeCount.value - 1;

    await widget.controller.toggleLike(widget.postId, context);
  }

  void initializeBookmarks() {
    isBookmarked =
        RxBool(widget.controller.bookmarkStatusMap[widget.postId] ?? false);
    bookmarkCount = RxInt(widget.controller.bookmarkCountMap[widget.postId] ??
        widget.bookmarkCount);
  }

  void toggleBookmark() async {
    bool newBookmarkedValue = !isBookmarked.value;
    isBookmarked.value = newBookmarkedValue;
    bookmarkCount.value =
        newBookmarkedValue ? bookmarkCount.value + 1 : bookmarkCount.value - 1;

    await widget.controller.toggleBookMark(widget.postId, context);
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
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
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
                              "Added Post",
                              style: textStyleW400(
                                  size.width * 0.037,
                                  // ignore: deprecated_member_use
                                  AppColors.blackText.withOpacity(0.5)),
                            ),
                          ],
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
                            // ignore: deprecated_member_use
                            AppColors.blackText.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
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
              widget.postImage.isNotEmpty
                  ? Container(
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
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    )
                  : const SizedBox.shrink(),
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
                      const SizedBox(
                        width: 7,
                      ),
                      likeCount.value == 0
                          ? const SizedBox.shrink()
                          : InkWell(
                              onTap: () {
                                showLikeList(context);
                              },
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
                            onTap: () => showFullScreenDialogPost(
                              context,
                              widget.postId,
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
                        child: GestureDetector(
                          onTap: () => toggleBookmark(),
                          child: SvgPicture.asset(
                            isBookmarked.value
                                ? Assets.svgCheckBookmark
                                : Assets.svgSavePost,
                            height: size.height * 0.032,
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
                    onTap: () async {
                      await widget.controller
                          .fetchMyPost(postId: widget.postId);
                      Get.toNamed(Routes.editpost, arguments: widget.postId);
                      if (kDebugMode) {
                        print('postId: ${widget.postId}');
                      }
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
                      LogoutDialog.show(context, () {
                        widget.onDelete();
                      });
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

  void showLikeList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        fetchLikeList();
        return const PostLikeListContent();
      },
    );
  }

  void fetchLikeList() async {
    await widget.controller.fetchLikeListPost(widget.postId, context);
  }
}
