// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomFloatingActionButtonController extends GetxController {
  final BuildContext context;

  CustomFloatingActionButtonController(this.context);

  var isLoading = false.obs;

  Future<void> handleTap(String selectedType) async {
    isLoading.value = true;
    try {
      var result = await classifiedRemainingCount(selectedType);

      if (result != null) {
        if (result['status'] == 0) {
          showAlertDialog(result['message']);
        } else if (result['status'] == 1) {
          navigateTo(selectedType);
        }
      } else {
        showErrorMessage("Failed to fetch data. Please try again later.");
      }
    } catch (e) {
      showErrorMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>?> classifiedRemainingCount(
      String selectedType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.remainigcount}');
        var request = http.MultipartRequest('POST', uri);
        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['type'] = selectedType;

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          return data;
        } else {
          if (kDebugMode) {
            print('Error: ${response.body}');
          }
          return null;
        }
      } else {
        if (kDebugMode) {
          print('No internet connection');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return null;
    }
  }

  void showAlertDialog(String message) {
    final Size size = MediaQuery.of(context).size;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: EdgeInsets.zero,
          content: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.cancel_outlined,
                      size: 80,
                      color: AppColors.redText,
                    ),
                  ),
                ),
                16.sbh,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    message,
                    style: textStyleW600(
                      size.width * 0.032,
                      AppColors.blackText,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Cancel',
                                style: textStyleW700(
                                    size.width * 0.035, AppColors.blackText),
                              ),
                            ),
                          ),
                          5.sbw,
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shadowColor: AppColors.primaryColor,
                                elevation: 3,
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Pay Now',
                                style: textStyleW700(
                                    size.width * 0.035, AppColors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showErrorMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void navigateTo(String selectedType) {
    switch (selectedType) {
      case 'classified':
        Get.toNamed(Routes.addclassified);
        break;
      case 'news':
        Get.toNamed(Routes.addnews);
        break;
      case 'blog':
        Get.toNamed(Routes.addblog);
        break;
      default:
        break;
    }
  }
}
