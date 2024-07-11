import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/manage_news_card.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:mlmdiary/widgets/remimaining_count_controller./remaining_count.dart';

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
    await controller.deleteNews(newsId, index, context);
  }

  Future<void> _refreshData() async {
    await controller.fetchMyNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'Manage News',
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.primaryColor,
        color: AppColors.white,
        onRefresh: _refreshData,
        child: Container(
          color: AppColors.background,
          child: Obx(() {
            if (kDebugMode) {
              print('isLoading: ${controller.isLoading.value}');
              print('myNewsList: ${controller.myNewsList.length}');
            }
            if (controller.isLoading.value && controller.myNewsList.isEmpty) {
              return Center(
                  child: CustomLottieAnimation(
                child: Lottie.asset(
                  Assets.lottieLottie,
                ),
              ));
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
                        userImage: post.imagePath ?? '',
                        userName: post.userData!.name ?? '',
                        postTitle: post.title ?? '',
                        postCaption: post.description ?? '',
                        postImage: post.photo ?? '',
                        dateTime: post.createdate ?? '',
                        viewcounts: post.pgcnt ?? 0,
                        newsId: post.id ?? 0,
                        likedCount: post.totallike ?? 0,
                        controller: controller,
                        newsstatus: post.status ?? 0,
                        commentcount: post.totalcomment ?? 0,
                        likedbyuser: post.likedByUser ?? false,
                        bookmarkedbyuser: post.bookmarkedByUser ?? false,
                      ),
                    ),
                  );
                });
          }),
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
