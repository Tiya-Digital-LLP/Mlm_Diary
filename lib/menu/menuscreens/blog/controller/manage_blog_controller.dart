import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/blog_bookmark_entity.dart';
import 'package:mlmdiary/generated/get_category_entity.dart';
import 'package:mlmdiary/generated/get_sub_category_entity.dart';
import 'package:mlmdiary/generated/l_iked_blog_entity.dart';
import 'package:mlmdiary/generated/my_blog_list_entity.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageBlogController extends GetxController {
  Rx<TextEditingController> title = TextEditingController().obs;
  Rx<TextEditingController> discription = TextEditingController().obs;
  Rx<TextEditingController> url = TextEditingController().obs;
  var isLiked = false.obs;
  var isBookMarked = false.obs;

  var likeCount = 0.obs;

  //category
  RxList<GetCategoryCategory> categorylist = RxList<GetCategoryCategory>();
  final RxList<bool> isCategorySelectedList = RxList<bool>([]);
  //subcategory
  RxList<GetSubCategoryCategory> subcategoryList =
      RxList<GetSubCategoryCategory>();
  final RxList<bool> isSubCategorySelectedList = RxList<bool>([]);

  RxList<MyBlogListData> myBlogList = <MyBlogListData>[].obs;

  //like
  var likedStatusMap = <int, bool>{};
  var likeCountMap = <int, int>{};

//bookmark
  var bookmarkStatusMap = <int, bool>{};
  var bookmarkCountMap = <int, int>{};

  RxString userImage = ''.obs;

  RxInt articleId = RxInt(0);

