import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/bookmark_company_entity.dart';
import 'package:mlmdiary/generated/get_admin_company_entity.dart';
import 'package:mlmdiary/generated/mlm_like_company_entity.dart';
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

  Future<void> getAdminCompany(int page) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString('apiToken');
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
              companyAdminList.value = getAdminCompanyEnity.data!;
            } else {
              companyAdminList.addAll(getAdminCompanyEnity.data!);
            }
          } else {
            if (page == 1) {
              companyAdminList.clear();
            }
            isEndOfData(true);
          }
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

  //like
  Future<void> likeCompany(int companyId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString('apiToken');
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

    await likeCompany(classifiedId);
  }

  // Bookmark
  Future<void> bookmarkCompany(int companyId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString('apiToken');
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

  Future<void> toggleBookMark(int companyId) async {
    bool isBookmark = likedStatusMap[companyId] ?? false;
    isBookmark = !isBookmark;
    likedStatusMap[companyId] = isBookmark;
    likeCountMap.update(
        companyId, (value) => isBookmark ? value + 1 : value - 1,
        ifAbsent: () => isBookmark ? 1 : 0);

    await bookmarkCompany(companyId);
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
