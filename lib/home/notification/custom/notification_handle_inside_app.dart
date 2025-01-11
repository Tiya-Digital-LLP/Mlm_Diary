import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/classified/custom/custom_commment.dart';
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

class PostNavigationHandler {
  final dynamic post;
  final ClasifiedController classifiedController;
  final EditPostController editPostController;
  final ManageNewsController manageNewsController;
  final ManageBlogController manageBlogController;
  final QuestionAnswerController questionAnswerController;
  final CompanyController companyController;

  PostNavigationHandler({
    required this.post,
    required this.classifiedController,
    required this.editPostController,
    required this.manageNewsController,
    required this.manageBlogController,
    required this.questionAnswerController,
    required this.companyController,
  });

  Future<void> handleTap() async {
    switch (post.postType) {
      case 'classified':
        Get.toNamed(
          Routes.mlmclassifieddetailtest,
          arguments: post.postid,
        );
        classifiedController.fetchClassifiedDetail(
          post.postid ?? 0,
          Get.context,
        );
        break;

      case 'user_post':
        Get.toNamed(Routes.postdetailnotification, arguments: {'id': post.id});
        break;

      case 'news':
      case 'manage_news':
        Get.toNamed(Routes.newsdetailsnotification, arguments: {'id': post.id});
        await manageNewsController.getNews(1);
        break;

      case 'blog':
      case 'manage_blog':
        Get.toNamed(Routes.blogdetailsnotification,
            arguments: {'id': post.id ?? 0});
        await manageBlogController.getBlog(1, blogid: post.postid);
        break;

      case 'question':
        Get.toNamed(Routes.userquestioncopy,
            arguments: {'post_id': post.postid ?? 0});
        await questionAnswerController.getQuestion(1, questionid: post.postid);
        break;

      case 'user_profile':
      case 'follow_user':
        Get.toNamed(Routes.userprofilescreen,
            arguments: {'user_id': post.postid});
        await editPostController.fetchPost(1, postId: post.postid);
        break;

      case 'company':
        Get.toNamed(Routes.mlmcompaniesnotificationdetails,
            arguments: {'id': post.postid});
        await companyController.getAdminCompany(1, companyId: post.postid);
        break;

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
          showFullScreenDialogPost(context, post.postid ?? 0);
        } else {
          if (kDebugMode) {
            print('Error: Context is null');
          }
        }
        break;

      case 'news_comment':
        final context = Get.context;
        if (context != null) {
          showFullScreenDialogNews(context, post.postid ?? 0);
        } else {
          if (kDebugMode) {
            print('Error: Context is null');
          }
        }
        break;

      case 'blog_comment':
        final context = Get.context;
        if (context != null) {
          showFullScreenDialogBlog(context, post.postid ?? 0);
        } else {
          if (kDebugMode) {
            print('Error: Context is null');
          }
        }
        break;

      case 'company_comment':
        final context = Get.context;
        if (context != null) {
          showFullScreenDialogCompany(context, post.postid ?? 0);
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
  }
}
