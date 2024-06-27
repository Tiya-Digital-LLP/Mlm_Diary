import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/bookmark_user_entity.dart';
import 'package:mlmdiary/generated/boost_on_top_classified_entity.dart';
import 'package:mlmdiary/generated/boost_on_top_classified_premium_entity.dart';
import 'package:mlmdiary/generated/classified_count_view_entity.dart';
import 'package:mlmdiary/generated/get_category_entity.dart';
import 'package:mlmdiary/generated/get_classified_entity.dart';
import 'package:mlmdiary/generated/get_company_entity.dart';
import 'package:mlmdiary/generated/get_sub_category_entity.dart';
import 'package:mlmdiary/generated/liked_user_entity.dart';
import 'package:mlmdiary/generated/manage_classified_entity.dart';
import 'package:mlmdiary/utils/common_toast.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageClasifiedController extends GetxController {
  Rx<TextEditingController> title = TextEditingController().obs;
  Rx<TextEditingController> discription = TextEditingController().obs;
  Rx<TextEditingController> url = TextEditingController().obs;

  //locartion
  Rx<Color> addressValidationColor = Colors.black45.obs;
  Rx<TextEditingController> location = TextEditingController().obs;
  Rx<TextEditingController> city = TextEditingController().obs;
  Rx<TextEditingController> state = TextEditingController().obs;
  Rx<TextEditingController> pincode = TextEditingController().obs;
  Rx<TextEditingController> country = TextEditingController().obs;
  Rx<TextEditingController> lat = TextEditingController().obs;
  Rx<TextEditingController> lng = TextEditingController().obs;

  // API data
  RxList<ManageClassifiedData> classifiedList = <ManageClassifiedData>[].obs;
  RxBool isLoading = false.obs;
  var isLiked = false.obs;
  var isBookMarked = false.obs;

  //company
  RxBool companyNameOnly = false.obs;
  Rx<TextEditingController> companyName = TextEditingController().obs;
  RxList<String> companyNames = <String>[].obs;

  //category
  RxList<GetCategoryCategory> categorylist = RxList<GetCategoryCategory>();
  final RxList<bool> isCategorySelectedList = RxList<bool>([]);

  //subcategory
  RxList<GetSubCategoryCategory> subcategoryList =
      RxList<GetSubCategoryCategory>();
  final RxList<bool> isSubCategorySelectedList = RxList<bool>([]);

  //image
  RxString userImage = ''.obs;

  //like
  var likedStatusMap = <int, bool>{};
  var likeCountMap = <int, int>{};

  //bookmark
  var bookmarkStatusMap = <int, bool>{};
  var bookmarkCountMap = <int, int>{};

