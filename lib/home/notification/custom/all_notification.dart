import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/notification/card/all_notification_card.dart';
import 'package:mlmdiary/home/notification/controller/notification_controller.dart';
import 'package:mlmdiary/home/notification/custom/notification_handle_inside_app.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class AllNotification extends StatefulWidget {
  const AllNotification({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AllNotificationState createState() => _AllNotificationState();
}

class _AllNotificationState extends State<AllNotification> {
  final ManageNewsController manageNewsController =
      Get.find<ManageNewsController>();
  final NotificationController controller = Get.put(NotificationController());
  final ClasifiedController clasifiedController =
      Get.put(ClasifiedController());
  final EditPostController editPostController = Get.put(EditPostController());
  final CompanyController companyController = Get.put(CompanyController());
  final ManageBlogController manageBlogController =
      Get.find<ManageBlogController>();
  final QuestionAnswerController questionAnswerController =
      Get.put(QuestionAnswerController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value &&
                    controller.notificationList.isEmpty) {
                  return Center(
                      child: CustomLottieAnimation(
                    child: Lottie.asset(
                      Assets.lottieLottie,
                    ),
                  ));
                }

                if (controller.notificationList.isEmpty) {
                  return const Center(
                    child: Text(
                      'Data not found',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  controller: controller.scrollController,
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.notificationList.length +
                      (controller.isLoading.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.notificationList.length) {
                      return Center(
                          child: CustomLottieAnimation(
                        child: Lottie.asset(
                          Assets.lottieLottie,
                        ),
                      ));
                    }

                    final post = controller.notificationList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          final handler = PostNavigationHandler(
                            post: post,
                            classifiedController: clasifiedController,
                            editPostController: editPostController,
                            manageNewsController: manageNewsController,
                            manageBlogController: manageBlogController,
                            questionAnswerController: questionAnswerController,
                            companyController: companyController,
                          );
                          if (kDebugMode) {
                            print('tap');
                          }
                          await handler.handleTap();
                        },
                        child: AllNotificationCard(
                          key: ValueKey(post.id),
                          image: post.userimage ?? '',
                          dateTime: post.creatdate ?? '',
                          classifiedId: post.id ?? 0,
                          userName: post.title ?? '',
                          controller: controller,
                          userNametype: post.message ?? '',
                          type: 'all',
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
