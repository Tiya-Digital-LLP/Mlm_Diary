import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/all_bookmark_entity.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteController extends GetxController {
  var isLoading = false.obs;
  RxList<AllBookmarkData> favouriteList = RxList<AllBookmarkData>();
  final ScrollController scrollController = ScrollController();
  var isEndOfData = false.obs;
  final type = TextEditingController();
  var selectedType = 'All'.obs;
  final List<String> types = [
    'All',
    'blog',
    'database',
    'post',
    'news',
    'classified',
    'company',
    'question',
    'video'
  ];

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isEndOfData.value &&
          !isLoading.value) {
        int nextPage = (favouriteList.length ~/ 10) + 1;
        fetchBookmark(nextPage);
      }
    });
  }

  bool isItemLiked(
    String type,
    int bookmarkId,
    ManageBlogController manageBlogController,
    ManageNewsController manageNewsController,
    ClasifiedController classifiedController,
    CompanyController companyController,
    QuestionAnswerController questionAnswerController,
    EditPostController editpostController,
  ) {
    if (type == 'blog') {
      return manageBlogController.likedStatusMap[bookmarkId] ?? false;
    } else if (type == 'news') {
      return manageNewsController.likedStatusMap[bookmarkId] ?? false;
    } else if (type == 'classified') {
      return classifiedController.likedStatusMap[bookmarkId] ?? false;
    } else if (type == 'company') {
      return companyController.likedStatusMap[bookmarkId] ?? false;
    } else if (type == 'question') {
      return questionAnswerController.likedStatusMap[bookmarkId] ?? false;
    } else if (type == 'post') {
      return editpostController.likedStatusMap[bookmarkId] ?? false;
    }
    return false;
  }

  int getItemLikes(
    String type,
    int bookmarkId,
    ManageBlogController manageBlogController,
    ManageNewsController manageNewsController,
    ClasifiedController classifiedController,
    CompanyController companyController,
    QuestionAnswerController questionAnswerController,
    EditPostController editpostController,
  ) {
    if (type == 'blog') {
      return manageBlogController.likeCountMap[bookmarkId] ?? 0;
    } else if (type == 'news') {
      return manageNewsController.likeCountMap[bookmarkId] ?? 0;
    } else if (type == 'classified') {
      return classifiedController.likeCountMap[bookmarkId] ?? 0;
    } else if (type == 'company') {
      return companyController.likeCountMap[bookmarkId] ?? 0;
    } else if (type == 'question') {
      return questionAnswerController.likeCountMap[bookmarkId] ?? 0;
    } else if (type == 'post') {
      return editpostController.likeCountMap[bookmarkId] ?? 0;
    }
    return 0;
  }

  void toggleLike(
    String type,
    int bookmarkId,
    context,
    ManageBlogController manageBlogController,
    ManageNewsController manageNewsController,
    ClasifiedController classifiedController,
    CompanyController companyController,
    QuestionAnswerController questionAnswerController,
    EditPostController editpostController,
  ) {
    if (type == 'blog') {
      manageBlogController.toggleLike(bookmarkId, context);
    } else if (type == 'news') {
      manageNewsController.toggleLike(bookmarkId, context);
    } else if (type == 'classified') {
      classifiedController.toggleLike(bookmarkId, context);
    } else if (type == 'company') {
      companyController.toggleLike(bookmarkId, context);
    } else if (type == 'question') {
      questionAnswerController.toggleLike(bookmarkId, context);
    } else if (type == 'post') {
      editpostController.toggleLike(bookmarkId, context);
    }
  }

  // BookMark

  bool isItemBookmark(
    String type,
    int bookmarkId,
    ManageBlogController manageBlogController,
    ManageNewsController manageNewsController,
    ClasifiedController classifiedController,
    CompanyController companyController,
    EditPostController editPostController,
    QuestionAnswerController questionAnswerController,
    EditPostController editpostController,
  ) {
    if (type == 'blog') {
      return manageBlogController.bookmarkStatusMap[bookmarkId] ?? false;
    } else if (type == 'news') {
      return manageNewsController.bookmarkStatusMap[bookmarkId] ?? false;
    } else if (type == 'classified') {
      return classifiedController.bookmarkStatusMap[bookmarkId] ?? false;
    } else if (type == 'company') {
      return companyController.bookmarkStatusMap[bookmarkId] ?? false;
    } else if (type == 'database') {
      return editPostController.bookmarkProfileStatusMap[bookmarkId] ?? false;
    } else if (type == 'question') {
      return questionAnswerController.bookmarkStatusMap[bookmarkId] ?? false;
    } else if (type == 'post') {
      return editPostController.bookmarkStatusMap[bookmarkId] ?? false;
    }
    return false;
  }

  int getItemBookmark(
    String type,
    int bookmarkId,
    ManageBlogController manageBlogController,
    ManageNewsController manageNewsController,
    ClasifiedController classifiedController,
    CompanyController companyController,
    EditPostController editPostController,
    QuestionAnswerController questionAnswerController,
    EditPostController editpostController,
  ) {
    if (type == 'blog') {
      return manageBlogController.bookmarkCountMap[bookmarkId] ?? 0;
    } else if (type == 'news') {
      return manageNewsController.bookmarkCountMap[bookmarkId] ?? 0;
    } else if (type == 'classified') {
      return classifiedController.bookmarkCountMap[bookmarkId] ?? 0;
    } else if (type == 'company') {
      return companyController.bookmarkCountMap[bookmarkId] ?? 0;
    } else if (type == 'database') {
      return editPostController.bookmarkProfileCountMap[bookmarkId] ?? 0;
    } else if (type == 'question') {
      return questionAnswerController.bookmarkCountMap[bookmarkId] ?? 0;
    } else if (type == 'post') {
      return editPostController.bookmarkCountMap[bookmarkId] ?? 0;
    }
    return 0;
  }

  void toggleBookmark(
    String type,
    int bookmarkId,
    context,
    ManageBlogController manageBlogController,
    ManageNewsController manageNewsController,
    ClasifiedController classifiedController,
    CompanyController companyController,
    EditPostController editPostController,
    QuestionAnswerController questionAnswerController,
    EditPostController editpostController,
  ) {
    if (type == 'blog') {
      manageBlogController.toggleBookMark(bookmarkId, context);
    } else if (type == 'news') {
      manageNewsController.toggleBookMark(bookmarkId, context);
    } else if (type == 'classified') {
      classifiedController.toggleBookMark(bookmarkId, context);
    } else if (type == 'company') {
      companyController.toggleBookMark(bookmarkId, context);
    } else if (type == 'database') {
      editPostController.toggleProfileBookMark(bookmarkId, context);
    } else if (type == 'question') {
      questionAnswerController.toggleBookMark(bookmarkId, context);
    } else if (type == 'post') {
      editpostController.toggleBookMark(bookmarkId, context);
    }
  }

  Future<void> fetchBookmark(int page) async {
    isLoading.value = true;
    String device = Platform.isAndroid
        ? 'android'
        : Platform.isIOS
            ? 'ios'
            : '';

    SharedPreferences? prefs;
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (error) {
      isLoading.value = false;
      return;
    }

    String? apiToken = prefs.getString(Constants.accessToken);
    if (apiToken == null) {
      isLoading.value = false;
      return;
    }

    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        isLoading.value = false;
        return;
      }

      Map<String, String> queryParams = {
        'api_token': apiToken,
        'device': device,
        'page': page.toString(),
        'type': selectedType.value == 'All' ? '' : selectedType.value,
      };

      Uri uri = Uri.parse(Constants.baseUrl + Constants.allbookmark)
          .replace(queryParameters: queryParams);
      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final AllBookmarkEntity allBookmarkEntity =
            AllBookmarkEntity.fromJson(responseData);

        final List<AllBookmarkData> myBlogData = allBookmarkEntity.data ?? [];
        if (myBlogData.isNotEmpty) {
          if (page == 1) {
            favouriteList.assignAll(allBookmarkEntity.data ?? []);
          } else {
            favouriteList.addAll(allBookmarkEntity.data ?? []);
          }

          if (myBlogData.length < 10) {
            isEndOfData.value = true;
          }
        } else {
          isEndOfData.value = true;
        }
      }
    } catch (error) {
      // Handle general error case
    } finally {
      isLoading.value = false;
    }
  }
}
