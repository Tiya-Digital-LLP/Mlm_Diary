import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';

class UserCard extends StatelessWidget {
  final String userImage;
  final String userName;
  final String location;
  final String designation;
  final String plan;

  const UserCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.location,
    required this.designation,
    required this.plan,
  });

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
              CircleAvatar(
                backgroundColor: const Color(0XFFCCC9C9),
                radius: size.width * 0.1,
                child: ClipOval(
                  child: Image.asset(
                    userImage,
                    height: size.width * 0.2,
                    width: size.width * 0.2,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.05),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: textStyleW700(
                          size.width * 0.043, AppColors.blackText),
                    ),
                    SizedBox(height: size.height * 0.005),
                    Text(
                      location,
                      style: textStyleW400(
                          size.width * 0.035, AppColors.blackText),
                    ),
                    Text(
                      designation,
                      style: textStyleW600(
                          size.width * 0.034, AppColors.blackText),
                    ),
                    Text(
                      plan,
                      style: textStyleW400(
                          size.width * 0.035, AppColors.blackText),
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
