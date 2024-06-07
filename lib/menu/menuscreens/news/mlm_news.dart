import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/news_bottomsheet_content.dart';
import 'package:mlmdiary/menu/menuscreens/news/news_card.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';

class MlmNews extends StatefulWidget {
  const MlmNews({super.key});

  @override
  State<MlmNews> createState() => _MlmNewsScreenState();
}

class _MlmNewsScreenState extends State<MlmNews> {
  final ManageNewsController controller = Get.put(ManageNewsController());

  @override
  void initState() {
    super.initState();
    controller.getNews(1);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'MLM News',
        onTap: () {},
      ),
      body: Container(
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
                if (controller.isLoading.value && controller.newsList.isEmpty) {
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
                        onTap: () {
                          Get.toNamed(
                            Routes.newsdetails,
                            arguments: controller.newsList[index],
                          );
                        },
                        child: NewsCard(
                          image: post.imagePath ?? '',
                          dateTime: post.createdate ?? '',
                          newsId: post.id ?? 0,
                          userImage: post.imagePath ?? '',
                          userName: post.userData?.name ?? '',
                          postTitle: post.title ?? '',
                          likedCount: post.totallike ?? 0,
                          controller: controller,
                          viewcounts: post.pgcnt ?? 0,
                          bookmarkCount: post.totalbookmark ?? 0,
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
      floatingActionButton: InkWell(
        onTap: () async {
          // controller.isLoading(true);
          // bool success = await controller.classifiedRemainingCount();
          // if (success) {
          Get.toNamed(Routes.addnews);
          // }
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
