import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/manage_news_card.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';

class ManageNews extends StatefulWidget {
  const ManageNews({super.key});

  @override
  State<ManageNews> createState() => _MlmnewsState();
}

class _MlmnewsState extends State<ManageNews> {
  final ManageNewsController controller = Get.put(ManageNewsController());

  @override
  void initState() {
    super.initState();
    controller.fetchMyNews();
  }

  void deletePost(int index) async {
    int newsId = controller.myNewsList[index].id ?? 0;
    await controller.deleteNews(newsId, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'Manage News',
      ),
      body: Container(
        color: AppColors.background,
        child: Obx(() {
          if (controller.isLoading.value && controller.myNewsList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.myNewsList.isEmpty) {
            return Center(
              child: Text(
                controller.isLoading.value ? 'Loading...' : 'Data not found',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            );
          }
          return ListView.builder(
              padding: EdgeInsets.zero,
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.myNewsList.length,
              itemBuilder: (context, index) {
                final post = controller.myNewsList[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        Routes.mynewsdetails,
                        arguments: controller.myNewsList[index],
                      );
                    },
                    child: ManageNewsCard(
                      onDelete: () => deletePost(index),
                      userImage: post.userData!.imagePath ?? '',
                      userName: post.userData!.name ?? '',
                      postTitle: post.title ?? '',
                      postCaption: post.description ?? '',
                      postImage: post.photo ?? '',
                      dateTime: post.createdate ?? '',
                      viewcounts: post.pgcnt ?? 0,
                      newsId: post.id ?? 0,
                      likedCount: post.totallike ?? 0,
                      controller: controller,
                    ),
                  ),
                );
              });
        }),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Get.toNamed(Routes.addnews);
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
