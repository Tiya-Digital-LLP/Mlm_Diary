import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/post_card.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/suggestion_user_card.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/lists.dart';
import 'package:mlmdiary/utils/text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.background),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: size.height * 0.08,
                  width: size.width * 0.45,
                  child: Image.asset(
                    Assets.imagesLogo,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.42,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SEARCH ICON
                      SizedBox(
                          height: size.height * 0.036,
                          width: size.height * 0.036,
                          child: SvgPicture.asset(
                            Assets.svgSearchNormal,
                          )),

                      // BUILDING ICON
                      SizedBox(
                          height: size.height * 0.036,
                          width: size.height * 0.036,
                          child: SvgPicture.asset(
                            Assets.svgBuilding,
                          )),

                      // MESSAGE ICON
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.messagescreen);
                        },
                        child: SizedBox(
                            height: size.height * 0.036,
                            width: size.height * 0.036,
                            child: SvgPicture.asset(
                              Assets.svgMessageIcon,
                            )),
                      ),

                      // NOTIFICATION ICON
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.notification);
                        },
                        child: SizedBox(
                            height: size.height * 0.036,
                            width: size.height * 0.036,
                            child: SvgPicture.asset(
                              Assets.svgNotificationBing,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.22,
                    child: Image.asset(
                      Assets.imagesLabel,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  Text(
                    "People You May Know",
                    style:
                        textStyleW700(size.width * 0.048, AppColors.blackText),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int index = 0;
                            index < suggestedAUserList.length;
                            index++)
                          Row(
                            children: [
                              SizedBox(
                                width: (index == 0) ? 0 : size.width * 0.03,
                              ),
                              SuggestionUserCard(
                                userImage: suggestedAUserList[index].userImage,
                                name: suggestedAUserList[index].name,
                                post: suggestedAUserList[index].post,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Container(
                    height: size.height * 0.015,
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      final post = postList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: PostCard(
                          userImage: post.userImage,
                          userName: post.userName,
                          postCaption: post.postCaption,
                          postImage: post.postImage,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
