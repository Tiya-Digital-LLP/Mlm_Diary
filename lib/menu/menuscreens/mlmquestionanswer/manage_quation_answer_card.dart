import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';

class ManageQuationCard extends StatelessWidget {
  final String userImage;
  final String userName;
  final String postCaption;
  const ManageQuationCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.postCaption,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  width: 41,
                  height: 41,
                  userImage,
                  fit: BoxFit.fill,
                ),
                10.sbw,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            userName,
                            style: textStyleW700(
                                size.width * 0.038, AppColors.blackText),
                          ),
                          8.sbw,
                          Text(
                            'asked a question',
                            style: textStyleW400(size.width * 0.032,
                                AppColors.blackText.withOpacity(0.8)),
                          )
                        ],
                      ),
                      Text(
                        '2 minutes',
                        style: textStyleW400(size.width * 0.028,
                            AppColors.blackText.withOpacity(0.8)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text(
                  postCaption,
                  style: textStyleW400(
                      size.width * 0.035, AppColors.blackText.withOpacity(0.8)),
                )
              ],
            ),
          ),
          20.sbh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
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
                          fontSize: size.width * 0.045),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      height: size.height * 0.028,
                      width: size.height * 0.028,
                      child: SvgPicture.asset(Assets.svgReply),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      "12",
                      style: TextStyle(
                          fontFamily: "Metropolis",
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.045),
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
                          fontSize: size.width * 0.045),
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
            ),
          ),
          20.sbh,
        ],
      ),
    );
  }
}
