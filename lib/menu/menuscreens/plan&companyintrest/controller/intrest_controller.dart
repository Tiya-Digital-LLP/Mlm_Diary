import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/get_company_with_selected_entity.dart';
import 'package:mlmdiary/generated/get_plan_with_selected_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntrestController extends GetxController {
  RxList<GetPlanWithSelectedPlan> planList = RxList<GetPlanWithSelectedPlan>();
  RxList<GetCompanyWithSelectedCompany> companyList =
      RxList<GetCompanyWithSelectedCompany>();

  final RxList<bool> isPlanSelectedList = RxList<bool>([]);
  final RxList<bool> isCompanySelectedList = RxList<bool>([]);

  var isLoading = false.obs;
  RxInt selectedCountPlan = 0.obs;
  RxInt selectedCountCompany = 0.obs;

  //scrollercontroller
  final ScrollController scrollController = ScrollController();
  var isEndOfData = false.obs;

  final search = TextEditingController();
  late SharedPreferences prefs;
  @override
  void onInit() {
    fetchSelectedPlanList();
    fetchSelectedCompanyList(1);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isEndOfData.value) {
        int nextPage = (companyList.length ~/ 10) + 1;
        fetchSelectedCompanyList(nextPage);
      }
    });
    super.onInit();
  }

  Future<void> fetchSelectedPlanList() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';
    if (kDebugMode) {
      print('Device Name: $device');
    }
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse(
            '${Constants.baseUrl}${Constants.getplanlistwithselected}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['search'] = search.value.text;

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Response body: $jsonBody");
          }

          final planListWithSelectedEntity =
              GetPlanWithSelectedEntity.fromJson(jsonBody);

          if (planListWithSelectedEntity.status == 1) {
            if (kDebugMode) {
              print("Plan list fetched successfully");
            }

            planList.value = planListWithSelectedEntity.plan ?? [];
            isPlanSelectedList.assignAll(List<bool>.generate(
                planList.length, (index) => planList[index].selected ?? false));

            if (kDebugMode) {
              print("Plan list: $planList");
            }
          } else {
            // Handle error when status is not 1
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to fetch plan list. Status code: ${response.statusCode}");
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSelectedCompanyList(int page) async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';
    if (kDebugMode) {
      print('Device Name: $device');
    }
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse(
            '${Constants.baseUrl}${Constants.getcompanylistwithselected}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['search'] = search.value.text;
        request.fields['page'] = page.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Response body: $jsonBody");
          }

          final companyListWithSelectedEntity =
              GetCompanyWithSelectedEntity.fromJson(jsonBody);

          if (companyListWithSelectedEntity.status == 1) {
            if (kDebugMode) {
              print("Company list fetched successfully");
            }

            if (companyListWithSelectedEntity.company == null ||
                companyListWithSelectedEntity.company!.isEmpty) {
              isEndOfData.value = true;
            } else {
              companyList.addAll(companyListWithSelectedEntity.company!);
              isCompanySelectedList.addAll(List<bool>.generate(
                  companyListWithSelectedEntity.company!.length,
                  (index) =>
                      companyListWithSelectedEntity.company![index].selected ??
                      false));
            }

            if (kDebugMode) {
              print("Company list: $companyList");
            }
          } else {
            // Handle error when status is not 1
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to fetch company list. Status code: ${response.statusCode}");
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserPlan(List<String> selectedPlanname) async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';
    if (kDebugMode) {
      print('Device Name: $device');
    }
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.updateUserPlan}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['plan'] = selectedPlanname.join(',');

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Update user plan response: $jsonBody");
          }

          // Process your response here if needed
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to update user plan. Status code: ${response.statusCode}");
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
    } finally {
      isLoading.value = false;
    }
  }

  void togglePlanSelected(int index) {
    isPlanSelectedList[index] = !isPlanSelectedList[index];

    if (isPlanSelectedList[index]) {
      selectedCountPlan++;
    } else {
      selectedCountPlan--;
    }

    planList[index].selected = isPlanSelectedList[index];
  }

  void toggleCompanySelected(int index) {
    isCompanySelectedList[index] = !isCompanySelectedList[index];

    if (isCompanySelectedList[index]) {
      selectedCountCompany++;
    } else {
      selectedCountCompany--;
    }

    companyList[index].selected = isCompanySelectedList[index];
  }
}
