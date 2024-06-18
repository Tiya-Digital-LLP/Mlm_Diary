import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/custom_company_comment.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:share_plus/share_plus.dart';

class MlmCompaniesCard extends StatefulWidget {
  final String userImage;
  final String postTitle;
  final String postCaption;
  final String location;
  final int companyId;
  final int viewcounts;
  final int likedCount;
  final String shareurl;
  final int commentcount;

  final CompanyController controller;
  const MlmCompaniesCard({
    super.key,
    required this.userImage,
    required this.postTitle,
    required this.postCaption,
    required this.location,
    required this.companyId,
    required this.viewcounts,
    required this.likedCount,
    required this.controller,
    required this.shareurl,
    required this.commentcount,
  });

  @override
  State<MlmCompaniesCard> createState() => _MlmcompaniesCardState();
}

class _MlmcompaniesCardState extends State<MlmCompaniesCard> {
  late RxBool isLiked;
  late RxBool isBookmarked;

  late RxInt likeCount;
  late RxInt bookmarkCount;
  @override
  void initState() {
    super.initState();
    initializeLikes();
    initializeBookmarks();
  }

  void initializeLikes() {
    isLiked =
        RxBool(widget.controller.likedStatusMap[widget.companyId] ?? false);
    likeCount = RxInt(
        widget.controller.likeCountMap[widget.companyId] ?? widget.likedCount);
  }

  void toggleLike() async {
    bool newLikedValue = !isLiked.value;
    isLiked.value = newLikedValue;
    likeCount.value = newLikedValue ? likeCount.value + 1 : likeCount.value - 1;

    await widget.controller.toggleLike(widget.companyId, context);
  }

  void initializeBookmarks() {
    isBookmarked =
        RxBool(widget.controller.bookmarkStatusMap[widget.companyId] ?? false);
  }

  void toggleBookmark() async {
    bool newBookmarkedValue = !isBookmarked.value;
    isBookmarked.value = newBookmarkedValue;
    await widget.controller.toggleBookMark(widget.companyId);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String decodedPostDescription = HtmlUnescape().convert(widget.postCaption);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.035, vertical: size.height * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5,
                    color: AppColors.grey.withOpacity(0.5),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: widget.userImage,
                    height: 60.0,
                    width: 60.0,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              10.sbw,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.postTitle,
                          style: textStyleW700(
                              size.width * 0.040, AppColors.blackText),
                        ),
                      ],
                    ),
                    Text(
                      widget.location,
                      style: textStyleW400(
                        size.width * 0.032,
                        AppColors.blackText.withOpacity(0.5),
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Html(
              data: decodedPostDescription,
              style: {
                "html": Style(
                  maxLines: 2,
                ),
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.026,
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
                        color: isLiked.value ? AppColors.primaryColor : null,
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
                        onTap: () => showFullScreenDialogCompany(
                          context,
                          widget.companyId,
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
                    'Views (${widget.viewcounts})',
                    style: TextStyle(
                        fontFamily: "Metropolis",
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.038),
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
                  InkWell(
                    onTap: () {
                      Share.share(widget.shareurl);
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
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
