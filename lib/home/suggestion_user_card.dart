import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';

class SuggetionUserCard extends StatefulWidget {
  final String userImage;
  final String name;
  final String mlm;

  final String post;
  final int postId;
  final EditPostController editpostcontroller;
  final bool isfollowing;
  const SuggetionUserCard(
      {super.key,
      required this.userImage,
      required this.name,
      required this.post,
      required this.postId,
      required this.editpostcontroller,
      required this.isfollowing,
      required this.mlm});

  @override
  State<SuggetionUserCard> createState() => _SuggetionUserCardState();
}

class _SuggetionUserCardState extends State<SuggetionUserCard> {
  RxBool isFollowing = false.obs;

  @override
  void initState() {
    super.initState();
    initializeBookmarks();
  }

  void initializeBookmarks() {
    isFollowing = RxBool(widget.isfollowing);
  }

  void _toggleFollow() async {
    bool newBookmarkedValue = !isFollowing.value;
    isFollowing.value = newBookmarkedValue;

    await widget.editpostcontroller.toggleProfileFollow(widget.postId, context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: 200,
      height: 265,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      // ignore: deprecated_member_use
                      color: AppColors.blackText.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: widget.userImage,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                      errorWidget: (context, url, error) => Image.asset(
                        Assets.imagesAdminlogo,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                10.sbh,
                Text(
                  widget.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyleW700(size.width * 0.038, AppColors.blackText),
                  textAlign: TextAlign.center,
                ),
                5.sbh,
                Text(
                  widget.mlm,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyleW400(size.width * 0.032, AppColors.blackText),
                  textAlign: TextAlign.center,
                ),
                Text(
                  widget.post,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyleW600(size.width * 0.032, AppColors.blackText),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Obx(
              () => GestureDetector(
                onTap: () {
                  _toggleFollow();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.006,
                    horizontal: size.width * 0.08,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isFollowing.value ? 'Unfollow' : 'Follow',
                    style: textStyleW700(
                      size.width * 0.035,
                      AppColors.white,
                      isMetropolis: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
