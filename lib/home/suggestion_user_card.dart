import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';

class SuggestionUserCard extends StatelessWidget {
  final String userImage;
  final String name;
  final String post;

  const SuggestionUserCard({
    super.key,
    required this.userImage,
    required this.name,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.060, vertical: size.height * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0XFFCCC9C9),
            radius: size.width * 0.140,
            child: ClipOval(
              child: Image.asset(
                userImage,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            name,
            style: textStyleW700(size.width * 0.043, AppColors.blackText),
          ),
          Text(
            post,
            style: textStyleW400(size.width * 0.037, AppColors.blackText),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.006, horizontal: size.width * 0.08),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                "Follow",
                style: textStyleW700(size.width * 0.035, AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
