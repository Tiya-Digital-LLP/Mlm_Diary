import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/custom_news_comment.dart';
import 'package:mlmdiary/menu/menuscreens/news/news_like_list_content.dart';
import 'package:mlmdiary/menu/menuscreens/news/news_view_list_content.dart';
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
  final String updatedateTime;

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
    required this.updatedateTime,
  });

  @override
  State<ManageNewsCard> createState() => _ManageNewsCardState();
}

class _ManageNewsCardState extends State<ManageNewsCard>
    with SingleTickerProviderStateMixin {
  late PostTimeFormatter postTimeFormatter;
  late RxBool isLiked;
  late RxInt likeCount;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

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
        // ignore: deprecated_member_use
        return Colors.orange.withOpacity(0.5);
      case 1:
        // ignore: deprecated_member_use
        return Colors.green.withOpacity(0.5);
      case 2:
        // ignore: deprecated_member_use
        return Colors.red.withOpacity(0.5);
      default:
        // ignore: deprecated_member_use
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
                    imageUrl: widget.userImage,
                    height: 97,
                    width: 105,
                    fit: BoxFit.fill,
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
                              fontFamily: fontFamily,
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
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize.small,
                              color: AppColors.blackText,
                              textOverflow: TextOverflow.ellipsis,
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
                    likeCount.value == 0
                        ? const SizedBox.shrink()
                        : InkWell(
                            onTap: () {
                              showLikeAndViewList(context, 0);
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
                    InkWell(
                      onTap: () {
                        showLikeAndViewList(context, 1);
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            height: size.height * 0.028,
                            width: size.height * 0.028,
                            child: SvgPicture.asset(Assets.svgView),
                          ),
                          6.sbw,
                          widget.viewcounts == 0
                              ? const SizedBox.shrink()
                              : InkWell(
                                  onTap: () {
                                    showLikeAndViewList(context, 1);
                                  },
                                  child: Text(
                                    '${widget.viewcounts}',
                                    style: TextStyle(
                                      fontFamily: "Metropolis",
                                      fontWeight: FontWeight.w600,
                                      fontSize: size.width * 0.038,
                                    ),
                                  ),
                                ),
                        ],
                      ),
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
                        await widget.controller
                            .fetchmyNewsDetail(widget.newsId, context);
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
          ),
        ],
      ),
    );
  }

  void showLikeAndViewList(BuildContext context, int index) {
    _tabController.index = index;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: TabBar(
                indicatorColor: Colors.transparent,
                dividerColor: AppColors.grey,
                labelStyle: TextStyle(
                  color: AppColors.primaryColor,
                ),
                controller: _tabController,
                tabs: const [
                  Tab(text: "Likes"),
                  Tab(text: "Views"),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                NewsLikeListContent(newsId: widget.newsId),
                NewsViewListContent(newsId: widget.newsId),
              ],
            ),
          ),
        );
      },
    );
  }
}
