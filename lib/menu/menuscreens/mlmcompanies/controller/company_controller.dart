import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/add_company_comment_entity.dart';
import 'package:mlmdiary/generated/bookmark_company_entity.dart';
import 'package:mlmdiary/generated/company_count_view_entity.dart';
import 'package:mlmdiary/generated/edit_comment_entity.dart';
import 'package:mlmdiary/generated/get_admin_company_entity.dart';
import 'package:mlmdiary/generated/get_company_comment_entity.dart';
import 'package:mlmdiary/generated/mlm_like_company_entity.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyController extends GetxController {
  var isLiked = false.obs;
  var likeCount = 0.obs;
// FIELDS ERROR

  var isLoading = false.obs;

  RxList<GetAdminCompanyData> companyAdminList = <GetAdminCompanyData>[].obs;
  int page = 1;
  var isEndOfData = false.obs;
  final ScrollController scrollController = ScrollController();
  //like
  var likedStatusMap = <int, bool>{};
  var likeCountMap = <int, int>{};

  //bookmark
  var bookmarkStatusMap = <int, bool>{};
  var bookmarkCountMap = <int, int>{};

  final search = TextEditingController();

  // Company comment
  RxList<GetCompanyCommentData> getCommentList = <GetCompanyCommentData>[].obs;
  Rx<TextEditingController> commment = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    getAdminCompany(1);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isEndOfData.value) {
        int nextPage = (companyAdminList.length ~/ 10) + 1;
        getAdminCompany(nextPage);
      }
    });
  }

  Future<void> getAdminCompany(int page, {int? companyId}) async {
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
        var uri = Uri.parse('${Constants.baseUrl}${Constants.getadmincompany}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['page'] = page.toString();
        request.fields['search'] = search.value.text;
        request.fields['company_id'] = companyId?.toString() ?? '';

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var getAdminCompanyEnity = GetAdminCompanyEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $getAdminCompanyEnity');
          }

          if (getAdminCompanyEnity.data != null &&
              getAdminCompanyEnity.data!.isNotEmpty) {
            if (page == 1) {
              if (companyId == null) {
                companyAdminList.value = getAdminCompanyEnity.data!;
              } else {
                companyAdminList.value = [getAdminCompanyEnity.data!.first];
              }
            } else {
              if (companyId == null) {
                companyAdminList.addAll(getAdminCompanyEnity.data!);
              } else {
                if (getAdminCompanyEnity.data!.isNotEmpty) {
                  companyAdminList.add(getAdminCompanyEnity.data!.first);
                }
              }
            }
            isEndOfData(false);
          } else {
            if (page == 1) {
              companyAdminList.clear();
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

  //like
  Future<void> likeCompany(int companyId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.likemlmcompany}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['company_id'] = companyId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var mlmLikeCompanyEntity = MlmLikeCompanyEntity.fromJson(data);
          var message = mlmLikeCompanyEntity.message;

          // Update the liked status and like count based on the message
          if (message == 'You have liked this classified') {
            likedStatusMap[companyId] = true;
            likeCountMap[companyId] = (likeCountMap[companyId] ?? 0) + 1;
          } else if (message == 'You have unliked this classified') {
            likedStatusMap[companyId] = false;
            likeCountMap[companyId] = (likeCountMap[companyId] ?? 0) - 1;
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
        print('$e');
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> countViewCompany(int companyId, context) async {
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
            Uri.parse('${Constants.baseUrl}${Constants.countviewcompany}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['company_id'] = companyId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var countViewCompanyEntity = CompanyCountViewEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $countViewCompanyEntity');
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

  Future<void> toggleLike(int classifiedId, context) async {
    bool isLiked = likedStatusMap[classifiedId] ?? false;
    isLiked = !isLiked;
    likedStatusMap[classifiedId] = isLiked;
    likeCountMap.update(
        classifiedId, (value) => isLiked ? value + 1 : value - 1,
        ifAbsent: () => isLiked ? 1 : 0);

    await likeCompany(classifiedId, context);
  }

  // Bookmark
  Future<void> bookmarkCompany(int companyId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.bookmarkmlmcompany}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['company_id'] = companyId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var bookmarkCompanyEntity = BookmarkCompanyEntity.fromJson(data);
          var message = bookmarkCompanyEntity.message;

          // Update the liked status and like count based on the message
          if (message == 'You have bookmark this classified') {
            bookmarkStatusMap[companyId] = true;
            bookmarkCountMap[companyId] =
                (bookmarkCountMap[companyId] ?? 0) + 1;
          } else if (message == 'You have unbookmark this classified') {
            bookmarkStatusMap[companyId] = false;
            bookmarkCountMap[companyId] =
                (bookmarkCountMap[companyId] ?? 0) - 1;
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

  Future<void> toggleBookMark(int companyId, context) async {
    bool isBookmark = likedStatusMap[companyId] ?? false;
    isBookmark = !isBookmark;
    likedStatusMap[companyId] = isBookmark;
    likeCountMap.update(
        companyId, (value) => isBookmark ? value + 1 : value - 1,
        ifAbsent: () => isBookmark ? 1 : 0);

    await bookmarkCompany(companyId, context);
  }

  // comment for Post
  Future<void> getCommentCompany(int page, int companyId, context) async {
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
            Uri.parse('${Constants.baseUrl}${Constants.getcommentCompany}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['page'] = page.toString();
        request.fields['company_id'] = companyId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var getCompanyCommentEntity = GetCompanyCommentEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $getCompanyCommentEntity');
          }

          if (getCompanyCommentEntity.data != null &&
              getCompanyCommentEntity.data!.isNotEmpty) {
            if (page == 1) {
              getCommentList.value = getCompanyCommentEntity.data!;
            } else {
              getCommentList.addAll(getCompanyCommentEntity.data!);
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

  Future<void> addReplyCompanyComment(
      int companyId, int commentId, context) async {
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
        var uri = Uri.parse(
            '${Constants.baseUrl}${Constants.addcommentcompanyreply}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['company_id'] = companyId.toString();
        request.fields['comment_id'] = commentId.toString();
        request.fields['comment'] = commment.value.text;

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var addCompanyCommentEntity = AddCompanyCommentEntity.fromJson(data);
          // Check if the status is 0 and show a toast message
        if (data['status'] == 0) {
          showToasterrorborder(data['message'], context);
        } else {
          getCommentCompany(1, companyId, context);
          if (kDebugMode) {
            print('Success: $addCompanyCommentEntity');
          }
        }

          if (kDebugMode) {
            print('Success: $addCompanyCommentEntity');
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
        request.fields['type'] = 'company';
        request.fields['comment_id'] = commentId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          jsonDecode(response.body);
          // Handle success response as needed
          await getCommentCompany(1, blogId, context);
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

  Future<void> editComment(int companyId, int commentId, String newComment,
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
          await getCommentCompany(1, companyId, context);

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
