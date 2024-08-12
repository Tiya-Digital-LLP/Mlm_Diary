// notification_handler.dart

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/custom/custom_commment.dart';
import 'package:mlmdiary/home/message/controller/message_controller.dart';
import 'package:mlmdiary/menu/menuscreens/blog/custom_blog_comment.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/custom_company_comment.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/custom_news_comment.dart';
import 'package:mlmdiary/menu/menuscreens/profile/custom/custom_post_comment.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';

class NotificationHandler {
  final ManageNewsController manageNewsController =
      Get.find<ManageNewsController>();
  final ManageBlogController manageBlogController =
      Get.find<ManageBlogController>();
  final EditPostController editPostController = Get.find<EditPostController>();
  final MessageController messageController = Get.put(MessageController());
  final QuestionAnswerController questionAnswerController =
      Get.put(QuestionAnswerController());
  final CompanyController companyController = Get.put(CompanyController());

  void handleNotificationClick(String? payload) {
    if (kDebugMode) {
      print('Handling notification click with payload: $payload');
    }

    final data =
        payload != null ? jsonDecode(payload) as Map<String, dynamic>? : null;

    if (data == null) {
      if (kDebugMode) {
        print('Notification data is null');
      }
      return;
    }

    if (kDebugMode) {
      print('Notification data: $data');
    }

    // Ensure proper conversion and structure
    final int postId = int.tryParse(data['post_id'].toString()) ?? 0;
    final int userId = int.tryParse(data['user_id'].toString()) ?? 0;
    final String imageUrl = data['image']?.toString() ?? '';
    final String title = data['title']?.toString() ?? '';
    final String type = data['type']?.toString() ?? '';
    final String chatId = data['chat_id']?.toString() ?? '';

    if (kDebugMode) {
      print('Notification type: ${data['type']}');
      print('Post ID: $postId');
      print('User ID: $userId');
    }

    Timer(const Duration(milliseconds: 200), () async {
      try {
        String key = '${data['type']}';

        switch (key) {
          // Classified

          case 'classified':
            if (kDebugMode) {
              print('Navigating to classified with post_id: $postId');
            }
            Get.toNamed(Routes.mlmclassifieddetailcopy, arguments: {
              'id': postId,
            });
            break;

          // News
          case 'news':
          case 'manage_news':
            if (kDebugMode) {
              print('Navigating to news with post_id: $postId');
            }

            Get.toNamed(Routes.newsdetailsnotification, arguments: {
              'id': postId,
            });
            await manageNewsController.getNews(1, newsId: postId);

            break;

          // Blog
          case 'blog':
            if (kDebugMode) {
              print('Navigating to blog with post_id: $postId');
            }
            Get.toNamed(Routes.blogdetailsnotification, arguments: {
              'id': postId,
            });
            await manageBlogController.getBlog(1, blogid: postId);

            break;

          // question
          case 'question':
            if (kDebugMode) {
              print('Navigating to userquestion with post_id: $postId');
            }
            await questionAnswerController.getQuestion(1, questionid: postId);

            Get.toNamed(Routes.userquestioncopy, arguments: {
              'post_id': postId,
            });
            break;

          // post
          case 'user_post':
            if (kDebugMode) {
              print('Navigating to post with post_id: $postId');
            }

            Get.toNamed(Routes.postdetailnotification, arguments: {
              'id': postId,
            });
            break;

          // Chat
          case 'chat':
            Get.toNamed(Routes.usermessagedetailscreen, arguments: {
              "chatId": chatId,
              "username": title,
              "imageUrl": imageUrl,
            });
            break;

          // User-Profile
          case 'user_profile':
            if (kDebugMode) {
              print('Navigating to userprofilescreen with user_id: $postId');
            }
            Get.toNamed(Routes.userprofilescreen, arguments: {
              'user_id': postId,
            });
            await editPostController.fetchPost(1, postId: postId);

            break;

          // Company

          case 'company':
            if (kDebugMode) {
              print('Navigating to Company with post_id: $postId');
            }
            Get.toNamed(Routes.mlmcompaniesnotificationdetails, arguments: {
              'id': postId,
            });
            await companyController.getAdminCompany(1, companyId: postId);

            break;

          // video

          case 'video':
            if (kDebugMode) {
              print('Navigating to video with post_id: $postId');
            }
            Get.toNamed(Routes.video, arguments: {type});

            break;

          // home banner

          case 'home':
            if (kDebugMode) {
              print('Navigating to home with post_id: $postId');
            }
            Get.toNamed(Routes.mainscreen, arguments: {type});
            break;

          // Comment
          case 'classified_comment':
            final context = Get.context;
            if (context != null) {
              showFullScreenDialog(context, postId);
            } else {
              if (kDebugMode) {
                print('Error: Context is null');
              }
            }
            break;
          case 'news_comment':
            final context = Get.context;
            if (context != null) {
              showFullScreenDialogNews(context, postId);
            } else {
              if (kDebugMode) {
                print('Error: Context is null');
              }
            }
            break;
          case 'blog_comment':
            final context = Get.context;
            if (context != null) {
              showFullScreenDialogBlog(context, postId);
            } else {
              if (kDebugMode) {
                print('Error: Context is null');
              }
            }
            break;
          case 'user_post_comment':
            final context = Get.context;
            if (context != null) {
              showFullScreenDialogPost(context, postId);
            } else {
              if (kDebugMode) {
                print('Error: Context is null');
              }
            }
            break;
          case 'company_comment':
            final context = Get.context;
            if (context != null) {
              showFullScreenDialogCompany(context, postId);
            } else {
              if (kDebugMode) {
                print('Error: Context is null');
              }
            }
            break;

          default:
            if (kDebugMode) {
              print('Navigated to default screen with data: $data');
            }
        }
      } catch (e, stackTrace) {
        if (kDebugMode) {
          print('Error during navigation: $e');
          print('Stack trace: $stackTrace');
        }
      }
    });
  }
}
