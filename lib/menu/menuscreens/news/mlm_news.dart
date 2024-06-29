import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/news_bottomsheet_content.dart';
import 'package:mlmdiary/menu/menuscreens/news/news_card.dart';
import 'package:mlmdiary/menu/menuscreens/tutorialvideo/controller/tutorial_video_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';
import 'package:mlmdiary/widgets/custon_test_app_bar.dart';
import 'package:mlmdiary/widgets/remimaining_count_controller./remaining_count.dart';

class MlmNews extends StatefulWidget {
  const MlmNews({super.key});

  @override
  State<MlmNews> createState() => _MlmNewsScreenState();
}

class _MlmNewsScreenState extends State<MlmNews> {
  final ManageNewsController controller = Get.put(ManageNewsController());
  final TutorialVideoController videoController =
      Get.put(TutorialVideoController());
  static const String position = 'news';
  @override
  void initState() {
    super.initState();
    _refreshData();
    videoController.fetchVideo(position, context);
  }

  Future<void> _refreshData() async {
    await controller.getNews(1);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustonTestAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'MLM News',
        onTap: () {},
        position: position,
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.primaryColor,
        color: AppColors.white,
        onRefresh: _refreshData,
        child: Container(
          color: AppColors.background,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomSearchInput(
                        controller: controller.search,
                        onSubmitted: (value) {
                          WidgetsBinding.instance.focusManager.primaryFocus
                              ?.unfocus();
                          setState(() {});
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            controller.getNews(1);
                          } else {
                            controller.getNews(1);
                          }
                          setState(() {});
                        },
                      ),
                    ),
                    5.sbw,
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return const NewsBottomsheetContent();
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height * 0.048,
                        width: size.height * 0.048,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColors.white, shape: BoxShape.circle),
                        child: SvgPicture.asset(Assets.svgFilter),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value &&
                      controller.newsList.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.newsList.isEmpty) {
                    return const Center(
                      child: Text(
                        'Data not found',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: controller.scrollController,
                    padding: EdgeInsets.zero,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.newsList.length +
                        (controller.isLoading.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == controller.newsList.length) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final post = controller.newsList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: GestureDetector(
                          onTap: () async {
                            await controller.getNews(
                              post.id ?? 0,
                            );
                            Get.toNamed(
                              Routes.newsdetails,
                              arguments: post,
                            );
                          },
                          child: NewsCard(
                            image: post.imageUrl ?? '',
                            dateTime: post.createdate ?? '',
                            newsId: post.id ?? 0,
                            userImage: post.imagePath ?? '',
                            userName: post.userData?.name ?? '',
                            postTitle: post.title ?? '',
                            likedCount: post.totallike ?? 0,
                            controller: controller,
                            viewcounts: post.pgcnt ?? 0,
                            bookmarkCount: post.totalbookmark ?? 0,
                            commentcount: post.totalcomment ?? 0,
                            likedbyuser: post.likedByUser ?? false,
                            bookmarkedbyuser: post.bookmarkedByUser ?? false,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () async {
          var controller = CustomFloatingActionButtonController(context);

          String selectedType = 'news';

          await controller.handleTap(selectedType);
        },
        child: Ink(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              Assets.svgPlusIcon,
            ),
          ),
        ),
      ),
    );
  }
}
