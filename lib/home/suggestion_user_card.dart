import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';

class SuggetionUserCard extends StatefulWidget {
  final String userImage;
  final String name;
  final String post;
  final int postId;
  final EditPostController editpostcontroller;
  const SuggetionUserCard(
      {super.key,
      required this.userImage,
      required this.name,
      required this.post,
      required this.postId,
      required this.editpostcontroller});

  @override
  State<SuggetionUserCard> createState() => _SuggetionUserCardState();
}

class _SuggetionUserCardState extends State<SuggetionUserCard> {
  RxBool isFollowing = false.obs;
  void _toggleFollow() async {
    final userId = widget.postId;

    try {
      // Fetch current follow status
      bool followStatus = await _fetchFollowStatus(userId);

      // Defer the state update
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isFollowing.value = !followStatus;
      });

      // Call the API to toggle the follow status
      // ignore: use_build_context_synchronously
      await widget.editpostcontroller.toggleProfileFollow(userId, context);
    } catch (e) {
      // Handle API errors
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Future<bool> _fetchFollowStatus(int userId) async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: 220,
      height: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.blackText.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: widget.userImage.isNotEmpty &&
                            Uri.tryParse(widget.userImage)?.hasAbsolutePath ==
                                true
                        ? NetworkImage(widget.userImage)
                        : null,
                    child: widget.userImage.isEmpty
                        ? const Icon(Icons.person)
                        : null,
                  ),
                ),
                10.sbh,
                Text(
                  widget.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textStyleW700(size.width * 0.043, AppColors.blackText),
                  textAlign: TextAlign.center,
                ),
                15.sbh,
                Text(
                  widget.post,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textStyleW400(size.width * 0.037, AppColors.blackText),
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
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    isFollowing.value ? 'Unfollow' : 'Follow',
                    style: textStyleW700(size.width * 0.035, AppColors.white),
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
