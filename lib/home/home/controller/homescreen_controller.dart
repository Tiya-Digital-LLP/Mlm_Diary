import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/classified.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/get_banner_entity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mlmdiary/generated/get_home_entity.dart';
import 'package:mlmdiary/generated/get_pop_up_banner_entity.dart';
import 'package:mlmdiary/generated/mutual_friends_entity.dart';
import 'package:mlmdiary/generated/notification_count_entity.dart';
import 'package:mlmdiary/menu/menuscreens/blog/controller/manage_blog_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmquestionanswer/controller/question_answer_controller.dart';
import 'package:mlmdiary/menu/menuscreens/news/controller/manage_news_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/controller/edit_post_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeController extends GetxController {
  RxBool isSearchBarVisible = false.obs;
  RxList<GetBannerData> banners = RxList<GetBannerData>();
  RxList<GetPopUpBannerData> popupbanners = RxList<GetPopUpBannerData>();

  RxList<GetHomeData> homeList = RxList<GetHomeData>();
  RxList<MutualFriendsData> mutualFriendList = RxList<MutualFriendsData>();

  final ScrollController scrollController = ScrollController();
  final search = TextEditingController();
  var selectedType = 'All'.obs;
  final List<String> types = [
    'All',
    'Blog',
    'Database',
    'News',
    'Classified',
    'Post',
    'Company',
    'Question',
    'Video',
  ];

  void setSelectedType(String type) {
    selectedType.value = type;
  }

  late WebViewController webController;
  RxBool isload = true.obs;
  var isEndOfData = false.obs;
  var isLoading = false.obs;
  String type = '';
  RxInt notificationCount = RxInt(0);

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, () async {
      final popupbanners = await fetchPopUpBanners();
      if (popupbanners.isNotEmpty) {
        _showCustomDialog(popupbanners, Get.context);
      }
    });

    mutualFriend(1);
    fetchNotificationCount(1, 'all');
    ever(isload, (_) {
      if (isload.value) {
        fetchBanners();
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isEndOfData.value &&
          !isLoading.value) {
        int nextPage = (homeList.length ~/ 10) + 1;
        getHome(nextPage);
      }
    });
  }

  void _showCustomDialog(List<GetPopUpBannerData> popupbanners, context) {
    PageController pageController = PageController(
      initialPage: 0,
      viewportFraction: 1,
    );

    // ValueNotifier to keep track of the current page
    ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(0);

    // Timer to auto-slide every 3 seconds
    Timer.periodic(const Duration(seconds: 6), (Timer timer) {
      int currentPage = currentPageNotifier.value;
      if (currentPage < banners.length - 1) {
        currentPageNotifier.value = currentPage + 1;
      } else {
        currentPageNotifier.value = 0;
      }

      // Animate to the next page
      pageController.animateToPage(
        currentPageNotifier.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });

    Get.dialog(
      Center(
        child: Container(
          width: Get.width * 0.8,
          height: Get.height * 0.5,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Stack(
            children: [
              PageView.builder(
                controller: pageController,
                itemCount: popupbanners.length,
                itemBuilder: (context, index) {
                  final banner = popupbanners[index];
                  return GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? apiToken = prefs.getString(Constants.accessToken);

                      if (apiToken == null) {
                        // ignore: use_build_context_synchronously
                        showSignupDialog(context);
                        return;
                      }
                      if (banner.weblink == null || banner.weblink!.isEmpty) {
                        // ignore: use_build_context_synchronously
                        showToasterrorborder('No Any Url Found', context);
                      } else {
                        launchUrl(
                          Uri.parse(banner.weblink.toString()),
                          mode: LaunchMode.externalApplication,
                        );
                        // ignore: use_build_context_synchronously
                        bannerClick(banner.id ?? 0, context);
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: banner.weblink == null || banner.weblink!.isEmpty
                          ? Center(
                              child: Text(
                                'Banner not available',
                                style: textStyleW700(
                                  MediaQuery.of(context).size.width * 0.048,
                                  AppColors.blackText,
                                ).copyWith(
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )
                          : Image.network(
                              banner.image ?? '',
                              fit: BoxFit.fill,
                            ),
                    ),
                  );
                },
                onPageChanged: (index) {
                  currentPageNotifier.value = index;
                },
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              if (popupbanners.length > 1)
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: ValueListenableBuilder<int>(
                    valueListenable: currentPageNotifier,
                    builder: (context, currentPage, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(banners.length, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            width: 8.0,
                            height: 8.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPage == index
                                  ? AppColors.primaryColor
                                  : Colors.white.withOpacity(0.5),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void toggleSearchBarVisibility() {
    isSearchBarVisible.value = !isSearchBarVisible.value;
  }

  Future<void> fetchBanners() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        return;
      }

      SharedPreferences? prefs;
      try {
        prefs = await SharedPreferences.getInstance();
      } catch (error) {
        if (kDebugMode) {
          print('Error obtaining SharedPreferences: $error');
        }
        isLoading.value = false;
        return;
      }

      // Get the api_token, which might be null
      String? apiToken = prefs.getString(Constants.accessToken);

      // Build the URI with or without the api_token based on its value
      final Uri uri = Uri.parse('${Constants.baseUrl}${Constants.getbanner}')
          .replace(
              queryParameters: apiToken != null ? {'api_token': apiToken} : {});

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody =
            jsonDecode(response.body) as Map<String, dynamic>;

        if (responseBody['status'] == '1') {
          final List<dynamic> jsonData = responseBody['data'];
          final List<GetBannerData> bannerDataList = jsonData.map((data) {
            return GetBannerData.fromJson(data as Map<String, dynamic>);
          }).toList();

          banners.assignAll(bannerDataList);

          for (var banner in banners) {
            if (kDebugMode) {
              print('Banner ID: ${banner.id}');
              print('Title: ${banner.title}');
              print('Web Link: ${banner.weblink}');
            }
          }

          // Initialize webController here
          webController = WebViewController();
        } else {
          if (kDebugMode) {
            print('Failed to load banners: ${response.statusCode}');
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to load banners: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading banners: $e');
      }
    }
  }

  Future<void> bannerClick(int bannerId, context) async {
    isLoading.value = true;
    String device =
        Platform.isAndroid ? 'android' : (Platform.isIOS ? 'ios' : '');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        showToasterrorborder("No internet connection", context);
        isLoading.value = false;
        return;
      }

      Map<String, String> queryParams = {
        'api_token': apiToken ?? '',
        'device': device,
        'banner_id': bannerId.toString(),
      };

      if (kDebugMode) {
        print('api_token: $apiToken');
        print('device: $device');
        print('bannerid: $bannerId');
      }

      Uri uri = Uri.parse(Constants.baseUrl + Constants.bannerclick)
          .replace(queryParameters: queryParams);

      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(json.encode(responseData));
        }
      } else {
        if (kDebugMode) {
          print("Error: ${response.body}");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error: $error");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<GetPopUpBannerData>> fetchPopUpBanners() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        return [];
      }

      final response = await http.get(
        Uri.parse('${Constants.baseUrl}${Constants.popupbanner}'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody =
            jsonDecode(response.body) as Map<String, dynamic>;

        if (responseBody['status'] == '1') {
          final List<dynamic> jsonData = responseBody['data'];
          final List<GetPopUpBannerData> popUpBannerDataList =
              jsonData.map((data) {
            return GetPopUpBannerData.fromJson(data as Map<String, dynamic>);
          }).toList();

          popupbanners.assignAll(popUpBannerDataList);

          for (var banner in banners) {
            if (kDebugMode) {
              print('Pop Up Banner ID: ${banner.id}');
              print('Title: ${banner.title}');
              print('Web Link: ${banner.weblink}');
            }
          }

          webController = WebViewController();
          return popUpBannerDataList;
        } else {
          if (kDebugMode) {
            print('Failed to load banners: ${response.statusCode}');
          }
          return [];
        }
      } else {
        if (kDebugMode) {
          print('Failed to load banners: ${response.statusCode}');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading banners: $e');
      }
      return [];
    }
  }

  Future<void> fetchNotificationCount(int page, String? type) async {
    if (kDebugMode) {
      print('fetchNotificationCount called with page: $page, type: $type');
    }
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
      if (kDebugMode) {
        print('Error obtaining SharedPreferences: $error');
      }
      isLoading.value = false;
      return;
    }

    String? apiToken = prefs.getString(Constants.accessToken);
    if (apiToken == null) {
      if (kDebugMode) {
        print('API token is null');
      }
      isLoading.value = false;
      return;
    }

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        isLoading.value = false;
        return;
      }

      Map<String, String> queryParams = {
        'api_token': apiToken,
        'device': device,
        'page': page.toString(),
        'notification_type': type ?? '',
      };

      Uri uri = Uri.parse(Constants.baseUrl + Constants.notificationcount)
          .replace(queryParameters: queryParams);

      final response = await http.post(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print('Response data: $responseData');
        }

        // Parse JSON response into NotificationCountEntity
        NotificationCountEntity notificationCountEntity =
            NotificationCountEntity.fromJson(responseData);

        // Update notification count
        notificationCount.value =
            notificationCountEntity.notificationCount ?? 0;
        update(); // Notify GetX that a change occurred
        if (kDebugMode) {
          print(
              'Notification Count: ${notificationCountEntity.notificationCount}');
        }
      } else {
        if (kDebugMode) {
          print(
              'Failed to fetch notifications, status code: ${response.statusCode}');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching notifications: $error');
      }
    } finally {
      isLoading.value = false;
    }
  }

  bool isItemLiked(
    String type,
    int homeId,
    ManageBlogController manageBlogController,
    ManageNewsController manageNewsController,
    ClasifiedController classifiedController,
    CompanyController companyController,
    QuestionAnswerController questionAnswerController,
    EditPostController editpostController,
  ) {
    if (type == 'blog') {
      return manageBlogController.likedStatusMap[homeId] ?? false;
    } else if (type == 'news') {
      return manageNewsController.likedStatusMap[homeId] ?? false;
    } else if (type == 'classified') {
      return classifiedController.likedStatusMap[homeId] ?? false;
    } else if (type == 'company') {
      return companyController.likedStatusMap[homeId] ?? false;
    } else if (type == 'question') {
      return questionAnswerController.likedStatusMap[homeId] ?? false;
    } else if (type == 'post') {
      return editpostController.likedStatusMap[homeId] ?? false;
    }
    return false;
  }

  int getItemLikes(
    String type,
    int homeId,
    ManageBlogController manageBlogController,
    ManageNewsController manageNewsController,
    ClasifiedController classifiedController,
    CompanyController companyController,
    QuestionAnswerController questionAnswerController,
    EditPostController editpostController,
  ) {
    if (type == 'blog') {
      return manageBlogController.likeCountMap[homeId] ?? 0;
    } else if (type == 'news') {
      return manageNewsController.likeCountMap[homeId] ?? 0;
    } else if (type == 'classified') {
      return classifiedController.likeCountMap[homeId] ?? 0;
    } else if (type == 'company') {
      return companyController.likeCountMap[homeId] ?? 0;
    } else if (type == 'question') {
      return questionAnswerController.likeCountMap[homeId] ?? 0;
    } else if (type == 'post') {
      return editpostController.likeCountMap[homeId] ?? 0;
    }
    return 0;
  }

  void toggleLike(
    String type,
    int homeId,
    context,
    ManageBlogController manageBlogController,
    ManageNewsController manageNewsController,
    ClasifiedController classifiedController,
    CompanyController companyController,
    QuestionAnswerController questionAnswerController,
    EditPostController editpostController,
  ) {
    if (type == 'blog') {
      manageBlogController.toggleLike(homeId, context);
    } else if (type == 'news') {
      manageNewsController.toggleLike(homeId, context);
    } else if (type == 'classified') {
      classifiedController.toggleLike(homeId, context);
    } else if (type == 'company') {
      companyController.toggleLike(homeId, context);
    } else if (type == 'question') {
      questionAnswerController.toggleLike(homeId, context);
    } else if (type == 'post') {
      editpostController.toggleLike(homeId, context);
    }
  }

  void toggleLikeList(
    String type,
    int homeId,
    context,
    ManageBlogController manageBlogController,
    ManageNewsController manageNewsController,
    ClasifiedController classifiedController,
    QuestionAnswerController questionAnswerController,
    EditPostController editpostController,
  ) {
    if (type == 'blog') {
      manageBlogController.fetchLikeListBlog(homeId, context);
    } else if (type == 'news') {
      manageNewsController.fetchLikeListNews(homeId, context);
    } else if (type == 'classified') {
      classifiedController.fetchLikeListClassified(homeId, context);
    } else if (type == 'question') {
      questionAnswerController.fetchLikeListQuestion(homeId, context);
    } else if (type == 'post') {
      editpostController.fetchLikeListPost(homeId, context);
    }
  }

  // BookMark

  bool isItemBookmark(
    String type,
    int homeId,
    ManageBlogController manageBlogController,
    ManageNewsController manageNewsController,
    ClasifiedController classifiedController,
    CompanyController companyController,
    EditPostController editPostController,
    QuestionAnswerController questionAnswerController,
    EditPostController editpostController,
  ) {
    if (type == 'blog') {
      return manageBlogController.bookmarkStatusMap[homeId] ?? false;
    } else if (type == 'news') {
      return manageNewsController.bookmarkStatusMap[homeId] ?? false;
    } else if (type == 'classified') {
      return classifiedController.bookmarkStatusMap[homeId] ?? false;
    } else if (type == 'company') {
      return companyController.bookmarkStatusMap[homeId] ?? false;
    } else if (type == 'database') {
      return editPostController.bookmarkProfileStatusMap[homeId] ?? false;
    } else if (type == 'question') {
      return questionAnswerController.bookmarkStatusMap[homeId] ?? false;
    } else if (type == 'post') {
      return editPostController.bookmarkStatusMap[homeId] ?? false;
    }
    return false;
  }

  int getItemBookmark(
    String type,
    int homeId,
    ManageBlogController manageBlogController,
    ManageNewsController manageNewsController,
    ClasifiedController classifiedController,
    CompanyController companyController,
    EditPostController editPostController,
    QuestionAnswerController questionAnswerController,
    EditPostController editpostController,
  ) {
    if (type == 'blog') {
      return manageBlogController.bookmarkCountMap[homeId] ?? 0;
    } else if (type == 'news') {
      return manageNewsController.bookmarkCountMap[homeId] ?? 0;
    } else if (type == 'classified') {
      return classifiedController.bookmarkCountMap[homeId] ?? 0;
    } else if (type == 'company') {
      return companyController.bookmarkCountMap[homeId] ?? 0;
    } else if (type == 'database') {
      return editPostController.bookmarkProfileCountMap[homeId] ?? 0;
    } else if (type == 'question') {
      return questionAnswerController.bookmarkCountMap[homeId] ?? 0;
    } else if (type == 'post') {
      return editPostController.bookmarkCountMap[homeId] ?? 0;
    }
    return 0;
  }

  void toggleBookmark(
    String type,
    int homeId,
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
      manageBlogController.toggleBookMark(homeId, context);
    } else if (type == 'news') {
      manageNewsController.toggleBookMark(homeId, context);
    } else if (type == 'classified') {
      classifiedController.toggleBookMark(homeId, context);
    } else if (type == 'company') {
      companyController.toggleBookMark(homeId, context);
    } else if (type == 'database') {
      editPostController.toggleProfileBookMark(homeId, context);
    } else if (type == 'question') {
      questionAnswerController.toggleBookMark(homeId, context);
    } else if (type == 'post') {
      editpostController.toggleBookMark(homeId, context);
    }
  }

  // GetHomePost

  Future<void> getHome(int page) async {
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

    // Prepare query parameters
    Map<String, String> queryParams = {
      if (apiToken != null) 'api_token': apiToken,
      'device': device,
      'page': page.toString(),
      'search': search.value.text,
      'type': selectedType.value == 'All' ? '' : selectedType.value,
    };

    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        isLoading.value = false;
        return;
      }

      Uri uri = Uri.parse(Constants.baseUrl + Constants.gethome)
          .replace(queryParameters: queryParams);
      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final GetHomeEntity allHomeEntity =
            GetHomeEntity.fromJson(responseData);

        final List<GetHomeData> myHomeData = allHomeEntity.data ?? [];
        if (myHomeData.isNotEmpty) {
          if (page == 1) {
            homeList.assignAll(allHomeEntity.data ?? []);
          } else {
            homeList.addAll(allHomeEntity.data ?? []);
          }

          if (myHomeData.length < 10) {
            isEndOfData.value = true;
          }
        } else {
          isEndOfData.value = true;
        }
      } else if (response.statusCode == 401) {
        if (kDebugMode) {
          print('Failed to fetch notifications, status code: 401');
        }
        Get.offAllNamed(Routes.login);
      }
    } catch (error) {
      // Handle general error case
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> mutualFriend(int page) async {
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
      };

      Uri uri = Uri.parse(Constants.baseUrl + Constants.mutualfriend)
          .replace(queryParameters: queryParams);
      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final MutualFriendsEntity allHomeEntity =
            MutualFriendsEntity.fromJson(responseData);

        if (kDebugMode) {
          print('Mutual data: $responseData');
        }

        final List<MutualFriendsData> myHomeData = allHomeEntity.data ?? [];
        if (myHomeData.isNotEmpty) {
          if (page == 1) {
            mutualFriendList.assignAll(allHomeEntity.data ?? []);
          } else {
            mutualFriendList.addAll(allHomeEntity.data ?? []);
          }

          if (myHomeData.length < 10) {
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
