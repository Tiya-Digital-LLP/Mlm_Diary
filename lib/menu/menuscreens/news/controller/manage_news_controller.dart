import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/add_comment_news_entity.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/bookmark_news_entity.dart';
import 'package:mlmdiary/generated/edit_comment_entity.dart';
import 'package:mlmdiary/generated/get_category_entity.dart';
import 'package:mlmdiary/generated/get_comment_news_entity.dart';
import 'package:mlmdiary/generated/get_news_detail_entity.dart';
import 'package:mlmdiary/generated/get_news_list_entity.dart';
import 'package:mlmdiary/generated/get_sub_category_entity.dart';
import 'package:mlmdiary/generated/liked_news_entity.dart';
import 'package:mlmdiary/generated/my_news_entity.dart';
import 'package:mlmdiary/generated/news_count_view_entity.dart';
import 'package:mlmdiary/generated/news_like_list_entity.dart';
import 'package:mlmdiary/generated/views_news_list_entity.dart';
import 'package:mlmdiary/utils/app_colors.dart';

import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class ManageNewsController extends GetxController {
  Rx<TextEditingController> title = TextEditingController().obs;
  Rx<TextEditingController> discription = TextEditingController().obs;
  Rx<TextEditingController> url = TextEditingController().obs;
  var isLiked = false.obs;
  var isBookMarked = false.obs;

  //category
  RxList<GetCategoryCategory> categorylist = RxList<GetCategoryCategory>();
  final RxList<bool> isCategorySelectedList = RxList<bool>([]);
  //subcategory
  RxList<GetSubCategoryCategory> subcategoryList =
      RxList<GetSubCategoryCategory>();
  final RxList<bool> isSubCategorySelectedList = RxList<bool>([]);

  RxList<MyNewsData> myNewsList = <MyNewsData>[].obs;
  RxList<GetNewsListData> newsList = <GetNewsListData>[].obs;
  RxList<GetNewsDetailData> newsDetailList = <GetNewsDetailData>[].obs;

  RxList<NewsLikeListData> newsLikeList = RxList<NewsLikeListData>();
  RxList<ViewsNewsListData> newsViewList = RxList<ViewsNewsListData>();

// news comment
  RxList<GetCommentNewsData> getCommentList = <GetCommentNewsData>[].obs;
  Rx<TextEditingController> commment = TextEditingController().obs;

  int page = 1;
  var isEndOfData = false.obs;

  //like
  RxMap<int, bool> likedStatusMap = <int, bool>{}.obs;
  RxMap<int, int> likeCountMap = <int, int>{}.obs;

  //bookmark
  var bookmarkStatusMap = <int, bool>{};
  var bookmarkCountMap = <int, int>{};

  var likeCount = 0.obs;
// FIELDS ERROR

  RxBool titleError = false.obs;
  RxBool discriptionError = false.obs;
  RxBool urlError = false.obs;
  RxBool categoryError = false.obs;
  RxBool subCategoryError = false.obs;

  // ENABLED TYPING VALIDATION
  RxBool isCategoryTyping = false.obs;
  RxBool isSubCategoryTyping = false.obs;
  RxBool isTitleTyping = false.obs;
  RxBool isDiscriptionTyping = false.obs;
  RxBool isUrlTyping = false.obs;
  RxBool isLocationTyping = false.obs;
  RxInt selectedCountCategory = 0.obs;

  RxInt selectedCountSubCategory = 0.obs;

  final search = TextEditingController();

  //image
  RxString userImage = ''.obs;

  RxBool isLoading = false.obs;

  // READ ONLY FIELDS
  RxBool titleReadOnly = false.obs;

  //scrollercontroller
  final ScrollController scrollController = ScrollController();

  var selectedCategoryId = 0.obs;
  var selectedSubCategoryId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryList();
    getNews(1);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isEndOfData.value) {
        int nextPage = (newsList.length ~/ 10) + 1;
        getNews(nextPage);
      }
    });
  }

  void resetSelections() {
    // Reset category and subcategory selections
    selectedCategoryId.value = 0;
    selectedSubCategoryId.value = 0;
    getNews(1);
  }

  Future<void> countViewNews(int newsId, context) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.countviewnews}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['news_id'] = newsId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var countViewNewsEntity = NewsCountViewEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $countViewNewsEntity');
          }
        } else {
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchNewsDetail(int newsId, context) async {
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
        'news_id': newsId.toString(),
      };

      if (kDebugMode) {
        print('api_token: $apiToken');
        print('device: $device');
        print('news_id: $newsId');
      }

      Uri uri = Uri.parse(Constants.baseUrl + Constants.newsdetail)
          .replace(queryParameters: queryParams);

      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(json.encode(responseData));
        } // Print entire response data

        final GetNewsDetailEntity newsDetailEntity =
            GetNewsDetailEntity.fromJson(responseData);

        final GetNewsDetailData firstPost = newsDetailEntity.data!;
        // Replace old data with the fetched post
        newsDetailList.clear(); // Ensure old data is cleared
        newsDetailList.add(firstPost);
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

  // Method to fetch data from API
  Future<void> fetchMyNews({
    int page = 1,
    BuildContext? context,
    int? newsId,
  }) async {
    isLoading(true);
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }

    if (kDebugMode) {
      print('Device Name: $device');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        if (context != null) {
          // ignore: use_build_context_synchronously
          showToasterrorborder("No internet connection", context);
        }

        isLoading(false);

        return;
      }

      Map<String, String> formData = {
        'api_token': apiToken ?? '',
        'device': device,
        'page': page.toString(),
      };

      // If articleId is provided, add it to formData
      if (newsId != null) {
        formData['news_id'] = newsId.toString();
      }

      Uri uri = Uri.parse(Constants.baseUrl + Constants.mynews);
      final response = await http.post(uri, body: formData);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final MyNewsEntity myNewsEntity = MyNewsEntity.fromJson(responseData);

        if (kDebugMode) {
          print('Manage News data: $responseData');
        }

        final List<MyNewsData> myNewsData = myNewsEntity.data ?? [];

        // Assign or add data to myBlogList based on the page number
        if (page == 1) {
          myNewsList.assignAll(myNewsData);
        } else {
          myNewsList.addAll(myNewsData);
        }

        updateUIWithBlogData(myNewsData.first);
      } else {
        // Show error message if response status code is not 200
        if (context != null) {
          // ignore: use_build_context_synchronously
          showToasterrorborder("Failed to fetch data", context);
        }
      }
    } catch (error) {
      // Show error message for any caught exception
      if (context != null) {
        // ignore: use_build_context_synchronously
        showToasterrorborder("An error occurred: $error", context);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateUIWithBlogData(MyNewsData blogData) async {
    title.value.text = blogData.title ?? '';
    discription.value.text = blogData.description ?? '';
    url.value.text = blogData.website ?? '';
    userImage.value = blogData.imagePath ?? '';

// Handle category selection (using categoryId as int)
    int? categoryId = int.tryParse(blogData.category ?? '');

    if (categoryId != null) {
      if (kDebugMode) {
        print('Category ID selected: $categoryId');
      }

      isCategorySelectedList.fillRange(0, isCategorySelectedList.length, false);
      int index = categorylist.indexWhere((item) => item.id == categoryId);

      if (kDebugMode) {
        print('Category index by ID: $index');
      }

      if (index != -1) {
        isCategorySelectedList[index] = true;
        selectedCountCategory.value = 1;
        selectedCategoryId.value = categorylist[index].id!;

        if (kDebugMode) {
          print('Category selected, ID: ${selectedCategoryId.value}');
        }

        await fetchSubCategoryList(categorylist[index].id!);
      }
    } else {
      if (kDebugMode) {
        print('Invalid categoryId');
      }
    }

    // Handle subcategory selection (using subcategoryId as int)
    int? subcategoryId = int.tryParse(blogData.subcategory ?? '');

    if (subcategoryId != null) {
      if (kDebugMode) {
        print('Subcategory ID selected: $subcategoryId');
      }

      isSubCategorySelectedList.fillRange(
          0, isSubCategorySelectedList.length, false);

      int subcategoryIndex =
          subcategoryList.indexWhere((item) => item.id == subcategoryId);

      if (kDebugMode) {
        print('Subcategory index by ID: $subcategoryIndex');
      }

      if (subcategoryIndex != -1) {
        isSubCategorySelectedList[subcategoryIndex] = true;
        selectedCountSubCategory.value = 1;
        selectedSubCategoryId.value = subcategoryList[subcategoryIndex].id!;

        if (kDebugMode) {
          print('Subcategory selected, ID: ${selectedSubCategoryId.value}');
        }
      } else {
        if (kDebugMode) {
          print('Subcategory not found in the list');
        }
      }
    } else {
      if (kDebugMode) {
        print('Invalid subcategoryId');
      }
    }
  }

  String getSelectedSubCategoryText() {
    List<String> selectedSubCategories = [];
    for (int i = 0; i < isSubCategorySelectedList.length; i++) {
      if (isSubCategorySelectedList[i]) {
        selectedSubCategories.add(subcategoryList[i].name ?? '');
      }
    }
    return selectedSubCategories.join(', ');
  }

  Future<void> fetchCategoryList() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        final response = await http
            .get(Uri.parse('${Constants.baseUrl}${Constants.getcategorylist}'));

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Response body: $jsonBody");
          }

          final categoryListEntity = GetCategoryEntity.fromJson(jsonBody);

          if (categoryListEntity.status == 1) {
            if (kDebugMode) {
              print("category list fetched successfully");
            }

            categorylist.value = categoryListEntity.category ?? [];
            isCategorySelectedList
                .assignAll(List<bool>.filled(categorylist.length, false));
            if (categorylist.isNotEmpty) {
              // Fetch subcategories for the first category by default
              fetchSubCategoryList(categorylist[0].id!);
            }
            if (kDebugMode) {
              print("category list: $categorylist");
            }
          } else {
            // Handle error when status is not 1
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to fetch category list. Status code: ${response.statusCode}");
          }
        }
      } else {
        //
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }
    }
  }

  Future<void> fetchSubCategoryList(int categoryId) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        final uri =
            Uri.parse('${Constants.baseUrl}${Constants.getsubcategorylist}')
                .replace(
                    queryParameters: {'category_id': categoryId.toString()});
        final response = await http.get(uri);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Subcategory response body: $jsonBody");
          }

          final subCategoryListEntity = GetSubCategoryEntity.fromJson(jsonBody);

          if (subCategoryListEntity.status == 1) {
            if (kDebugMode) {
              print("Subcategory list fetched successfully");
            }

            subcategoryList.value = subCategoryListEntity.category ?? [];
            isSubCategorySelectedList
                .assignAll(List<bool>.filled(subcategoryList.length, false));
            if (kDebugMode) {
              print("Subcategory list: $subcategoryList");
            }
          } else {
            // Handle error when status is not 1
            if (kDebugMode) {
              print(
                  "Failed to fetch subcategory list, status: ${subCategoryListEntity.status}");
            }
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to fetch subcategory list. Status code: ${response.statusCode}");
          }
        }
      } else {
        //
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }
    }
  }

  // Delete-News
  Future<void> deleteNews(int newsId, int index, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    isLoading(true);
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.deletenews}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['news_id'] = newsId.toString();

        if (kDebugMode) {
          print('news id from delete news: $newsId');
          print('news token from delete news: $apiToken');
        }

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var status = data['status'];
          var message = data['message'];

          if (status == 1) {
            showToastverifedborder(message!, context);
            myNewsList.removeAt(index);
          } else {
            if (kDebugMode) {
              print('Failed to delete News: $message');
            }
          }

          if (kDebugMode) {
            print('data from delete News: $data');
          }
        } else {
          Fluttertoast.showToast(
            msg: "Error: ${response.body}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
          if (kDebugMode) {
            print('Error: ${response.body}');
          }
        }
      } else {
        Fluttertoast.showToast(
          msg: "No internet connection",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
        if (kDebugMode) {
          print('No internet connection');
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isLoading(false);
    }
  }

// Category
  void toggleCategorySelected(int index, BuildContext context) {
    // Unselect all categories
    for (int i = 0; i < isCategorySelectedList.length; i++) {
      isCategorySelectedList[i] = false;
    }

    // Select the current category
    isCategorySelectedList[index] = true;
    selectedCountCategory.value = 1;
    selectedCategoryId.value = categorylist[index].id!;

    // Fetch subcategory list for the selected category
    fetchSubCategoryList(categorylist[index].id!);

    // ignore: unrelated_type_equality_checks
    categoryError.value = selectedCountCategory == 0;
    isCategoryTyping.value = true;
  }

  TextEditingController getSelectedCategoryTextController() {
    List<String> selectedCategoryNames = [];

    for (int i = 0; i < isCategorySelectedList.length; i++) {
      if (isCategorySelectedList[i]) {
        selectedCategoryNames.add(categorylist[i].name ?? '');
      }
    }

    return TextEditingController(text: selectedCategoryNames.join(', '));
  }

  void mlmCategoryValidation() {
    // ignore: unrelated_type_equality_checks
    categoryError.value = selectedCountCategory == 0;

    if (categoryError.value) {
      isCategoryTyping.value = true;
    }
  }

  // sub Category
  void toggleSubCategorySelected(int index) {
    bool isCurrentlySelected = isSubCategorySelectedList[index];

    // Unselect all subcategories
    for (int i = 0; i < isSubCategorySelectedList.length; i++) {
      isSubCategorySelectedList[i] = false;
    }

    // Toggle the selected state of the current subcategory
    isSubCategorySelectedList[index] = !isCurrentlySelected;
    selectedCountSubCategory.value = isSubCategorySelectedList[index] ? 1 : 0;
    selectedSubCategoryId.value = subcategoryList[index].id!;

    // ignore: unrelated_type_equality_checks
    subCategoryError.value = selectedCountSubCategory == 0;
    isSubCategoryTyping.value = true;
  }

  TextEditingController getSelectedSubCategoryTextController() {
    List<String> selectedSubCategoryNames = [];
    for (int i = 0; i < isSubCategorySelectedList.length; i++) {
      if (isSubCategorySelectedList[i]) {
        selectedSubCategoryNames.add(subcategoryList[i].name ?? '');
      }
    }

    return TextEditingController(text: selectedSubCategoryNames.join(', '));
  }

  void mlmsubCategoryValidation() {
    // ignore: unrelated_type_equality_checks
    subCategoryError.value = selectedCountSubCategory == 0;

    if (subCategoryError.value) {
      isSubCategoryTyping.value = true;
    }
  }

  //updateclassified

  Future<void> updateNews(File? imageFile, int newsId, context) async {
    isLoading(true);
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${Constants.baseUrl}${Constants.updatenews}'),
        );

        request.fields['device'] = device;
        request.fields['title'] = title.value.text;
        request.fields['description'] = discription.value.text;
        request.fields['category'] = selectedCategoryId.value.toString();
        request.fields['subcategory'] = selectedSubCategoryId.value.toString();
        request.fields['website'] = url.value.text;
        request.fields['api_token'] = apiToken ?? '';
        request.fields['news_id'] = newsId.toString();

        if (kDebugMode) {
          print('News id ; $newsId');
        }

        if (imageFile != null) {
          if (kDebugMode) {
            print('Attaching new image file: ${imageFile.path}');
          }
          request.files.add(
            http.MultipartFile(
              'photo',
              imageFile.readAsBytes().asStream(),
              imageFile.lengthSync(),
              filename: 'image.jpg',
              contentType: MediaType('image', 'jpg'),
            ),
          );
        }

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Response body: $jsonBody");
          }
          // Check if all fields in the response are true (you may need to adjust this condition based on the actual response structure)
          if (jsonBody['status'] == 1) {
            toastification.show(
              context: context,
              alignment: Alignment.bottomCenter,
              backgroundColor: AppColors.white,
              type: ToastificationType.success,
              style: ToastificationStyle.flatColored,
              showProgressBar: false,
              autoCloseDuration: const Duration(seconds: 3),
              icon: Image.asset(
                Assets.imagesChecked,
                height: 35,
              ),
              primaryColor: Colors.green,
              title: const Text('News Updated Successfully'),
            );
            Get.back();
            fetchMyNews();
          } else if (jsonBody['status'] == 0) {
            toastification.show(
              context: context,
              alignment: Alignment.bottomCenter,
              backgroundColor: AppColors.white,
              type: ToastificationType.error,
              style: ToastificationStyle.flatColored,
              showProgressBar: false,
              autoCloseDuration: const Duration(seconds: 3),
              icon: Image.asset(
                Assets.imagesCancel,
                height: 35,
              ),
              primaryColor: Colors.red,
              title: Text('${jsonBody['message']}'),
            );
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to Update company details. Status code: ${response.statusCode}");
            print("Response body: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred while saving company details: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  //liked News
  Future<void> likedNewsUser(int newsId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.likednews}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['news_id'] = newsId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var likedBlogEntity = LikedNewsEntity.fromJson(data);
          var message = likedBlogEntity.message;

          // Update the liked status and like count based on the message
          if (message == 'You have liked this News') {
            likedStatusMap[newsId] = true;
            likeCountMap[newsId] = (likeCountMap[newsId] ?? 0);
          } else if (message == 'You have unliked this News') {
            likedStatusMap[newsId] = false;
            likeCountMap[newsId] = (likeCountMap[newsId] ?? 0);
          }

          showToastverifedborder(message!, context);
        } else {
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  // like_list_classified
  Future<void> fetchLikeListNews(int classifiedId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    isLoading(true);
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // Log connectivity result
      if (kDebugMode) {
        print('Connectivity result: $connectivityResult');
      }

      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.likelistnews}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['news_id'] = classifiedId.toString();

        // Log request details
        if (kDebugMode) {
          print('Request URL: $uri');
          print('Request fields: ${request.fields}');
        }

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        // Log response status code
        if (kDebugMode) {
          print('Response status code: ${response.statusCode}');
        }

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var status = data['status'];

          // Log response body
          if (kDebugMode) {
            print('Response body: ${response.body}');
          }

          if (status == 1) {
            var classifiedLikeListEntity = NewsLikeListEntity.fromJson(data);
            newsLikeList.value = classifiedLikeListEntity.data ?? [];

            // Log parsed data
            if (kDebugMode) {
              print('Parsed entity: $classifiedLikeListEntity');
            }
          } else {
            var message = data['message'];

            // Log failure message
            if (kDebugMode) {
              print('Failed to fetch likelist classified: $message');
            }
          }
        } else {
          // Log error response
          if (kDebugMode) {
            print('Error: ${response.body}');
          }
        }
      } else {
        // Log no internet connection
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      // Log exception
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isLoading(false);
      // Log end of method execution
      if (kDebugMode) {
        print('Finished fetchLikeListClassified method');
      }
    }
  }

  // like_list_classified
  Future<void> fetchViewListNews(int classifiedId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    isLoading(true);
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // Log connectivity result
      if (kDebugMode) {
        print('Connectivity result: $connectivityResult');
      }

      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.viewlistnews}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['news_id'] = classifiedId.toString();

        // Log request details
        if (kDebugMode) {
          print('Request URL: $uri');
          print('Request fields: ${request.fields}');
        }

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        // Log response status code
        if (kDebugMode) {
          print('Response status code: ${response.statusCode}');
        }

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var status = data['status'];

          // Log response body
          if (kDebugMode) {
            print('Response body: ${response.body}');
          }

          if (status == 1) {
            var newsViewListEntity = ViewsNewsListEntity.fromJson(data);
            newsViewList.value = newsViewListEntity.data ?? [];

            // Log parsed data
            if (kDebugMode) {
              print('Parsed entity: $newsViewListEntity');
            }
          } else {
            var message = data['message'];

            // Log failure message
            if (kDebugMode) {
              print('Failed to fetch newsViewList classified: $message');
            }
          }
        } else {
          // Log error response
          if (kDebugMode) {
            print('Error: ${response.body}');
          }
        }
      } else {
        // Log no internet connection
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      // Log exception
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isLoading(false);
      // Log end of method execution
      if (kDebugMode) {
        print('Finished newsViewList method');
      }
    }
  }

  void titleValidation(context) {
    String enteredTitle = title.value.text;
    if (enteredTitle.isEmpty || hasSpecialCharactersOrNumbers(enteredTitle)) {
      // Show toast message for invalid title
      showToasterrorborder("Please Enter Title", context);
      titleError.value = true;
    } else {
      titleError.value = false;
    }
  }

  Future<void> toggleLike(int newsId, context) async {
    bool isLiked = likedStatusMap[newsId] ?? false;
    isLiked = !isLiked;
    likedStatusMap[newsId] = isLiked;
    likeCountMap.update(newsId, (value) => isLiked ? value + 1 : value - 1,
        ifAbsent: () => isLiked ? 1 : 0);

    await likedNewsUser(newsId, context);
  }

  Future<void> getNews(int page) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = '';

    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.getnews}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['page'] = page.toString();
        request.fields['search'] = search.value.text;
        request.fields['category'] = selectedCategoryId.value.toString();
        request.fields['subcategory'] = selectedSubCategoryId.value.toString();

        if (kDebugMode) {
          print('Request URL: ${request.url}');
          print('Request Fields: ${request.fields}');
        }

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          var getNewsEntity = GetNewsListEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $getNewsEntity');
          }

          if (getNewsEntity.data != null && getNewsEntity.data!.isNotEmpty) {
            if (page == 1) {
              newsList.value = getNewsEntity.data!;
            } else {
              newsList.addAll(getNewsEntity.data!);
            }
            isEndOfData(false);
          } else {
            if (page == 1) {
              newsList.clear();
            }
            isEndOfData(true);
          }
        } else {
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      } else {
        // Handle connectivity issues
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  // Bookmark
  Future<void> bookmarkUser(int newsId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.bookmarknews}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['news_id'] = newsId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var bookmarkNewsEntity = BookmarkNewsEntity.fromJson(data);
          var message = bookmarkNewsEntity.message;

          // Update the liked status and like count based on the message
          if (message == 'You have bookmark this News') {
            bookmarkStatusMap[newsId] = true;
            bookmarkCountMap[newsId] = (bookmarkCountMap[newsId] ?? 0) + 1;
          } else if (message == 'You have unbookmark this News') {
            bookmarkStatusMap[newsId] = false;
            bookmarkCountMap[newsId] = (bookmarkCountMap[newsId] ?? 0) - 1;
          }

          showToastverifedborder(message!, context);
        } else {
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleBookMark(int newsId, context) async {
    bool isBookmark = bookmarkStatusMap[newsId] ?? false;
    isBookmark = !isBookmark;
    bookmarkStatusMap[newsId] = isBookmark;
    bookmarkCountMap.update(
        newsId, (value) => isBookmark ? value + 1 : value - 1,
        ifAbsent: () => isBookmark ? 1 : 0);

    await bookmarkUser(newsId, context);
  }

// comment for news
  Future<void> getCommentNews(int page, int newsId, context) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.getcommentnews}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['page'] = page.toString();
        request.fields['news_id'] = newsId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var getCommentNewsEntity = GetCommentNewsEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $getCommentNewsEntity');
          }

          if (getCommentNewsEntity.data != null &&
              getCommentNewsEntity.data!.isNotEmpty) {
            if (page == 1) {
              getCommentList.value = getCommentNewsEntity.data!;
            } else {
              getCommentList.addAll(getCommentNewsEntity.data!);
            }
            isEndOfData(false);
          } else {
            if (page == 1) {
              getCommentList.clear();
            }
            isEndOfData(true);
          }
        } else {
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> addReplyNewsComment(int newsId, int commentId, context) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.addcommentnewsreply}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['news_id'] = newsId.toString();
        request.fields['comment_id'] = commentId.toString();
        request.fields['comment'] = commment.value.text;

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var addCommentNewsEntity = AddCommentNewsEntity.fromJson(data);
          if (data['status'] == 0) {
            showToasterrorborder(data['message'], context);
          } else {
            getCommentNews(1, newsId, context);
            if (kDebugMode) {
              print('Success: $addCommentNewsEntity');
            }
          }

          if (kDebugMode) {
            print('Success: $addCommentNewsEntity');
          }
        } else {
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteComment(int newsId, int commentId, context) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.deletecommment}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['type'] = 'news';
        request.fields['comment_id'] = commentId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          jsonDecode(response.body);
          // Handle success response as needed
          await getCommentNews(1, newsId, context);
        } else {
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> editComment(int newsId, int commentId, String newComment,
      String type, context) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.editcommment}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['comment_id'] = commentId.toString();
        request.fields['type'] = type;
        request.fields['comment'] = commment.value.text;

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var editCommentEntity = EditCommentEntity.fromJson(data);
          await getCommentNews(1, newsId, context);

          if (kDebugMode) {
            print('Success: $editCommentEntity');
          }
        } else {
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  void discriptionValidation(context) {
    String enteredDiscription = discription.value.text;
    if (enteredDiscription.isEmpty ||
        hasSpecialTextOrNumbers(enteredDiscription)) {
      showToasterrorborder("Please Enter Discription", context);
      discriptionError.value = true;
    } else {
      discriptionError.value = false;
    }
  }

  void urlValidation() {
    String enteredUrl = url.value.text;
    if (enteredUrl.isEmpty || hasSpecialTextOrNumbers(enteredUrl)) {
      urlError.value = true;
    } else {
      urlError.value = false;
    }
  }

  bool hasSpecialCharactersOrNumbers(String text) {
    RegExp specialCharOrNumber = RegExp(r'[!@#\$&*()]|[0-9]');
    return specialCharOrNumber.hasMatch(text);
  }

  bool hasSpecialTextOrNumbers(String text) {
    RegExp alphanumericRegex = RegExp(r'[a-zA-Z0-9]');
    return !alphanumericRegex.hasMatch(text);
  }

  final RxInt timerValue = 30.obs;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerValue.value > 0) {
        timerValue.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    timerValue.value = 30;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
