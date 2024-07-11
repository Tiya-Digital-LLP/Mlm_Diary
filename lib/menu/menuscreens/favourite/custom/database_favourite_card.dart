import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/favourite/controller/favourite_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class DatabaseFavouriteCard extends StatefulWidget {
  final String userImage;
  final String userName;
  final String postTitle;
  final String postLocation;
  final String postImage;
  final String dateTime;
  final int bookmarkId;
  final String immlm;
  final String type;
  final String plan;

  final ManageBlogController manageBlogController;
  final ManageNewsController manageNewsController;
  final ClasifiedController clasifiedController;
  final QuestionAnswerController questionAnswerController;

  final EditPostController editpostController;

  final CompanyController companyController;

  final FavouriteController controller;

  const DatabaseFavouriteCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.postTitle,
    required this.postLocation,
    required this.postImage,
    required this.dateTime,
    required this.controller,
    required this.bookmarkId,
    required this.type,
    required this.manageBlogController,
    required this.manageNewsController,
    required this.clasifiedController,
    required this.companyController,
    required this.immlm,
    required this.plan,
    required this.editpostController,
    required this.questionAnswerController,
  });

  @override
  State<DatabaseFavouriteCard> createState() => _FavouritrCardState();
}

class _FavouritrCardState extends State<DatabaseFavouriteCard> {
  late bool isBookmarked;

  @override
  void initState() {
    super.initState();

    isBookmarked = widget.controller.isItemBookmark(
      widget.type,
      widget.bookmarkId,
      widget.manageBlogController,
      widget.manageNewsController,
      widget.clasifiedController,
      widget.companyController,
      widget.editpostController,
      widget.questionAnswerController,
      widget.editpostController,
    );
  }

  void togleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
      widget.controller.toggleBookmark(
        widget.type,
        widget.bookmarkId,
        context,
        widget.manageBlogController,
        widget.manageNewsController,
        widget.clasifiedController,
        widget.companyController,
        widget.editpostController,
        widget.questionAnswerController,
        widget.editpostController,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey, width: 2),
                      borderRadius: BorderRadius.circular(100)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: widget.postImage,
                      height: 60,
                      width: 60,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => CustomLottieAnimation(
                        child: Lottie.asset(
                          Assets.lottieLottie,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                10.sbw,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.userName,
                              style: textStyleW700(
                                  size.width * 0.038, AppColors.blackText),
                            ),
                          ),
                          Container(
                            width: 70,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: AppColors.primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                widget.type,
                                style: textStyleW700(
                                  size.width * 0.026,
                                  AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.postLocation,
                        style: textStyleW700(
                            size.width * 0.038, AppColors.blackText),
                      ),
                      Text(
                        widget.immlm,
                        style: textStyleW700(
                            size.width * 0.038, AppColors.blackText),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.plan,
                              style: textStyleW700(
                                size.width * 0.038,
                                AppColors.blackText,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.028,
                            width: size.height * 0.028,
                            child: GestureDetector(
                              onTap: togleBookmark,
                              child: SvgPicture.asset(
                                isBookmarked
                                    ? Assets.svgSavePost
                                    : Assets.svgCheckBookmark,
                                height: size.height * 0.032,
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
          ],
        ),
      ),
    );
  }
}
