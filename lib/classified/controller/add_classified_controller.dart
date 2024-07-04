import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/add_comment_entity.dart';
import 'package:mlmdiary/generated/bookmark_user_entity.dart';
import 'package:mlmdiary/generated/classified_count_view_entity.dart';
import 'package:mlmdiary/generated/classified_like_list_entity.dart';
import 'package:mlmdiary/generated/edit_comment_entity.dart';
import 'package:mlmdiary/generated/get_category_entity.dart';
import 'package:mlmdiary/generated/get_classified_detail_entity.dart';
import 'package:mlmdiary/generated/get_classified_entity.dart';
import 'package:mlmdiary/generated/get_comment_classified_entity.dart';
import 'package:mlmdiary/generated/get_company_entity.dart';
import 'package:mlmdiary/generated/get_sub_category_entity.dart';
import 'package:mlmdiary/generated/liked_user_entity.dart';
import 'package:http/http.dart' as http;
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClasifiedController extends GetxController {
  RxList<TextEditingController> companyControllers =
      <TextEditingController>[].obs;
  Rx<TextEditingController> title = TextEditingController().obs;
  Rx<TextEditingController> discription = TextEditingController().obs;
  Rx<TextEditingController> url = TextEditingController().obs;
  Rx<TextEditingController> location = TextEditingController().obs;
  Rx<TextEditingController> companyName = TextEditingController().obs;
  Rx<Color> addressValidationColor = Colors.black45.obs;
  Rx<TextEditingController> city = TextEditingController().obs;
  Rx<TextEditingController> state = TextEditingController().obs;
  Rx<TextEditingController> lat = TextEditingController().obs;
  Rx<TextEditingController> lng = TextEditingController().obs;

  Rx<TextEditingController> pincode = TextEditingController().obs;
  Rx<TextEditingController> country = TextEditingController().obs;
  RxList<GetClassifiedData> classifiedList = <GetClassifiedData>[].obs;
  Rx<TextEditingController> commment = TextEditingController().obs;
  TextEditingController searchController = TextEditingController();

  RxList<GetClassifiedDetailData> classifiedDetailList =
      <GetClassifiedDetailData>[].obs;

  final search = TextEditingController();
// company
  RxList<String> companyNames = <String>[].obs;
  RxList<bool> isCompanySelectedList = <bool>[].obs;

  //category
  RxList<GetCategoryCategory> categorylist = RxList<GetCategoryCategory>();
  final RxList<bool> isCategorySelectedList = RxList<bool>([]);
  //subcategory
  RxList<GetSubCategoryCategory> subcategoryList =
      RxList<GetSubCategoryCategory>();
  final RxList<bool> isSubCategorySelectedList = RxList<bool>([]);
//like
  var likedStatusMap = <int, bool>{};
  var likeCountMap = <int, int>{};

//bookmark
  var bookmarkStatusMap = <int, bool>{};
  var bookmarkCountMap = <int, int>{};

  var isLoading = false.obs;

  //scrollercontroller
  final ScrollController scrollController = ScrollController();

  RxList<GetCommentClassifiedData> getCommentList =
      <GetCommentClassifiedData>[].obs;

// FIELDS ERROR

  RxBool titleError = false.obs;
  RxBool discriptionError = false.obs;
  RxBool urlError = false.obs;
  RxBool locationError = false.obs;
  RxBool categoryError = false.obs;
  RxBool subCategoryError = false.obs;
  RxBool companyError = false.obs;
  RxBool planTypeError = false.obs;

  // ENABLED TYPING VALIDATION
  RxBool isTitleTyping = false.obs;
  RxBool isDiscriptionTyping = false.obs;
  RxBool isCompanyNameTyping = false.obs;

  RxBool isUrlTyping = false.obs;
  RxBool isLocationTyping = false.obs;
  RxBool companyNameOnly = false.obs;

  RxInt selectedCountCategory = 0.obs;
  RxInt selectedCountCompany = 0.obs;
  RxInt selectedCountPlan = 0.obs;
  RxInt selectedCountSubCategory = 0.obs;

  // READ ONLY FIELDS
  RxBool titleReadOnly = false.obs;

  int page = 1;
  var isEndOfData = false.obs;

  RxList<ClassifiedLikeListData> classifiedLikeList =
      RxList<ClassifiedLikeListData>();

  final List<String> types = [
    'blog',
    'news',
    'classified',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchCategoryList();
    getClassified(1);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isEndOfData.value) {
        int nextPage = (classifiedList.length ~/ 10) + 1;
        getClassified(
          nextPage,
        );
      }
    });
  }

  void resetSelections() {
    // Reset category and subcategory selections
    for (int i = 0; i < isCategorySelectedList.length; i++) {
      isCategorySelectedList[i] = false;
    }
    for (int i = 0; i < isSubCategorySelectedList.length; i++) {
      isSubCategorySelectedList[i] = false;
    }
    getClassified(1);
  }

  Future<void> fetchClassifiedDetail(int classfiedId, context) async {
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
        'classified_id': classfiedId.toString(),
      };

      if (kDebugMode) {
        print('api_token: $apiToken');
        print('device: $device');
        print('classfiedId: $classfiedId');
      }

      Uri uri = Uri.parse(Constants.baseUrl + Constants.classifieddetail)
          .replace(queryParameters: queryParams);

      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(json.encode(responseData));
        } // Print entire response data

        final GetClassifiedDetailEntity classifiedDetailEntity =
            GetClassifiedDetailEntity.fromJson(responseData);

        final GetClassifiedDetailData? firstPost = classifiedDetailEntity.data;
        if (firstPost != null) {
          // Add the fetched post to the list
          classifiedDetailList.add(firstPost);
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
              fetchSubCategoryList(
                categorylist[0].id!,
              );
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

  void toggleCategorySelected(int index, context) {
    // Deselect all categories first
    for (int i = 0; i < isCategorySelectedList.length; i++) {
      isCategorySelectedList[i] = false;
    }

    // Select the current category
    isCategorySelectedList[index] = true;

    // Update the selected count
    selectedCountCategory.value = 1;

    // Fetch subcategory list for the selected category
    fetchSubCategoryList(
      categorylist[index].id!,
    );
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

  void toggleSubCategorySelected(int index) {
    bool isCurrentlySelected = isSubCategorySelectedList[index];

    // Unselect all sub-categories first
    for (int i = 0; i < isSubCategorySelectedList.length; i++) {
      isSubCategorySelectedList[i] = false;
    }

    // Toggle the selected state of the current sub-category
    isSubCategorySelectedList[index] = !isCurrentlySelected;

    // Update the selected count
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

  Future<void> getClassified(
    int page,
  ) async {
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
        var uri = Uri.parse('${Constants.baseUrl}${Constants.getclassified}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['page'] = page.toString();
        request.fields['search'] = search.value.text;
        request.fields['category'] =
            getSelectedCategoryTextController().text.toString();
        request.fields['subcategory'] =
            getSelectedSubCategoryTextController().text.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var getClassifiedEntity = GetClassifiedEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $getClassifiedEntity');
          }

          if (getClassifiedEntity.data != null &&
              getClassifiedEntity.data!.isNotEmpty) {
            if (page == 1) {
              classifiedList.value = getClassifiedEntity.data!;
            } else {
              classifiedList.addAll(getClassifiedEntity.data!);
            }
            isEndOfData(false);
          } else {
            if (page == 1) {
              classifiedList.clear();
            }
            isEndOfData(true);
          }
        } else {
          if (kDebugMode) {
            print("Response body: ${response.body}");
          }
        }
      } else {
        //
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isLoading(false);
    }
  }

  //like
  Future<void> likedUser(int classifiedId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.likeduserclassified}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['classified_id'] = classifiedId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var likedUserEntity = LikedUserEntity.fromJson(data);
          var message = likedUserEntity.message;

          // Update the liked status and like count based on the message
          if (message == 'You have liked this classified') {
            likedStatusMap[classifiedId] = true;
            likeCountMap[classifiedId] = (likeCountMap[classifiedId] ?? 0) + 1;
          } else if (message == 'You have unliked this classified') {
            likedStatusMap[classifiedId] = false;
            likeCountMap[classifiedId] = (likeCountMap[classifiedId] ?? 0) - 1;
          }

          showToastverifedborder(message!, context);
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

  // Bookmark
  Future<void> bookmarkUser(int classifiedId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.bookmarkclassified}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['classified_id'] = classifiedId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var bookmarkUserEntity = BookmarkUserEntity.fromJson(data);
          var message = bookmarkUserEntity.message;

          // Update the liked status and like count based on the message
          if (message == 'You have bookmark this classified') {
            bookmarkStatusMap[classifiedId] = true;
            bookmarkCountMap[classifiedId] =
                (bookmarkCountMap[classifiedId] ?? 0) + 1;
          } else if (message == 'You have unbookmark this classified') {
            bookmarkStatusMap[classifiedId] = false;
            bookmarkCountMap[classifiedId] =
                (bookmarkCountMap[classifiedId] ?? 0) - 1;
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

  void companyNameValidation() async {
    String enteredcompanyName = companyName.value.text;
    if (enteredcompanyName.isEmpty ||
        hasSpecialCharactersOrNumbers(enteredcompanyName)) {
      companyError.value = true;
    } else {
      companyError.value = false;
    }
  }

  Future<void> addClassifiedDetails({required File? imageFile, context}) async {
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
        // Create a multipart request
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${Constants.baseUrl}${Constants.saveclassified}'),
        );

        // Add fields
        request.fields['device'] = device;
        request.fields['company'] = companyName.value.text;
        request.fields['title'] = title.value.text;
        request.fields['description'] = discription.value.text;
        request.fields['category'] = getSelectedCategoryTextController().text;
        request.fields['subcategory'] =
            getSelectedSubCategoryTextController().text;
        request.fields['location'] = location.value.text;
        request.fields['city'] = city.value.text;
        request.fields['state'] = state.value.text;
        request.fields['pincode'] = '382350';
        request.fields['lat'] = lat.value.text;
        request.fields['lng'] = lng.value.text;
        request.fields['country'] = country.value.text;
        request.fields['companys'] = companyName.value.text;
        request.fields['website'] = url.value.text;
        request.fields['api_token'] = apiToken ?? '';

        // Add image file if provided, or dummy image if not
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
          // Provide a dummy image or placeholder
          request.files.add(
            http.MultipartFile.fromString(
              'image',
              'dummy_image.jpg',
              filename: 'dummy_image.jpg',
              contentType: MediaType('image', 'jpg'),
            ),
          );
        }

        // Send request
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Response body: $jsonBody");
            clearFormFields();
            Get.back();
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to save company details. Status code: ${response.statusCode}");
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
    }
  }

  void clearFormFields() {
    companyName.value.clear();
    title.value.clear();
    discription.value.clear();
    location.value.clear();
    city.value.clear();
    state.value.clear();
    country.value.clear();
    url.value.clear();
  }

  // Fetch company names
  Future<void> fetchCompanyNames(String query) async {
    isLoading.value = true;
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        final uri = Uri.parse('${Constants.baseUrl}${Constants.getcompany}')
            .replace(queryParameters: {'name': query});
        final response = await http.get(uri);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          final getCompanyEntity = GetCompanyEntity.fromJson(jsonBody);

          if (getCompanyEntity.result == 1) {
            companyNames.assignAll(getCompanyEntity.data ?? []);
            isCompanySelectedList
                .assignAll(List.filled(companyNames.length, false));
          } else {
            companyNames.clear();
            isCompanySelectedList.clear();
          }
        } else {
          companyNames.clear();
          isCompanySelectedList.clear();
        }
      } else {
        companyNames.clear();
        isCompanySelectedList.clear();
      }
    } catch (e) {
      companyNames.clear();
      isCompanySelectedList.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void toggleCompanySelected(int index) {
    isCompanySelectedList[index] = !isCompanySelectedList[index];
    if (isCompanySelectedList[index]) {
      selectedCountCompany++;
    } else {
      selectedCountCompany.value--;
    }
  }

// like_list_classified
  Future<void> fetchLikeListClassified(int classifiedId, context) async {
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
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.likelistclassified}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['classified_id'] = classifiedId.toString();

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
            var classifiedLikeListEntity =
                ClassifiedLikeListEntity.fromJson(data);
            classifiedLikeList.value = classifiedLikeListEntity.data ?? [];

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

  void validateAddress() {
    if (location.value.text.isEmpty) {
      addressValidationColor.value = Colors.red;
    } else {
      addressValidationColor.value = Colors.green;
    }
  }

  Future<void> countViewClassified(int classifiedId, context) async {
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
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.countviewclassified}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['classified_id'] = classifiedId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var countViewClassifiedEntity =
              ClassifiedCountViewEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $countViewClassifiedEntity');
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

  Future<void> getCommentClassified(int page, int classifiedId, context) async {
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
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.getcommentclassified}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['page'] = page.toString();
        request.fields['classified_id'] = classifiedId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var getCommentClassifiedEntity =
              GetCommentClassifiedEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $getCommentClassifiedEntity');
          }

          if (getCommentClassifiedEntity.data != null &&
              getCommentClassifiedEntity.data!.isNotEmpty) {
            if (page == 1) {
              getCommentList.value = getCommentClassifiedEntity.data!;
            } else {
              getCommentList.addAll(getCommentClassifiedEntity.data!);
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

  Future<void> addReplyComment(int classifiedId, int commentId, context) async {
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
        var uri = Uri.parse('${Constants.baseUrl}${Constants.addcommentreply}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['classified_id'] = classifiedId.toString();
        request.fields['comment_id'] = commentId.toString();
        request.fields['comment'] = commment.value.text;

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var addCommentEntity = AddCommentEntity.fromJson(data);
          getCommentClassified(1, classifiedId, context);

          if (kDebugMode) {
            print('Success: $addCommentEntity');
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

  Future<void> deleteComment(int classifiedId, int commentId, context) async {
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
        request.fields['type'] = 'classified';
        request.fields['comment_id'] = commentId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          jsonDecode(response.body);
          // Handle success response as needed
          await getCommentClassified(1, classifiedId, context);
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

  Future<void> editComment(int classifiedId, int commentId, String newComment,
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
          await getCommentClassified(1, classifiedId, context);

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

  Future<void> toggleLike(int classifiedId, context) async {
    bool isLiked = likedStatusMap[classifiedId] ?? false;
    isLiked = !isLiked;
    likedStatusMap[classifiedId] = isLiked;
    likeCountMap.update(
        classifiedId, (value) => isLiked ? value + 1 : value - 1,
        ifAbsent: () => isLiked ? 1 : 0);

    await likedUser(classifiedId, context);
  }

  Future<void> toggleBookMark(int classifiedId, context) async {
    bool isBookmark = bookmarkStatusMap[classifiedId] ?? false;
    isBookmark = !isBookmark;
    bookmarkStatusMap[classifiedId] = isBookmark;
    bookmarkCountMap.update(
        classifiedId, (value) => isBookmark ? value + 1 : value - 1,
        ifAbsent: () => isBookmark ? 1 : 0);

    await bookmarkUser(classifiedId, context);
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

  void locationValidation() {
    String enteredLocation = location.value.text;
    if (enteredLocation.isEmpty || hasSpecialTextOrNumbers(enteredLocation)) {
      locationError.value = true;
    } else {
      locationError.value = false;
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
