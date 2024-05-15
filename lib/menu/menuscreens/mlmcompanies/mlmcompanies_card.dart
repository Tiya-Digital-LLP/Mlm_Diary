import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';

class MlmCompaniesCard extends StatelessWidget {
  final String userImage;
  final String postTitle;
  final String postCaption;
  final String location;
  const MlmCompaniesCard({
    super.key,
    required this.userImage,
    required this.postTitle,
    required this.postCaption,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.035, vertical: size.height * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5,
                    color: AppColors.grey.withOpacity(0.5),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    userImage,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        postTitle,
                        style: textStyleW700(
                            size.width * 0.040, AppColors.blackText),
                      ),
                      const SizedBox(
                        width: 07,
                      ),
                    ],
                  ),
                  Text(
                    location,
                    style: textStyleW400(size.width * 0.032,
                        AppColors.blackText.withOpacity(0.5)),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            postCaption,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.blackText,
              fontSize: size.width * 0.032,
            ),
          ),
          SizedBox(
            height: size.height * 0.026,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: size.height * 0.028,
                    width: size.height * 0.028,
                    child: SvgPicture.asset(Assets.svgLike),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    "50k",
                    style: TextStyle(
                        fontFamily: "Metropolis",
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.043),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    height: size.height * 0.028,
                    width: size.height * 0.028,
                    child: SvgPicture.asset(Assets.svgComment),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    "24k",
                    style: TextStyle(
                        fontFamily: "Metropolis",
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.043),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    height: size.height * 0.028,
                    width: size.height * 0.028,
                    child: SvgPicture.asset(Assets.svgView),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    "286",
                    style: TextStyle(
                        fontFamily: "Metropolis",
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.043),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: size.height * 0.028,
                    width: size.height * 0.028,
                    child: SvgPicture.asset(Assets.svgSavePost),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: size.height * 0.028,
                    width: size.height * 0.028,
                    child: SvgPicture.asset(Assets.svgSend),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
