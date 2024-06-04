import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/get_mlm_database_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DatabaseController extends GetxController {
  int page = 1;
  var isEndOfData = false.obs;
  final ScrollController scrollController = ScrollController();
  var isLoading = false.obs;
  RxList<GetMlmDatabaseData> mlmDatabaseList = <GetMlmDatabaseData>[].obs;

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
}
