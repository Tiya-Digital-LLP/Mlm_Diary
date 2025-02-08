import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/classified_like_list_content.dart';
import 'package:mlmdiary/classified/classified_view_list_content.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/classified/custom/custom_commment.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/home/custom/sign_up_dialog.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/dynamiclink/dynamic_link.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassifiedCard extends StatefulWidget {
  final String userImage;
  final String userName;
  final String postTitle;
  final String postCaption;

  final String dateTime;
  final String updatedateTime;
  final int likedCount;
  final int classifiedId;
  final ClasifiedController controller;
  final int viewcounts;
  final int bookmarkCount;
  final bool isPopular;
  final String image;
  final String url;
  final bool likedbyuser;
  final bool bookmarkedbyuser;
  final int commentcount;

  const ClassifiedCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.postTitle,
    required this.postCaption,
    required this.dateTime,
    required this.updatedateTime,
    required this.likedCount,
    required this.classifiedId,
    required this.controller,
    required this.viewcounts,
    required this.bookmarkCount,
    required this.isPopular,
    required this.image,
    required this.url,
    required this.likedbyuser,
    required this.commentcount,
    required this.bookmarkedbyuser,
  });

  @override
  State<ClassifiedCard> createState() => _ClassifiedCardState();
}

class _ClassifiedCardState extends State<ClassifiedCard>
    with SingleTickerProviderStateMixin {
  late RxBool isLiked;
  late RxBool isBookmarked;
  late RxInt likeCount;
  late RxInt bookmarkCount;
  late PostTimeFormatter postTimeFormatter;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    postTimeFormatter = PostTimeFormatter();
    initializeLikes();
    initializeBookmarks();
  }

  void initializeLikes() {
    isLiked = RxBool(widget.likedbyuser);
    likeCount = RxInt(widget.likedCount);
  }

  void initializeBookmarks() {
    isBookmarked = RxBool(widget.bookmarkedbyuser);
    bookmarkCount = RxInt(widget.bookmarkCount);
  }

  void showSignupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SignupDialog();
      },
    );
  }

  void toggleLike() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString(Constants.accessToken);
    bool newLikedValue = !isLiked.value;
    isLiked.value = newLikedValue;
    likeCount.value = newLikedValue ? likeCount.value + 1 : likeCount.value - 1;
    // ignore: use_build_context_synchronously
    await widget.controller.toggleLike(widget.classifiedId, context);
  }

  void toggleBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString(Constants.accessToken);
    bool newBookmarkedValue = !isBookmarked.value;
    isBookmarked.value = newBookmarkedValue;
    bookmarkCount.value =
        newBookmarkedValue ? bookmarkCount.value + 1 : bookmarkCount.value - 1;
    // ignore: use_build_context_synchronously
    await widget.controller.toggleBookMark(widget.classifiedId, context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.035, vertical: size.height * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.white,
          border: Border.all(
            color: widget.isPopular ? Colors.yellow : Colors.transparent,
            width: 3.0,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: widget.image,
                    height: 60,
                    width: 60,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) =>
                        Image.asset(Assets.imagesAdminlogo),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userName,
                        style: textStyleW700(
                          size.width * 0.038,
                          AppColors.blackText,
                        ),
                        maxLines: 1,
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
                const Spacer(),
                if (widget.isPopular)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.yellow),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: const EdgeInsets.only(top: 5, right: 5),
                    child: const Text(
                      'Premium',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: size.height * 0.01),
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
            // if (widget.userImage.isNotEmpty &&
            //     Uri.tryParse(widget.userImage)?.hasAbsolutePath == true)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: SizedBox(
                height: size.height * 0.26,
                width: size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    widget.userImage,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        Assets.imagesLogo,
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.017),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: size.height * 0.028,
                      width: size.height * 0.028,
                      child: InkWell(
                        onTap: toggleLike,
                        child: Icon(
                          isLiked.value
                              ? Icons.thumb_up_off_alt_sharp
                              : Icons.thumb_up_off_alt_outlined,
                          color: isLiked.value ? AppColors.primaryColor : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
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
                    15.sbw,
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.getString(Constants.accessToken);
                            showFullScreenDialog(
                              // ignore: use_build_context_synchronously
                              context,
                              widget.classifiedId,
                            );
                          },
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
                    15.sbw,
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
                    10.sbw,
                    InkWell(
                      onTap: () async {
                        try {
                          final dynamicLink = await createDynamicLink(
                            widget.url,
                            'Classified',
                            widget.classifiedId.toString(),
                          );

                          debugPrint('Generated Dynamic Link: $dynamicLink');
                          await Share.share(dynamicLink);
                        } catch (e) {
                          debugPrint('Error sharing link: $e');
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text("Error creating or sharing link: $e")),
                          );
                        }
                      },
                      child: SizedBox(
                        height: size.height * 0.028,
                        width: size.height * 0.028,
                        child: SvgPicture.asset(
                          Assets.svgSend,
                          // ignore: deprecated_member_use
                          color: AppColors.blackText,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
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
                ClassifiedLikedListContent(classifiedId: widget.classifiedId),
                ClassifiedViewListContent(clasiifiedId: widget.classifiedId),
              ],
            ),
          ),
        );
      },
    );
  }
}
