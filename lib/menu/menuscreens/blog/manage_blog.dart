import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/blog/manage_blog_card.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/custom_shimmer_loader/custom_shimmer_classified.dart';
import 'package:mlmdiary/widgets/remimaining_count_controller./remaining_count.dart';

class ManageBlog extends StatefulWidget {
  const ManageBlog({super.key});

  @override
  State<ManageBlog> createState() => _ManageBlogState();
}

class _ManageBlogState extends State<ManageBlog> {
  final ManageBlogController controller = Get.put(ManageBlogController());

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void deletePost(int index) async {
    int blogId = controller.manageBlogList[index].articleId ?? 0;
    await controller.deleteBlog(blogId, index, context);
  }

  Future<void> _refreshData() async {
    await controller.fetchMyBlog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'Manage Blog',
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.primaryColor,
        color: AppColors.white,
        onRefresh: _refreshData,
        child: Container(
          color: AppColors.background,
          child: Obx(() {
            if (controller.isLoading.value &&
                controller.manageBlogList.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const CustomShimmerClassified(
                        width: 175, height: 240);
                  },
                ),
              );
            }

            if (controller.manageBlogList.isEmpty) {
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
              itemCount: controller.manageBlogList.length,
              itemBuilder: (context, index) {
                final post = controller.manageBlogList[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        Routes.myblogdetails,
                        arguments: controller.manageBlogList[index],
                      );
                    },
                    child: ManageBlogCard(
                      updatedateTime: post.datemodified ?? '',
                      onDelete: () => deletePost(index),
                      userImage: post.userData?.imagePath ?? '',
                      userName: post.userData?.name ?? '',
                      postTitle: post.title ?? '',
                      postCaption: post.description ?? '',
                      postImage: post.imagePath ?? '',
                      dateTime: post.createdDate ?? '',
                      viewcounts: post.pgcnt ?? 0,
                      controller: controller,
                      bookmarkCount: post.totalbookmark ?? 0,
                      likedCount: post.totallike ?? 0,
                      blogId: post.articleId ?? 0,
                      blogstatus: post.status ?? 0,
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
      ),
      floatingActionButton: Material(
        shape: const CircleBorder(),
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            var controller = CustomFloatingActionButtonController(context);
            String selectedType = 'blog';
            await controller.handleTap(selectedType);
          },
          customBorder: const CircleBorder(),
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
      ),
    );
  }
}
