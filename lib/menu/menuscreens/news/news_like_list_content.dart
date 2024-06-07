import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';

class NewsLikeListContent extends StatefulWidget {
  const NewsLikeListContent({super.key});

  @override
  State<NewsLikeListContent> createState() =>
      _ClassifiedLikedListContentState();
}

class _ClassifiedLikedListContentState extends State<NewsLikeListContent> {
  final ManageNewsController controller = Get.put(ManageNewsController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Obx(
      () => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 80,
                        height: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Like Views',
                        style: textStyleW700(
                            size.width * 0.043, AppColors.blackText),
                      ),
                    ),
                    10.sbh,
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.newsLikeList.length,
                        itemBuilder: (context, index) {
                          var item = controller.newsLikeList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      item.userData?.imagePath ?? ''),
                                ),
                                8.sbw,
                                Expanded(
                                  child: Text(
                                    item.userData?.name ?? 'Unknown',
                                    style: textStyleW500(size.width * 0.032,
                                        AppColors.blackText),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  side: BorderSide(color: AppColors.redText),
                                ),
                                child: Text(
                                  'Cancel',
                                  style: textStyleW700(
                                      size.width * 0.04, AppColors.redText),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
