import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/classified/custom/custom_commment.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/notification/card/user_notification_card.dart';
import 'package:mlmdiary/home/notification/controller/notification_controller.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/blog/custom_blog_comment.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/custom_company_comment.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/custom_news_comment.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/custom_post_comment.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class UserNotification extends StatefulWidget {
  const UserNotification({super.key});

  @override
  State<UserNotification> createState() => _AllNotificationState();
}

class _AllNotificationState extends State<UserNotification> {
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
                          horizontal: 12, vertical: 8),
                      child: GestureDetector(
                        onTap: () async {
                          switch (post.postType) {
                            // classified
                            case 'classified':
                              Get.toNamed(Routes.mlmclassifieddetailcopy,
                                  arguments: {
                                    'id': post.id,
                                  });
                              clasifiedController.fetchClassifiedDetail(
                                  post.postid ?? 0, context);
                              break;

                            // post
                            case 'user_post':
                              Get.toNamed(Routes.postdetailnotification,
                                  arguments: {
                                    'id': post.id,
                                  });
                              // await editPostController.fetchPost(1,
                              //     postId: post.postid);
                              break;

                            // news
                            case 'news':
                            case 'manage_news':
                              Get.toNamed(Routes.newsdetailsnotification,
                                  arguments: {
                                    'id': post.id,
                                  });
                              await manageNewsController.getNews(1,
                                  newsId: post.postid);
                              break;

                            // blog
                            case 'blog':
                            case 'manage_blog':
                              Get.toNamed(Routes.blogdetailsnotification,
                                  arguments: {
                                    'id': post.id ?? 0,
                                  });
                              await manageBlogController.getBlog(1,
                                  blogid: post.postid);
                              break;

                            // question
                            case 'question':
                              Get.toNamed(Routes.userquestioncopy, arguments: {
                                'post_id': post.postid ?? 0,
                              });
                              await questionAnswerController.getQuestion(1,
                                  questionid: post.postid);
                              break;

                            // User-Profile
                            case 'user_profile':
                            case 'follow_user':
                              if (kDebugMode) {
                                print(
                                    'Navigating to userprofilescreen with user_id: ${post.postid}}');
                              }
                              Get.toNamed(Routes.userprofilescreen, arguments: {
                                'user_id': post.postid,
                              });
                              await editPostController.fetchPost(1,
                                  postId: post.postid);
                              break;

                            // Company
                            case 'company':
                              if (kDebugMode) {
                                print(
                                    'Navigating to Company with post_id: ${post.postid}');
                              }

                              Get.toNamed(
                                  Routes.mlmcompaniesnotificationdetails,
                                  arguments: {
                                    'id': post.postid,
                                  });
                              await companyController.getAdminCompany(1,
                                  companyId: post.postid);
                              break;

                            // Comment
                            case 'classified_comment':
                              final context = Get.context;
                              if (context != null) {
                                showFullScreenDialog(context, post.postid ?? 0);
                              } else {
                                if (kDebugMode) {
                                  print('Error: Context is null');
                                }
                              }
                              break;

                            case 'user_post_comment':
                              final context = Get.context;
                              if (context != null) {
                                showFullScreenDialogPost(
                                    context, post.postid ?? 0);
                              } else {
                                if (kDebugMode) {
                                  print('Error: Context is null');
                                }
                              }
                              break;

                            case 'news_comment':
                              final context = Get.context;
                              if (context != null) {
                                showFullScreenDialogNews(
                                    context, post.postid ?? 0);
                              } else {
                                if (kDebugMode) {
                                  print('Error: Context is null');
                                }
                              }
                              break;

                            case 'blog_comment':
                              final context = Get.context;
                              if (context != null) {
                                showFullScreenDialogBlog(
                                    context, post.postid ?? 0);
                              } else {
                                if (kDebugMode) {
                                  print('Error: Context is null');
                                }
                              }
                              break;

                            case 'company_comment':
                              final context = Get.context;
                              if (context != null) {
                                showFullScreenDialogCompany(
                                    context, post.postid ?? 0);
                              } else {
                                if (kDebugMode) {
                                  print('Error: Context is null');
                                }
                              }
                              break;

                            default:
                              if (kDebugMode) {
                                print('No more redirection screens');
                              }
                              break;
                          }
                        },
                        child: UserNotificationCard(
                          key: ValueKey(post.id),
                          image: post.userimage ?? '',
                          dateTime: post.creatdate ?? '',
                          classifiedId: post.id ?? 0,
                          userName: post.title ?? '',
                          controller: controller,
                          userNametype: post.message ?? '',
                          type: 'user',
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
