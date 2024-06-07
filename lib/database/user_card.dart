import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';

class UserCard extends StatefulWidget {
  final String userImage;
  final String userName;
  final String location;
  final String designation;
  final String plan;
  const UserCard(
      {super.key,
      required this.userImage,
      required this.userName,
      required this.location,
      required this.designation,
      required this.plan});

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
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Image.asset(
                      Assets.imagesIcon,
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
                          size.width * 0.043, AppColors.blackText),
                    ),
                    SizedBox(height: size.height * 0.005),
                    Text(
                      widget.location,
                      style: textStyleW400(
                          size.width * 0.035, AppColors.blackText),
                    ),
                    Text(
                      widget.designation,
                      style: textStyleW600(
                          size.width * 0.034, AppColors.blackText),
                    ),
                    Text(
                      widget.plan,
                      style: textStyleW400(
                          size.width * 0.035, AppColors.blackText),
                      maxLines: 1,
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
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "View Profile",
                    style: TextStyle(color: AppColors.primaryColor),
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
