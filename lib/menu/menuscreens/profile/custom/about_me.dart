import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';

class AboutMeSection extends StatelessWidget {
  final Size size;

  const AboutMeSection({required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Follow me on',
                        style:
                            textStyleW400(size.width * 0.035, AppColors.grey)),
                    15.sbh,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SvgPicture.asset(Assets.svgLogosFacebook),
                        12.sbw,
                        SvgPicture.asset(Assets.svgInstagram),
                        12.sbw,
                        SvgPicture.asset(Assets.svgLogosLinkedinIcon),
                        12.sbw,
                        SvgPicture.asset(Assets.svgYoutube),
                        12.sbw,
                        SvgPicture.asset(Assets.svgTwitter),
                        12.sbw,
                        SvgPicture.asset(Assets.svgTelegram),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          10.sbh,
          const Divider(color: Colors.grey),
          10.sbh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About me',
                    style: textStyleW400(size.width * 0.035, AppColors.grey)),
                Text(
                  'Since electricity prices in Europe have reached record highs and all we hear and read about are electricity shortages, everyone is talking about saving electricity. And this applies not only to us but also to manufacturers and users in the plastics processing industry.',
                  style: textStyleW500(size.width * 0.035, AppColors.blackText),
                ),
              ],
            ),
          ),
          10.sbh,
          const Divider(color: Colors.grey),
          10.sbh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About me',
                    style: textStyleW400(size.width * 0.035, AppColors.grey)),
                Text(
                  'Since electricity prices in Europe have reached record highs and all we hear and read about are electricity shortages, everyone is talking about saving electricity. And this applies not only to us but also to manufacturers and users in the plastics processing industry.',
                  style: textStyleW500(size.width * 0.035, AppColors.blackText),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.017),
        ],
      ),
    );
  }
}
