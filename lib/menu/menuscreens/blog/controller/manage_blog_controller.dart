import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/add_comment_blog_entity.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/blog_bookmark_entity.dart';
import 'package:mlmdiary/generated/blog_count_view_entity.dart';
import 'package:mlmdiary/generated/blog_like_list_entity.dart';
import 'package:mlmdiary/generated/edit_comment_entity.dart';
import 'package:mlmdiary/generated/get_blog_comment_entity.dart';
import 'package:mlmdiary/generated/get_blog_detail_entity.dart';
import 'package:mlmdiary/generated/get_blog_list_entity.dart';

import 'package:mlmdiary/generated/get_category_entity.dart';
import 'package:mlmdiary/generated/get_sub_category_entity.dart';
import 'package:mlmdiary/generated/l_iked_blog_entity.dart';
import 'package:mlmdiary/generated/manage_blog_list_entity.dart';
import 'package:mlmdiary/generated/my_blog_list_entity.dart';
import 'package:mlmdiary/generated/views_blog_list_entity.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

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

  List<String> selectedCategoryNames = [];

  RxList<MyBlogListData> myBlogList = <MyBlogListData>[].obs;
  RxList<GetBlogListData> blogList = RxList<GetBlogListData>();
  RxList<GetBlogDetailData> blogDetailList = <GetBlogDetailData>[].obs;
  RxList<ManageBlogListData> manageBlogList = <ManageBlogListData>[].obs;

  RxList<BlogLikeListData> blogLikeList = RxList<BlogLikeListData>();
  RxList<ViewsBlogListData> blogViewList = RxList<ViewsBlogListData>();

  //like
  RxMap<int, bool> likedStatusMap = <int, bool>{}.obs;
  RxMap<int, int> likeCountMap = <int, int>{}.obs;

