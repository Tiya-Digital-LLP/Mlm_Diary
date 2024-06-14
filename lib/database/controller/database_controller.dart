import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/get_mlm_database_entity.dart';
import 'package:mlmdiary/menu/menuscreens/accountsetting/controller/account_setting_controller.dart';
import 'package:mlmdiary/sign_up/controller/signup_controller.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../generated/database_detail_entity.dart';

class DatabaseController extends GetxController {
  int page = 1;
  var isEndOfData = false.obs;
  final ScrollController scrollController = ScrollController();
  var isLoading = false.obs;
  RxList<GetMlmDatabaseData> mlmDatabaseList = <GetMlmDatabaseData>[].obs;
  RxList<DatabaseDetailData> mlmDetailsDatabaseList =
      <DatabaseDetailData>[].obs;

  final search = TextEditingController();
  final AccountSeetingController accountSeetingController =
      Get.put(AccountSeetingController());
  final ClasifiedController clasifiedController =
      Get.put(ClasifiedController());
  final SignupController signupController = Get.put(SignupController());

  @override
  void onInit() {
    super.onInit();
    getMlmDatabase(1);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isEndOfData.value) {
        int nextPage = (mlmDatabaseList.length ~/ 10) + 1;
        getMlmDatabase(nextPage);
      }
    });
  }

  Future<void> getMlmDatabase(int page) async {
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
        var uri = Uri.parse('${Constants.baseUrl}${Constants.mlmdatabase}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['page'] = page.toString();
        request.fields['search'] = search.value.text;
        request.fields['plan'] = accountSeetingController
            .getSelectedPlanOptionsTextController()
            .value
            .text;
        request.fields['company'] = clasifiedController.companyName.value.text;
        request.fields['location'] = clasifiedController.location.value.text;
        request.fields['user_type'] =
            signupController.getSelectedOptionsTextController().value.text;

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var getmlmDatabaseEnity = GetMlmDatabaseEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $getmlmDatabaseEnity');
          }

          if (getmlmDatabaseEnity.data != null &&
              getmlmDatabaseEnity.data!.isNotEmpty) {
            if (page == 1) {
              mlmDatabaseList.value = getmlmDatabaseEnity.data!;
            } else {
              mlmDatabaseList.addAll(getmlmDatabaseEnity.data!);
            }
          } else {
            if (page == 1) {
              mlmDatabaseList.clear();
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

  void clearFields() {
    for (int i = 0; i < signupController.isTypeSelectedList.length; i++) {
      signupController.isTypeSelectedList[i] = false;
    }
    for (int i = 0;
        i < accountSeetingController.isPlanSelectedList.length;
        i++) {
      accountSeetingController.isPlanSelectedList[i] = false;
    }
    clasifiedController.companyName.value.clear();
    clasifiedController.location.value.clear();
    getMlmDatabase(1);
  }

  Future<void> fetchUserPost(int userId, context) async {
    isLoading.value = true;
    String device =
        Platform.isAndroid ? 'android' : (Platform.isIOS ? 'ios' : '');

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
        'user_id': userId.toString(),
      };

      Uri uri = Uri.parse(Constants.baseUrl + Constants.userpost)
          .replace(queryParameters: queryParams);

      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final DatabaseDetailEntity postEntity =
            DatabaseDetailEntity.fromJson(responseData);

        final DatabaseDetailData? firstPost = postEntity.data;
        if (firstPost != null) {
          final String postId = firstPost.id.toString();
          await prefs.setString('lastPostid', postId);

          // Add the fetched post to the list
          mlmDetailsDatabaseList.add(firstPost);
        } else {
          showToasterrorborder("No data found", context);
        }
      } else {
        showToasterrorborder(
            "Failed to fetch data. Status code: ${response.statusCode}",
            context);
      }
    } catch (error) {
      showToasterrorborder("An error occurred: $error", context);
    } finally {
      isLoading.value = false;
    }
  }
}