// FIELDS ERROR

  RxBool titleError = false.obs;
  RxBool discriptionError = false.obs;
  RxBool urlError = false.obs;
  RxBool categoryError = false.obs;
  RxBool subCategoryError = false.obs;
  RxBool companyError = false.obs;
  RxBool planTypeError = false.obs;

  // ENABLED TYPING VALIDATION
  RxBool isTitleTyping = false.obs;
  RxBool isDiscriptionTyping = false.obs;
  RxBool isUrlTyping = false.obs;
  RxBool isLocationTyping = false.obs;
  RxBool isCompanyNameTyping = false.obs;
  RxInt selectedCountCategory = 0.obs;
  RxInt selectedCountCompany = 0.obs;
  RxInt selectedCountPlan = 0.obs;
  RxInt selectedCountSubCategory = 0.obs;

  // READ ONLY FIELDS
  RxBool titleReadOnly = false.obs;

  var classifiedData = GetClassifiedEntity().obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryList();
    getClassified();
  }

  Future<void> getClassified() async {
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

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (kDebugMode) {
            print("API Response Data: $data");
          }
          var getClassifiedEntity = GetClassifiedEntity.fromJson(data);

          // Extract the ID from the fetchClassifieds response
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? lastClassifiedId = prefs.getString('lastClassifiedId');

          // Find the classified with matching ID
          var classified = getClassifiedEntity.data?.firstWhere(
            (classified) => classified.id.toString() == lastClassifiedId,
            orElse: () => GetClassifiedData(),
          );

          if (classified != null) {
            title.value.text = classified.title ?? '';
            companyName.value.text = classified.company ?? '';
            discription.value.text = classified.description ?? '';
            url.value.text = classified.website ?? '';
            userImage.value = classified.imagePath ?? '';
            city.value.text = classified.city ?? '';
            state.value.text = classified.state ?? '';
            country.value.text = classified.country ?? '';

            // Update Category List
            isCategorySelectedList.clear();
            for (var category in categorylist) {
              bool isSelected = classified.category == (category.name ?? '');
              isCategorySelectedList.add(isSelected);
            }

            // Update SubCategory List
            isSubCategorySelectedList.clear();
            for (var subcategory in subcategoryList) {
              bool isSelected =
                  classified.subcategory == (subcategory.name ?? '');
              isSubCategorySelectedList.add(isSelected);
            }

            if (kDebugMode) {
              print('Success: $getClassifiedEntity');
            }
          } else {
            if (kDebugMode) {
              print(
                  "No classified found matching the ID from fetchClassifieds");
            }
          }
        } else {
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      } else {
        showToasterrorborder(
          "No internet connection",
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  String _formatLocation(String city, String state, String country) {
    final parts =
        [city, state, country].where((part) => part.isNotEmpty).toList();
    return parts.join(', ');
  }

  // Method to fetch data from API
  Future<void> fetchClassifieds({int page = 1, context}) async {
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
        showToasterrorborder(
          "No internet connection",
        );
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
      Uri uri = Uri.parse(Constants.baseUrl + Constants.manageclassified)
          .replace(queryParameters: queryParams);

      // Make HTTP GET request
      final response = await http.post(uri);

      if (response.statusCode == 200) {
        // Parse JSON data
        final Map<String, dynamic> responseData = json.decode(response.body);
        final ManageClassifiedEntity classifiedEntity =
            ManageClassifiedEntity.fromJson(responseData);

        if (kDebugMode) {
          print('manage classified data: $responseData');
        }
        // Update controllers with fetched data

        // Combine city, state, and country to form location
        location.value.text = _formatLocation(
          city.value.text,
          state.value.text,
          country.value.text,
        );

        // Store ID using SharedPreferences
        final List<ManageClassifiedData> classifiedData =
            classifiedEntity.data!;
        if (classifiedData.isNotEmpty) {
          final String classifiedId = classifiedData[0].id.toString();
          await prefs.setString('lastClassifiedId', classifiedId);
          if (kDebugMode) {
            print('Last Classified ID stored: $classifiedId');
          }
        }

        // Update state with fetched data
        if (page == 1) {
          classifiedList.assignAll(classifiedEntity.data!);
        } else {
          classifiedList.addAll(classifiedEntity.data!);
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
        showToasterrorborder(
          "No internet connection",
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }
    }
  }

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
        showToasterrorborder(
          "No internet connection",
        );
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

  //getcompany
  Future<void> fetchCompanyNames(String query) async {
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
            companyNames.value = getCompanyEntity.data ?? [];
          } else {
            companyNames.clear();
          }
        } else {
          companyNames.clear();
        }
      } else {
        companyNames.clear();
      }
    } catch (e) {
      companyNames.clear();
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

  //updateclassified

  Future<void> updateClassified({
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
    String? classifiedId = prefs.getString('lastClassifiedId');

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${Constants.baseUrl}${Constants.updateclassified}'),
        );

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
        request.fields['company'] = companyName.value.text;
        request.fields['website'] = url.value.text;
        request.fields['api_token'] = apiToken ?? '';
        request.fields['classified_id'] = classifiedId.toString();

        if (kDebugMode) {
          print('classified id ; $classifiedId');
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
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to Update company details. Status code: ${response.statusCode}");
            print("Response body: ${response.body}");
          }
        }
      } else {
        showToasterrorborder(
          "No internet connection",
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred while saving company details: $e");
      }
    }
  }

  void titleValidation() {
    String enteredTitle = title.value.text;
    if (enteredTitle.isEmpty || hasSpecialCharactersOrNumbers(enteredTitle)) {
      // Show toast message for invalid title
      ToastUtils.showToast("Please Enter Title");
      titleError.value = true;
    } else {
      titleError.value = false;
    }
  }

  void validateAddress() {
    if (location.value.text.isEmpty) {
      addressValidationColor.value = Colors.red;
    } else {
      addressValidationColor.value = Colors.green;
    }
  }

  //like
  Future<void> likedUser(int classifiedId) async {
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

  Future<void> toggleLike(int classifiedId) async {
    bool isLiked = likedStatusMap[classifiedId] ?? false;
    isLiked = !isLiked;
    likedStatusMap[classifiedId] = isLiked;
    likeCountMap.update(
        classifiedId, (value) => isLiked ? value + 1 : value - 1,
        ifAbsent: () => isLiked ? 1 : 0);

    await likedUser(classifiedId);
  }

  // Delete-Classified
  Future<void> deleteClassified(int classifiedId, int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    isLoading(true);
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.delteclassified}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['classified_id'] = classifiedId.toString();

        if (kDebugMode) {
          print('classified id from delete classified: $classifiedId');
          print('classified token from delete classified: $apiToken');
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
            // Remove the classified from the list if the deletion was successful
            classifiedList.removeAt(index);
          } else {
            Fluttertoast.showToast(
              msg: "Failed to delete classified: $message",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
            );
            if (kDebugMode) {
              print('Failed to delete classified: $message');
            }
          }

          if (kDebugMode) {
            print('data from delete classified: $data');
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
          Fluttertoast.showToast(
            msg: "Success: $countViewClassifiedEntity",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
        } else {
          //
        }
      } else {
        showToasterrorborder(
          "No internet connection",
        );
      }
    } catch (e) {
      //
    } finally {
      isLoading(false);
    }
  }

  // Bookmark
  Future<void> bookmarkUser(int classifiedId) async {
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

  Future<void> toggleBookMark(int classifiedId) async {
    bool isBookmark = bookmarkStatusMap[classifiedId] ?? false;
    isBookmark = !isBookmark;
    bookmarkStatusMap[classifiedId] = isBookmark;
    bookmarkCountMap.update(
        classifiedId, (value) => isBookmark ? value + 1 : value - 1,
        ifAbsent: () => isBookmark ? 1 : 0);

    await bookmarkUser(classifiedId);
  }

  Future<void> boostOnTopClassified(int classifiedId, context) async {
    isLoading(true);
    if (kDebugMode) {
      print('Loading indicator set: true');
    }

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
      if (kDebugMode) {
        print('Connectivity checked');
      }

      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.boostontopclassified}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['classified_id'] = classifiedId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var boostOnTopClassifiedEntity =
              BoostOnTopClassifiedEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $boostOnTopClassifiedEntity');
          }

          showToastverifedborder(
            "Success: Your Post On Top",
          );
        } else {
          if (kDebugMode) {
            print('HTTP Error: ${response.statusCode}');
          }
        }
      } else {
        showToasterrorborder(
          "No internet connection",
        );
        if (kDebugMode) {
          print('No internet connection');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      // Handle exceptions
    } finally {
      isLoading(false);
      if (kDebugMode) {
        print('Loading indicator set: false');
      }
    }
  }

  Future<bool> boostOnTopClassifiedPremium(
      int classifiedId, BuildContext context) async {
    isLoading(true);
    if (kDebugMode) {
      print('Loading indicator set: true');
    }

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
      if (kDebugMode) {
        print('Connectivity checked');
      }

      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse(
            '${Constants.baseUrl}${Constants.boostontopclassifiedpremium}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['classified_id'] = classifiedId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var boostOnTopClassifiedPremiumEntity =
              BoostOnTopClassifiedPremiumEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $boostOnTopClassifiedPremiumEntity');
          }

          return true; // Indicate success
        } else {
          if (kDebugMode) {
            print('HTTP Error: ${response.statusCode}');
          }
          return false; // Indicate failure
        }
      } else {
        // ignore: use_build_context_synchronously
        showToasterrorborder(
          "No internet connection",
        );
        if (kDebugMode) {
          print('No internet connection');
        }
        return false; // Indicate failure
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      // Handle exceptions
      return false; // Indicate failure
    } finally {
      isLoading(false);
      if (kDebugMode) {
        print('Loading indicator set: false');
      }
    }
  }

  void discriptionValidation() {
    String enteredDiscription = discription.value.text;
    if (enteredDiscription.isEmpty ||
        hasSpecialTextOrNumbers(enteredDiscription)) {
      ToastUtils.showToast("Please Enter Discription");
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
