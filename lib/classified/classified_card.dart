import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';

// ignore: must_be_immutable
class ClassifiedCard extends StatelessWidget {
  final String userImage;
  final String userName;
  final String postTitle;

  ClassifiedCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.postTitle,
  });
  final ClasifiedController controller = Get.put(ClasifiedController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String decodedPostTitle = HtmlUnescape().convert(postTitle);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.035, vertical: size.height * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: Obx(
        () => Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0XFFCCC9C9),
                  radius: size.width * 0.07,
                  child: ClipOval(
                    child: Image.asset(
                      Assets.imagesIcon,
                      height: 100,
                      width: 100,
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
                          'Aman Talaviya',
                          style: textStyleW700(
                              size.width * 0.043, AppColors.blackText),
                        ),
                        const SizedBox(
                          width: 07,
                        ),
                      ],
                    ),
                    Text(
                      "2 Min Ago",
                      style: textStyleW400(size.width * 0.035,
                          AppColors.blackText.withOpacity(0.5)),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                userName,
                style: textStyleW700(size.width * 0.040, AppColors.blackText),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Html(
                data: decodedPostTitle,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                postTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackText,
                  fontSize: size.width * 0.035,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.012,
            ),
            Container(
              height: size.height * 0.28,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: CachedNetworkImage(
                imageUrl: userImage,
                height: 97,
                width: 105,
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            SizedBox(
              height: size.height * 0.017,
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
                      child: GestureDetector(
                        onTap: () => controller.toggleBookMark(),
                        child: Icon(
                          controller.isBookMarked.value
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          size: size.height * 0.032,
                        ),
                      ),
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
      ),
    );
  }
}
