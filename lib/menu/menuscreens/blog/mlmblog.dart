import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/blog/manage_blog_card.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/lists.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';

class MlmBlog extends StatefulWidget {
  const MlmBlog({super.key});

  @override
  State<MlmBlog> createState() => _MlmBlogState();
}

class _MlmBlogState extends State<MlmBlog> {
  void deletePost(int index) {
    setState(() {
      newsList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'Manage Blog',
      ),
      body: Container(
        color: AppColors.background,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            final post = newsList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.mlmblogdetails, arguments: post);
                },
                child: ManageBlogCard(
                  onDelete: () => deletePost(index),
                  userImage: post.userImage,
                  userName: post.userName,
                  postTitle: post.postTitle,
                  postCaption: post.postCaption,
                  postImage: post.postImage,
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Get.toNamed(Routes.addblog);
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