//bookmark
  var bookmarkStatusMap = <int, bool>{};
  var bookmarkCountMap = <int, int>{};

  RxString userImage = ''.obs;

  // news blog
  RxList<GetBlogCommentData> getCommentList = <GetBlogCommentData>[].obs;
  Rx<TextEditingController> commment = TextEditingController().obs;

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

  var isEndOfBlogLikeListData = false.obs;
  var isEndOfBlogViewListData = false.obs;

  var replyCommentId = 0.obs;
  final editingCommentId = 0.obs;

  RxString hintText = "Write your answer here".obs;

  //scrollercontroller
  final ScrollController scrollController = ScrollController();

  var isEndOfData = false.obs;
  final search = TextEditingController();

  var selectedCategoryId = 0.obs;
  var selectedSubCategoryId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryList();
    getBlog(1);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isEndOfData.value) {
        int nextPage = (blogList.length ~/ 10) + 1;
        getBlog(nextPage);
      }
    });
  }

  void resetSelections() {
    // Reset category and subcategory selections
    selectedCategoryId.value = 0;
    selectedSubCategoryId.value = 0;
    getBlog(1);
  }

  Future<void> getBlog(int page, {int? blogid}) async {
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
        var uri = Uri.parse('${Constants.baseUrl}${Constants.getblog}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['page'] = page.toString();
        request.fields['search'] = search.value.text;
        request.fields['category'] = selectedCategoryId.value.toString();
        request.fields['subcategory'] = selectedSubCategoryId.value.toString();
        request.fields['blog_id'] = blogid?.toString() ?? '';

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var getBlogEntity = GetBlogListEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $getBlogEntity');
          }

          if (getBlogEntity.data != null && getBlogEntity.data!.isNotEmpty) {
            if (page == 1) {
              if (blogid == null) {
                blogList.value = getBlogEntity.data!;
              } else {
                blogList.value = [getBlogEntity.data!.first];
              }
            } else {
              if (blogid == null) {
                blogList.addAll(getBlogEntity.data!);
              } else {
                if (getBlogEntity.data!.isNotEmpty) {
                  blogList.add(getBlogEntity.data!.first);
                }
              }
            }
            isEndOfData(false);
          } else {
            if (page == 1) {
              blogList.clear();
            }
            isEndOfData(true);
          }
        } else {
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      } else {
        //
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchBlogDetail(int blogId, context) async {
    title.value.text = "";
    discription.value.text = "";
    url.value.text = "";
    userImage.value = "";

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
        'blog_id': blogId.toString(),
      };

      if (kDebugMode) {
        print('api_token: $apiToken');
        print('device: $device');
        print('blogId: $blogId');
      }

      Uri uri = Uri.parse(Constants.baseUrl + Constants.blogdetail)
          .replace(queryParameters: queryParams);

      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(json.encode(responseData));
        }

        final GetBlogDetailEntity blogDetailEntity =
            GetBlogDetailEntity.fromJson(responseData);

        final GetBlogDetailData firstPost = blogDetailEntity.data!;
        title.value.text = firstPost.title.toString();
        discription.value.text = firstPost.description!;
        url.value.text = firstPost.website!;
        userImage.value = firstPost.imagePath!;

        int? categoryId = int.tryParse(firstPost.category!);

        if (categoryId != null) {
          if (kDebugMode) {
            print('Category ID selected: $categoryId');
          }

          isCategorySelectedList.fillRange(
              0, isCategorySelectedList.length, false);
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
        int? subcategoryId = int.tryParse(firstPost.subcategory!);

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

  Future<void> fetchBlogDetailforManagePlusBlog(int blogId, context) async {
    title.value.text = "";
    discription.value.text = "";
    url.value.text = "";
    userImage.value = "";

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
        'blog_id': blogId.toString(),
      };

      if (kDebugMode) {
        print('api_token: $apiToken');
        print('device: $device');
        print('blogId: $blogId');
      }

      Uri uri = Uri.parse(Constants.baseUrl + Constants.blogdetail)
          .replace(queryParameters: queryParams);

      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(json.encode(responseData));
        }

        final GetBlogDetailEntity blogDetailEntity =
            GetBlogDetailEntity.fromJson(responseData);

        final GetBlogDetailData firstPost = blogDetailEntity.data!;
        title.value.text = firstPost.title.toString();
        discription.value.text = firstPost.description!;
        url.value.text = firstPost.website!;
        userImage.value = firstPost.imagePath!;

        int? categoryId = int.tryParse(firstPost.category!);

        if (categoryId != null) {
          if (kDebugMode) {
            print('Category ID selected: $categoryId');
          }

          isCategorySelectedList.fillRange(
              0, isCategorySelectedList.length, false);
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
        int? subcategoryId = int.tryParse(firstPost.subcategory!);

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

  Future<void> fetchMyBlog({int page = 1, context}) async {
    isLoading.value = true;

    String device = Platform.isAndroid ? 'android' : 'ios';

    if (kDebugMode) {
      print('Device Name: $device');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        showToasterrorborder("No internet connection", context);
        isLoading.value = false;
        return;
      }

      Map<String, String> queryParams = {
        'api_token': apiToken ?? '',
        'device': device,
        'page': page.toString(),
      };

      if (kDebugMode) {
        print('api_token: $apiToken');
        print('device: $device');
        print('page: $page');
      }

      Uri uri = Uri.parse(Constants.baseUrl + Constants.myblog)
          .replace(queryParameters: queryParams);

      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(json.encode(responseData));
        }
        final ManageBlogListEntity manageBlogListEntity =
            ManageBlogListEntity.fromJson(responseData);

        if (kDebugMode) {
          print('Manage Blog data: $responseData');
        }

        if (page == 1) {
          manageBlogList.assignAll(manageBlogListEntity.data!);
        } else {
          manageBlogList.addAll(manageBlogListEntity.data!);
        }
      } else {
        if (context != null) {
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      }
    } catch (error) {
      if (context != null) {
        if (kDebugMode) {
          print("Error: $error");
        }
      }
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
            if (kDebugMode) {
              print("Error: ${response.body}");
            }
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

  Future<void> fetchSubCategoryList(
    int categoryId,
  ) async {
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

  void toggleCategorySelected(int index, BuildContext context) {
    if (!isCategorySelectedList[index]) {
      for (int i = 0; i < isCategorySelectedList.length; i++) {
        isCategorySelectedList[i] = false;
      }

      isCategorySelectedList[index] = true;

      selectedCountCategory.value = 1;
      selectedCategoryId.value = categorylist[index].id!;

      fetchSubCategoryList(categorylist[index].id!);
    } else {}
  }

  TextEditingController getSelectedCategoryTextController() {
    selectedCategoryNames.clear();
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
  }

  void toggleSubCategorySelected(int index) {
    if (index >= 0 && index < isSubCategorySelectedList.length) {
      bool isCurrentlySelected = isSubCategorySelectedList[index];

      for (int i = 0; i < isSubCategorySelectedList.length; i++) {
        isSubCategorySelectedList[i] = false;
      }

      isSubCategorySelectedList[index] = !isCurrentlySelected;
      selectedCountSubCategory.value = isSubCategorySelectedList[index] ? 1 : 0;
      selectedSubCategoryId.value = subcategoryList[index].id!;
    } else {
      if (kDebugMode) {
        print("Invalid subcategory index: $index");
      }
    }
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
  }

  Future<void> deleteBlog(int blogId, int index, context) async {
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
            showToastverifedborder(message!, context);
            myBlogList.removeAt(index);
          } else {
            if (kDebugMode) {
              print('Failed to delete blog: $message');
            }
          }

          if (kDebugMode) {
            print('data from delete blog: $data');
          }
        } else {
          if (kDebugMode) {
            print('Error: ${response.body}');
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
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
            likeCountMap[blogId] = (likeCountMap[blogId] ?? 0);
          } else if (message == 'You have unliked this Blog') {
            likedStatusMap[blogId] = false;
            likeCountMap[blogId] = (likeCountMap[blogId] ?? 0);
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

  // Bookmark
  Future<void> blogBookmark(int blogId, context) async {
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
        request.fields['blog_id'] = blogId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var bookmarkUserEntity = BlogBookmarkEntity.fromJson(data);
          var message = bookmarkUserEntity.message;

          // Update the liked status and like count based on the message
          if (message == 'You have bookmark this Blog') {
            bookmarkStatusMap[blogId] = true;
            bookmarkCountMap[blogId] = (bookmarkCountMap[blogId] ?? 0) + 1;
          } else if (message == 'You have unbookmark this Blog') {
            bookmarkStatusMap[blogId] = false;
            bookmarkCountMap[blogId] = (bookmarkCountMap[blogId] ?? 0) - 1;
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

  Future<void> updateBlog(File? imageFile, int blogId, context) async {
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
          Uri.parse('${Constants.baseUrl}${Constants.updateblog}'),
        );

        request.fields['device'] = device;
        request.fields['title'] = title.value.text;
        request.fields['description'] = discription.value.text;
        request.fields['category'] = selectedCategoryId.value.toString();
        request.fields['subcategory'] = selectedSubCategoryId.value.toString();
        request.fields['website'] = url.value.text;
        request.fields['api_token'] = apiToken ?? '';
        request.fields['blog_id'] = blogId.toString();

        if (kDebugMode) {
          print('Blog id  $blogId');
        }

        if (imageFile != null) {
          if (kDebugMode) {
            print('Attaching new image file: ${imageFile.path}');
          }
          request.files.add(
            http.MultipartFile(
              'image',
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
              title: const Text('Blog Updated Successfully'),
            );
            Get.back();
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
                "HTTP error: Failed to Update Blog details. Status code: ${response.statusCode}");
            print("Response body: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred while saving Blog details: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> countViewBlog(int blogId, context) async {
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
        var uri = Uri.parse('${Constants.baseUrl}${Constants.countviewblog}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['blog_id'] = blogId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var countViewBlogEntity = BlogCountViewEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $countViewBlogEntity');
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

  // like_list_blog
  Future<void> fetchLikeListBlog(int blogId, int page, context) async {
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
        var uri = Uri.parse('${Constants.baseUrl}${Constants.likelistblog}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['blog_id'] = blogId.toString();
        request.fields['page'] = page.toString();

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

          // Log response body
          if (kDebugMode) {
            print('Response body: ${response.body}');
          }

          var blogLikeListEntity = BlogLikeListEntity.fromJson(data);

          if (blogLikeListEntity.data != null &&
              blogLikeListEntity.data!.isNotEmpty) {
            if (page == 1) {
              blogLikeList.clear();
              blogLikeList.value = blogLikeListEntity.data!;
            } else {
              blogLikeList.addAll(blogLikeListEntity.data!);
            }
          } else {
            if (page == 1) {
              blogLikeList.clear();
            }
            isEndOfBlogLikeListData(true);
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
        print('Finished fetchLikeListBlog method');
      }
    }
  }

  // like_list_blog
  Future<void> fetchViewListBlog(int blogId, int page, context) async {
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
        var uri = Uri.parse('${Constants.baseUrl}${Constants.viewlistblog}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['blog_id'] = blogId.toString();
        request.fields['page'] = page.toString();

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

          if (kDebugMode) {
            print('Response body: ${response.body}');
          }

          var blogViewsListEntity = ViewsBlogListEntity.fromJson(data);
          blogViewList.value = blogViewsListEntity.data ?? [];

          if (blogViewsListEntity.data != null &&
              blogViewsListEntity.data!.isNotEmpty) {
            if (page == 1) {
              blogViewList.value = blogViewsListEntity.data!;
            } else {
              blogViewList.addAll(blogViewsListEntity.data!);
            }
          } else {
            if (page == 1) {
              blogViewList.clear();
            }
            isEndOfBlogViewListData(true);
          }
        } else {
          if (kDebugMode) {
            print('Error: ${response.body}');
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isLoading(false);
      if (kDebugMode) {
        print('Finished blogViewList method');
      }
    }
  }

  // comment for news
  Future<void> getCommentBlog(int page, int blogId, context) async {
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
        var uri = Uri.parse('${Constants.baseUrl}${Constants.getcommentblog}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['page'] = page.toString();
        request.fields['blog_id'] = blogId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var getCommentBlogEntity = GetBlogCommentEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $getCommentBlogEntity');
          }

          if (getCommentBlogEntity.data != null &&
              getCommentBlogEntity.data!.isNotEmpty) {
            if (page == 1) {
              getCommentList.value = getCommentBlogEntity.data!;
            } else {
              getCommentList.addAll(getCommentBlogEntity.data!);
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

  Future<void> addReplyBlogComment(int blodId, int commentId, context) async {
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
            Uri.parse('${Constants.baseUrl}${Constants.addcommentblogreply}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['blog_id'] = blodId.toString();
        request.fields['comment_id'] = commentId.toString();
        request.fields['comment'] = commment.value.text;

        if (kDebugMode) {
          print('addReplyBlogComment: ${request.fields}');
        }

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var addCommentBlogEntity = AddCommentBlogEntity.fromJson(data);
          // Check if the status is 0 and show a toast message
          if (data['status'] == 0) {
            showToasterrorborder(data['message'], context);
          } else {
            getCommentBlog(1, blodId, context);
            if (kDebugMode) {
              print('Success: $addCommentBlogEntity');
            }
          }

          if (kDebugMode) {
            print('Success: $addCommentBlogEntity');
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

  Future<void> deleteComment(int blogId, int commentId, context) async {
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
        request.fields['type'] = 'blog';
        request.fields['comment_id'] = commentId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          jsonDecode(response.body);
          // Handle success response as needed
          await getCommentBlog(1, blogId, context);
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

  Future<void> editComment(int blogId, int commentId, String newComment,
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

        if (kDebugMode) {
          print('editComment: ${request.fields}');
        }

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var editCommentEntity = EditCommentEntity.fromJson(data);
          await getCommentBlog(1, blogId, context);

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

  Future<void> toggleBookMark(int blogId, context) async {
    bool isBookmark = bookmarkStatusMap[blogId] ?? false;
    isBookmark = !isBookmark;
    bookmarkStatusMap[blogId] = isBookmark;
    bookmarkCountMap.update(
        blogId, (value) => isBookmark ? value + 1 : value - 1,
        ifAbsent: () => isBookmark ? 1 : 0);

    await blogBookmark(blogId, context);
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
