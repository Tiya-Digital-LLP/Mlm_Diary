import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/get_mlm_database_entity.dart';
import 'package:mlmdiary/home/home/custom/sign_up_dialog.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCard extends StatefulWidget {
  final String userImage;
  final String userName;
  final String location;
  final String designation;
  final String plan;
  final GetMlmDatabaseData post;
  final int postid;
  final UserProfileController userprofilecontroller;

  const UserCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.location,
    required this.designation,
    required this.plan,
    required this.post,
    required this.postid,
    required this.userprofilecontroller,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.035,
      ),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border:
                        Border.all(color: AppColors.primaryColor, width: 1)),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: widget.userImage,
                    height: 60.0,
                    width: 60.0,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Image.asset(
                      Assets.imagesAdminlogo,
                      height: 60.0,
                      width: 60.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.05),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName,
                      style: textStyleW700(
                          size.width * 0.038, AppColors.blackText),
                    ),
                    SizedBox(height: size.height * 0.005),
                    Text(
                      widget.location,
                      style: textStyleW400(
                          size.width * 0.032, AppColors.blackText),
                    ),
                    Text(
                      widget.designation,
                      style: textStyleW600(
                          size.width * 0.032, AppColors.blackText),
                    ),
                    SizedBox(
                      width: size.width * 0.35,
                      child: Text(
                        widget.plan,
                        style: textStyleW400(
                            size.width * 0.032, AppColors.blackText),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.getString(Constants.accessToken);
                Get.toNamed(Routes.userprofilescreen, arguments: {
                  'user_id': widget.postid,
                });
                await widget.userprofilecontroller.fetchUserAllPost(
                  1,
                  widget.postid.toString(),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "View Profile",
                    style: textStyleW700(
                      size.width * 0.036,
                      AppColors.primaryColor,
                      isMetropolis: true,
                    ),
                  ),
                  3.sbw,
                  Icon(
                    Icons.arrow_forward,
                    size: 17,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showSignupDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const SignupDialog();
    },
  );
}
