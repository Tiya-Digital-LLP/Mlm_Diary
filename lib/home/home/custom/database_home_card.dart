import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/home/controller/homescreen_controller.dart';
import 'package:mlmdiary/home/home/custom/sign_up_dialog.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHomeCard extends StatefulWidget {
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

  final HomeController controller;

  const DatabaseHomeCard({
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
  State<DatabaseHomeCard> createState() => _FavouritrCardState();
}

class _FavouritrCardState extends State<DatabaseHomeCard> {
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

  void showSignupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SignupDialog();
      },
    );
  }

  Future<void> togleBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    if (apiToken == null) {
      // ignore: use_build_context_synchronously
      showSignupDialog(context);
      return;
    }
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.postImage.isNotEmpty &&
                    Uri.tryParse(widget.postImage)?.hasAbsolutePath == true)
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        widget.postImage,
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            Assets.imagesAdminlogo,
                            fit: BoxFit.fill,
                          );
                        },
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
                        style: textStyleW500(
                            size.width * 0.032, AppColors.blackText),
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
                              style: textStyleW500(
                                  size.width * 0.032, AppColors.blackText),
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
                                    ? Assets.svgCheckBookmark
                                    : Assets.svgSavePost,
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