// FIELDS ERROR

  RxBool titleError = false.obs;
  RxBool discriptionError = false.obs;
  RxBool urlError = false.obs;
  RxBool categoryError = false.obs;
  RxBool subCategoryError = false.obs;

  // ENABLED TYPING VALIDATION
  RxBool isTitleTyping = false.obs;
  RxBool isDiscriptionTyping = false.obs;
  RxBool isUrlTyping = false.obs;
  RxBool isLocationTyping = false.obs;
  RxInt selectedCountCategory = 0.obs;

  RxInt selectedCountSubCategory = 0.obs;

  var isLoading = false.obs;

  // READ ONLY FIELDS
  RxBool titleReadOnly = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryList();
    fetchMyBlog();
  }

  // Method to fetch data from API
  Future<void> fetchMyBlog({int page = 1, context, int? articleId}) async {
    isLoading.value = true;
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
      // Check internet connection
      var connectivityResult = await (Connectivity().checkConnectivity());
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        showToasterrorborder("No internet connection", context);
        isLoading.value = false;
        return;
      }

      // Prepare query parameters
      Map<String, String> queryParams = {
        'api_token': apiToken ?? '',
        'device': device,
        'page': page.toString(),
      };

      // Build URL
      Uri uri = Uri.parse(Constants.baseUrl + Constants.myblog)
          .replace(queryParameters: queryParams);

      // Make HTTP GET request
      final response = await http.post(uri);

      if (response.statusCode == 200) {
        // Parse JSON data
        final Map<String, dynamic> responseData = json.decode(response.body);
        final MyBlogListEntity myBlogEntity =
            MyBlogListEntity.fromJson(responseData);

        if (kDebugMode) {
          print('manage Blog data: $responseData');
        }

        // Store ID using SharedPreferences
        final List<MyBlogListData> myBlogData = myBlogEntity.data ?? [];
        if (myBlogData.isNotEmpty) {
          final MyBlogListData firstNews = myBlogData[0];
          final String blogId = firstNews.articleId.toString();
          await prefs.setString('lastBlogid', blogId);
          if (kDebugMode) {
            print('Last Blog ID stored: $blogId');
          }

          // Map data to controllers
          title.value.text = firstNews.title ?? '';
          discription.value.text = firstNews.description ?? '';
          url.value.text = firstNews.website ?? '';
          userImage.value = firstNews.imagePath ?? '';

          // Update Category List
          isCategorySelectedList.clear();
          for (var category in categorylist) {
            bool isSelected = firstNews.category == (category.id.toString());
            isCategorySelectedList.add(isSelected);
          }

          // Update SubCategory List
          isSubCategorySelectedList.clear();
          for (var subcategory in subcategoryList) {
            bool isSelected =
                firstNews.subcategory == (subcategory.id.toString());
            isSubCategorySelectedList.add(isSelected);
          }
        }

        // Update state with fetched data
        if (page == 1) {
          myBlogList.assignAll(myBlogEntity.data ?? []);
        } else {
          myBlogList.addAll(myBlogEntity.data ?? []);
        }

        // Update UI based on articleId
        if (articleId != null) {
          // Find the fetched blog data with the matching articleId
          MyBlogListData? selectedBlog;
          for (var blog in myBlogEntity.data ?? []) {
            if (blog.articleId == articleId) {
              selectedBlog = blog;
              break;
            }
          }

          if (selectedBlog != null) {
            // Update UI with selected blog data
            title.value.text = selectedBlog.title ?? '';
            discription.value.text = selectedBlog.description ?? '';
            url.value.text = selectedBlog.website ?? '';
            userImage.value = selectedBlog.imagePath ?? '';

            // Update Category List
            isCategorySelectedList.clear();
            for (var category in categorylist) {
              bool isSelected =
                  selectedBlog.category == (category.id.toString());
              isCategorySelectedList.add(isSelected);
            }
            // Update SubCategory List
            isSubCategorySelectedList.clear();
            for (var subcategory in subcategoryList) {
              bool isSelected =
                  selectedBlog.subcategory == (subcategory.id.toString());
              isSubCategorySelectedList.add(isSelected);
            }
          } else {
            // Show a message indicating that the blog with the specified ID was not found
            showToasterrorborder("Blog with ID $articleId not found", context);
          }
        }
      } else {
        // Handle error response
        showToasterrorborder("Failed to fetch data", context);
      }
    } catch (error) {
      // Handle network or parsing errors
      showToasterrorborder("An error occurred: $error", context);
    } finally {
      isLoading.value = false;
    }
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
        if (kDebugMode) {
          print("No internet connection available.");
        }
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
        if (kDebugMode) {
          print("No internet connection available.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }
    }
  }

  // Category
  void toggleCategorySelected(int index) {
    isCategorySelectedList[index] = !isCategorySelectedList[index];

    selectedCountCategory.value = isCategorySelectedList[index] ? 1 : 0;

    if (isCategorySelectedList[index]) {
      fetchSubCategoryList(categorylist[index].id!);
    }
  }

  TextEditingController getSelectedCategoryTextController() {
    List<String> selectedCategoryOptions = [];

    for (int i = 0; i < isCategorySelectedList.length; i++) {
      if (isCategorySelectedList[i]) {
        selectedCategoryOptions.add(categorylist[i].id.toString());
      }
    }

    return TextEditingController(text: selectedCategoryOptions.join(', '));
  }

  void mlmCategoryValidation() {
    // ignore: unrelated_type_equality_checks
    categoryError.value = selectedCountCategory == 0;
  }

  // sub Category
  void toggleSubCategorySelected(int index) {
    bool isCurrentlySelected = isSubCategorySelectedList[index];

    // Unselect all sub-categories first
    for (int i = 0; i < isSubCategorySelectedList.length; i++) {
      isSubCategorySelectedList[i] = false;
    }

    isSubCategorySelectedList[index] = !isCurrentlySelected;

    selectedCountSubCategory.value = isSubCategorySelectedList[index] ? 1 : 0;
  }

  TextEditingController getSelectedSubCategoryTextController() {
    List<String> selectedSubCategoryOptions = [];
    for (int i = 0; i < isSubCategorySelectedList.length; i++) {
      if (isSubCategorySelectedList[i]) {
        selectedSubCategoryOptions.add(subcategoryList[i].id.toString());
      }
    }

    return TextEditingController(text: selectedSubCategoryOptions.join(', '));
  }

  void mlmsubCategoryValidation() {
    // ignore: unrelated_type_equality_checks
    subCategoryError.value = selectedCountSubCategory == 0;
  }

  Future<void> deleteBlog(int blogId, int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    isLoading(true);
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.deleteblog}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['blog_id'] = blogId.toString();

        if (kDebugMode) {
          print('blog id from delete blog: $blogId');
          print('blog token from delete blog: $apiToken');
        }

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var status = data['status'];
          var message = data['message'];

          if (status == 1) {
            Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
            );
            myBlogList.removeAt(index);
          } else {
            Fluttertoast.showToast(
              msg: "Failed to delete blog: $message",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
            );
            if (kDebugMode) {
              print('Failed to delete blog: $message');
            }
          }

          if (kDebugMode) {
            print('data from delete blog: $data');
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

  //liked Blog
  Future<void> likedBlogUser(int blogId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.likedblog}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['blog_id'] = blogId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var likedBlogEntity = LIkedBlogEntity.fromJson(data);
          var message = likedBlogEntity.message;

          // Update the liked status and like count based on the message
          if (message == 'You have liked this Blog') {
            likedStatusMap[blogId] = true;
            likeCountMap[blogId] = (likeCountMap[blogId] ?? 0) + 1;
          } else if (message == 'You have unliked this Blog') {
            likedStatusMap[blogId] = false;
            likeCountMap[blogId] = (likeCountMap[blogId] ?? 0) - 1;
          }

          showToastverifedborder(message!, context);
        } else {
          showToasterrorborder("Error: ${response.body}", context);
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      showToasterrorborder("Error: $e", context);
    } finally {
      isLoading(false);
    }
  }

  // Bookmark
  Future<void> blogBookmark(int classifiedId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.blogBookmark}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['classified_id'] = classifiedId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var bookmarkUserEntity = BlogBookmarkEntity.fromJson(data);
          var message = bookmarkUserEntity.message;

          // Update the liked status and like count based on the message
          if (message == 'You have bookmark this Blog') {
            bookmarkStatusMap[classifiedId] = true;
            bookmarkCountMap[classifiedId] =
                (bookmarkCountMap[classifiedId] ?? 0) + 1;
          } else if (message == 'You have unbookmark this Blog') {
            bookmarkStatusMap[classifiedId] = false;
            bookmarkCountMap[classifiedId] =
                (bookmarkCountMap[classifiedId] ?? 0) - 1;
          }

          Fluttertoast.showToast(
            msg: message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Error: ${response.body}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "No internet connection",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  //update-Blog
  Future<void> updateBlog({
    required File? imageFile,
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
    String? blogId = prefs.getString('lastBlogid');

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${Constants.baseUrl}${Constants.updateblog}'),
        );

        request.fields['device'] = device;
        request.fields['title'] = title.value.text;
        request.fields['description'] = discription.value.text;
        request.fields['category'] = getSelectedCategoryTextController().text;
        request.fields['subcategory'] =
            getSelectedSubCategoryTextController().text;
        request.fields['website'] = url.value.text;
        request.fields['api_token'] = apiToken ?? '';
        request.fields['blog_id'] = blogId.toString();

        if (kDebugMode) {
          print('Blog id  $blogId');
        }

        if (imageFile != null) {
          request.files.add(
            http.MultipartFile(
              'image',
              imageFile.readAsBytes().asStream(),
              imageFile.lengthSync(),
              filename: 'image.jpg',
              contentType: MediaType('image', 'jpg'),
            ),
          );
        } else {
          request.files.add(
            http.MultipartFile.fromString(
              'image',
              'dummy_image.jpg',
              filename: 'dummy_image.jpg',
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
          if (jsonBody['success'] == true) {
            // All fields are true, navigate back
            Get.back();
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to Update Blog details. Status code: ${response.statusCode}");
            print("Response body: ${response.body}");
          }
        }
      } else {
        if (kDebugMode) {
          print("No internet connection available.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred while saving Blog details: $e");
      }
    } finally {
      isLoading(false);
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

  Future<void> toggleLike(int blogId, context) async {
    bool isLiked = likedStatusMap[blogId] ?? false;
    isLiked = !isLiked;
    likedStatusMap[blogId] = isLiked;
    likeCountMap.update(blogId, (value) => isLiked ? value + 1 : value - 1,
        ifAbsent: () => isLiked ? 1 : 0);

    await likedBlogUser(blogId, context);
  }

  Future<void> toggleBookMark(int blogId) async {
    bool isBookmark = bookmarkStatusMap[blogId] ?? false;
    isBookmark = !isBookmark;
    bookmarkStatusMap[blogId] = isBookmark;
    bookmarkCountMap.update(
        blogId, (value) => isBookmark ? value + 1 : value - 1,
        ifAbsent: () => isBookmark ? 1 : 0);

    await blogBookmark(blogId);
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
