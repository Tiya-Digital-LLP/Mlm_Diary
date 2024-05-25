import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/post_card.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/home/suggestion_user_card.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/lists.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  final _search = TextEditingController();
  final isSearchVisible = RxBool(false);
  int backPressedCount = 0;
  final GlobalKey _popupMenuButtonKey = GlobalKey();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          if (backPressedCount == 0) {
            Fluttertoast.showToast(
              msg: "Please Double Click to Close App",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
            backPressedCount++;
            return false;
          } else {
            return true;
          }
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.background),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top + 10),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.04),
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
                              GestureDetector(
                                onTap: () {
                                  isSearchVisible.toggle();
                                },
                                child: SizedBox(
                                  height: size.height * 0.036,
                                  width: size.height * 0.036,
                                  child: SvgPicture.asset(
                                    Assets.svgSearchNormal,
                                  ),
                                ),
                              ),

                              // BUILDING ICON
                              SizedBox(
                                height: size.height * 0.036,
                                width: size.height * 0.036,
                                child: SvgPicture.asset(
                                  Assets.svgBuilding,
                                ),
                              ),

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
                                  ),
                                ),
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
                                  ),
                                ),
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
                  Obx(() => Visibility(
                        visible: isSearchVisible.value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomSearchInput(
                                  controller: _search,
                                  onSubmitted: (value) {
                                    WidgetsBinding
                                        .instance.focusManager.primaryFocus
                                        ?.unfocus();
                                  },
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      WidgetsBinding
                                          .instance.focusManager.primaryFocus;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.04),
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
                            style: textStyleW700(
                                size.width * 0.048, AppColors.blackText),
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
                                        width: (index == 0)
                                            ? 0
                                            : size.width * 0.03,
                                      ),
                                      SuggestionUserCard(
                                        userImage:
                                            suggestedAUserList[index].userImage,
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
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: PopupMenuButton(
                  padding: const EdgeInsets.only(
                    top: 260,
                  ),
                  elevation: 9,
                  color: AppColors.white,
                  key: _popupMenuButtonKey,
                  itemBuilder: (_) => <PopupMenuEntry>[
                    PopupMenuItem(
                      value: 1,
                      onTap: () {
                        Get.toNamed(Routes.addpost);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.svgClipboardText),
                          3.sbw,
                          const Text('Add Post'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      onTap: () {
                        Get.toNamed(Routes.addclassified);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.svgGrid3),
                          3.sbw,
                          const Text('Add Classified'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.svgMessageQuestion),
                          3.sbw,
                          const Text('Add Question'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 4,
                      onTap: () {
                        Get.toNamed(Routes.addblog);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.svgDocumentText),
                          3.sbw,
                          const Text('Add Blog'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 5,
                      onTap: () {
                        Get.toNamed(Routes.addnews);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.svgClipboardText),
                          3.sbw,
                          const Text('Add News'),
                        ],
                      ),
                    ),
                  ],
                  icon: SvgPicture.asset(Assets.svgPlusIcon),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
