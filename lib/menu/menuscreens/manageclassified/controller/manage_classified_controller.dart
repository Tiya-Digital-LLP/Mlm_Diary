import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/bookmark_user_entity.dart';
import 'package:mlmdiary/generated/boost_on_top_classified_entity.dart';
import 'package:mlmdiary/generated/boost_on_top_classified_premium_entity.dart';
import 'package:mlmdiary/generated/classified_count_view_entity.dart';
import 'package:mlmdiary/generated/classified_like_list_entity.dart';
import 'package:mlmdiary/generated/classified_view_list_entity.dart';
import 'package:mlmdiary/generated/get_category_entity.dart';
import 'package:mlmdiary/generated/get_classified_detail_entity.dart';
import 'package:mlmdiary/generated/get_classified_entity.dart';
import 'package:mlmdiary/generated/get_company_entity.dart';
import 'package:mlmdiary/generated/get_sub_category_entity.dart';
import 'package:mlmdiary/generated/liked_user_entity.dart';
import 'package:mlmdiary/generated/manage_classified_entity.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

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
  RxList<ClassifiedLikeListData> classifiedLikeList =
      RxList<ClassifiedLikeListData>();
  RxList<ClassifiedViewListData> classifiedViewList =
      RxList<ClassifiedViewListData>();
  RxBool isLoading = false.obs;
  var isLiked = false.obs;
  var isBookMarked = false.obs;

  //company
  RxBool companyNameOnly = false.obs;
  Rx<TextEditingController> companyName = TextEditingController().obs;
  RxList<String> companyNames = <String>[].obs;
  RxList<String> selectedCompanies = <String>[].obs;

  //category
  RxList<GetCategoryCategory> categorylist = RxList<GetCategoryCategory>();
  final RxList<bool> isCategorySelectedList = RxList<bool>([]);

  //subcategory
  RxList<GetSubCategoryCategory> subcategoryList =
      RxList<GetSubCategoryCategory>();
  final RxList<bool> isSubCategorySelectedList = RxList<bool>([]);

  List<String> selectedCategoryNames = [];

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

  var selectedCategoryId = 0.obs;
  var selectedSubCategoryId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryList();
    getClassified();
  }

  // like_list_classified
  Future<void> fetchLikeListClassified(int classifiedId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    isLoading(true);
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
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

        if (kDebugMode) {
          print('Request URL: $uri');
          print('Request fields: ${request.fields}');
        }

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (kDebugMode) {
          print('Response status code: ${response.statusCode}');
        }

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var status = data['status'];

          if (kDebugMode) {
            print('Response body: ${response.body}');
          }

          if (status == 1) {
            var classifiedLikeListEntity =
                ClassifiedLikeListEntity.fromJson(data);
            classifiedLikeList.value = classifiedLikeListEntity.data ?? [];

            if (kDebugMode) {
              print('Parsed entity: $classifiedLikeListEntity');
            }
          } else {
            var message = data['message'];

            if (kDebugMode) {
              print('Failed to fetch likelist classified: $message');
            }
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
        print('Finished fetchLikeListClassified method');
      }
    }
  }

  // View_list_classified
  Future<void> fetchViewListClassified(int classifiedId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    isLoading(true);
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (kDebugMode) {
        print('Connectivity result: $connectivityResult');
      }

      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.viewlistclassified}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['classified_id'] = classifiedId.toString();

        if (kDebugMode) {
          print('Request URL: $uri');
          print('Request fields: ${request.fields}');
        }

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (kDebugMode) {
          print('Response status code: ${response.statusCode}');
        }

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var status = data['status'];

          if (kDebugMode) {
            print('Response body: ${response.body}');
          }

          if (status == 1) {
            var classifiedViewListEntity =
                ClassifiedViewListEntity.fromJson(data);
            classifiedViewList.value = classifiedViewListEntity.data ?? [];

            if (kDebugMode) {
              print('Parsed entity: $classifiedViewListEntity');
            }
          } else {
            var message = data['message'];

            if (kDebugMode) {
              print('Failed to fetch likelist classified: $message');
            }
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
        print('Finished fetchViewListClassified method');
      }
    }
  }

  Future<void> fetchClassifiedDetail(int classfiedId, context) async {
    title.value.text = "";
    companyName.value.text = "";
    discription.value.text = "";
    url.value.text = "";
    userImage.value = "";
    city.value.text = "";
    state.value.text = "";
    country.value.text = "";

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
        }

        final GetClassifiedDetailEntity classifiedDetailEntity =
            GetClassifiedDetailEntity.fromJson(responseData);

        final GetClassifiedDetailData firstPost = classifiedDetailEntity.data!;

        // Update fields with new data
        title.value.text = firstPost.title.toString();
        companyName.value.text = firstPost.company!;
        discription.value.text = firstPost.description!;
        url.value.text = firstPost.website!;
        userImage.value = firstPost.imagePath!;
        city.value.text = firstPost.city!;
        state.value.text = firstPost.state!;
        country.value.text = firstPost.country!;
        location.value.text =
            '${firstPost.city}, ${firstPost.state}, ${firstPost.country}'
                .trim()
                .replaceAll(RegExp(r',\s*$'), '');
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

      Uri uri = Uri.parse(Constants.baseUrl + Constants.manageclassified)
          .replace(queryParameters: queryParams);

      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final ManageClassifiedEntity classifiedEntity =
            ManageClassifiedEntity.fromJson(responseData);

        if (kDebugMode) {
          print('manage classified data: $responseData');
        }

        location.value.text = _formatLocation(
          city.value.text,
          state.value.text,
          country.value.text,
        );

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
    if (index >= 0 && index < isSubCategorySelectedList.length) {
      bool isCurrentlySelected = isSubCategorySelectedList[index];

      // Unselect all subcategories
      for (int i = 0; i < isSubCategorySelectedList.length; i++) {
        isSubCategorySelectedList[i] = false;
      }

      // Toggle the selected state of the current subcategory
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

  Future<void> updateClassified(
      File? imageFile, int classifiedId, context) async {
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
          Uri.parse('${Constants.baseUrl}${Constants.updateclassified}'),
        );

        request.fields['device'] = device;
        request.fields['company'] = companyName.value.text;
        request.fields['title'] = title.value.text;
        request.fields['description'] = discription.value.text;
        request.fields['category'] = selectedCategoryId.value.toString();
        request.fields['subcategory'] = selectedSubCategoryId.value.toString();
        request.fields['location'] = location.value.text;
        request.fields['city'] = city.value.text;
        request.fields['state'] = state.value.text;
        request.fields['lat'] = lat.value.text;
        request.fields['lng'] = lng.value.text;
        request.fields['country'] = country.value.text;
        request.fields['company'] = companyName.value.text;
        request.fields['website'] = url.value.text;
        request.fields['api_token'] = apiToken ?? '';
        request.fields['classified_id'] = classifiedId.toString();

        if (kDebugMode) {
          print('classified id: $classifiedId');
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
              title: const Text('Classified Updated Successfully'),
            );
            Get.back();
            fetchClassifieds();
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

  void titleValidation(context) {
    String enteredTitle = title.value.text;
    if (enteredTitle.isEmpty || hasSpecialCharactersOrNumbers(enteredTitle)) {
      // Show toast message for invalid title
      showToasterrorborder("Please Enter Your Classified Title", context);
      titleError.value = true;
    } else {
      titleError.value = false;
    }
    if (titleError.value) {
      isTitleTyping.value = true;
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
  Future<void> likedUser(int classifiedId, BuildContext context) async {
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

          showToasterrorborder(
            message!,
            // ignore: use_build_context_synchronously
            context,
          );
        } else {
          //
        }
      } else {
        // ignore: use_build_context_synchronously
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      //
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleLike(int classifiedId, BuildContext context) async {
    bool isLiked = likedStatusMap[classifiedId] ?? false;
    isLiked = !isLiked;
    likedStatusMap[classifiedId] = isLiked;
    likeCountMap.update(
        classifiedId, (value) => isLiked ? value + 1 : value - 1,
        ifAbsent: () => isLiked ? 1 : 0);

    await likedUser(classifiedId, context);
  }

  // Delete-Classified
  Future<void> deleteClassified(int classifiedId, int index, context) async {
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
            showToastverifedborder(message, context);
            classifiedList.removeAt(index);
          } else {
            showToasterrorborder(
                "Failed to delete classified: $message", context);
            if (kDebugMode) {
              print('Failed to delete classified: $message');
            }
          }

          if (kDebugMode) {
            print('data from delete classified: $data');
          }
        } else {
          if (kDebugMode) {
            print('Error: ${response.body}');
          }
        }
      } else {
        showToasterrorborder(
          "No internet connection",
          context,
        );
        if (kDebugMode) {
          print('No internet connection');
        }
      }
    } catch (e) {
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

          showToastverifedborder("$countViewClassifiedEntity", context);
        } else {
          //
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      //
    } finally {
      isLoading(false);
    }
  }

  // Bookmark
  Future<void> bookmarkUser(int classifiedId, BuildContext context) async {
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

          showToasterrorborder(
            message!,
            // ignore: use_build_context_synchronously
            context,
          );
        } else {
          //
        }
      } else {
        showToasterrorborder(
          "No internet connection",
          // ignore: use_build_context_synchronously
          context,
        );
      }
    } catch (e) {
      //
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleBookMark(int classifiedId, BuildContext context) async {
    bool isBookmark = bookmarkStatusMap[classifiedId] ?? false;
    isBookmark = !isBookmark;
    bookmarkStatusMap[classifiedId] = isBookmark;
    bookmarkCountMap.update(
        classifiedId, (value) => isBookmark ? value + 1 : value - 1,
        ifAbsent: () => isBookmark ? 1 : 0);

    await bookmarkUser(classifiedId, context);
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

          showToastverifedborder("Success: Your Post On Top", context);
        } else {
          if (kDebugMode) {
            print('HTTP Error: ${response.statusCode}');
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
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
        showToasterrorborder("No internet connection", context);
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

  void discriptionValidation(context) {
    String enteredDiscription = discription.value.text;
    if (enteredDiscription.isEmpty ||
        hasSpecialTextOrNumbers(enteredDiscription)) {
      showToasterrorborder(
          "Please Enter Description Minimum 250 Characters", context);
      discriptionError.value = true;
    } else {
      discriptionError.value = false;
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
