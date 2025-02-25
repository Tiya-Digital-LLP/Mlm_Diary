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
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntrestController extends GetxController {
  RxList<GetPlanWithSelectedPlan> planList = RxList<GetPlanWithSelectedPlan>();
  RxList<GetPlanWithSelectedPlan> filteredPlanList =
      RxList<GetPlanWithSelectedPlan>();
  RxList<GetCompanyWithSelectedCompany> companyList =
      RxList<GetCompanyWithSelectedCompany>();
  RxList<GetCompanyWithSelectedCompany> filterdcompanyList =
      RxList<GetCompanyWithSelectedCompany>();

  final RxList<bool> isPlanSelectedList = RxList<bool>([]);
  final RxList<bool> isCompanySelectedList = RxList<bool>([]);

  Rx<TextEditingController> company = TextEditingController().obs;

  var isLoading = false.obs;
  RxInt selectedCountPlan = 0.obs;
  RxInt selectedCountCompany = 0.obs;

  //scrollercontroller
  final ScrollController scrollController = ScrollController();
  var isEndOfData = false.obs;

  final search = TextEditingController();
  final searchcompany = TextEditingController();

  late SharedPreferences prefs;
  @override
  void onInit() {
    // Debounce search input to reduce API calls
    search.addListener(() {
      String query = search.text.trim().toLowerCase();
      if (query.isEmpty) {
        filteredPlanList.assignAll(planList);
      } else {
        filteredPlanList.assignAll(
          planList.where(
              (plan) => plan.name?.toLowerCase().contains(query) ?? false),
        );
      }
    });
    // Debounce search input to reduce API calls
    searchcompany.addListener(() {
      String query = searchcompany.text.trim().toLowerCase();
      if (query.isEmpty) {
        filterdcompanyList.assignAll(companyList);
      } else {
        filterdcompanyList.assignAll(
          companyList.where(
              (plan) => plan.name?.toLowerCase().contains(query) ?? false),
        );
      }
    });
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
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? apiToken = prefs.getString(Constants.accessToken);

      var uri =
          Uri.parse('${Constants.baseUrl}${Constants.getplanlistwithselected}');
      var request = http.MultipartRequest('POST', uri);
      request.fields['api_token'] = apiToken ?? '';
      request.fields['search'] = search.text;

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = jsonDecode(response.body);
        final planListWithSelectedEntity =
            GetPlanWithSelectedEntity.fromJson(jsonBody);

        if (planListWithSelectedEntity.status == 1) {
          planList.value = planListWithSelectedEntity.plan ?? [];
          filteredPlanList.assignAll(planList);

          // Initialize isPlanSelectedList based on the 'selected' field of each plan
          isPlanSelectedList.assignAll(
            planList.map((plan) => plan.selected ?? false).toList(),
          );
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
    isLoading.value = true; // Set loading to true to prevent duplicate requests

    if (page == 1) {
      companyList.clear();
      filterdcompanyList.clear();
      isEndOfData.value = false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

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

          final companyListWithSelectedEntity =
              GetCompanyWithSelectedEntity.fromJson(jsonBody);

          if (companyListWithSelectedEntity.status == 1) {
            List<GetCompanyWithSelectedCompany> newCompanies =
                companyListWithSelectedEntity.company ?? [];

            if (newCompanies.isEmpty) {
              isEndOfData.value = true;
            } else {
              companyList.addAll(newCompanies);
              filterdcompanyList.assignAll(companyList);

              isCompanySelectedList.assignAll(
                companyList
                    .map((company) => company.selected ?? false)
                    .toList(),
              );
            }
          }
        } else {
          if (kDebugMode) {
            print("HTTP error: ${response.statusCode}");
          }
        }
      } else {
        if (kDebugMode) {
          print("No internet connection");
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

  Future<void> updateUserPlan(List<String> selectedPlanname, context) async {
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
          showToastverifedborder('Plan updated successfully', context);
          // Process your response here if needed
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to update user plan. Status code: ${response.statusCode}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateCompany(List<String> selectedComapanyname, context) async {
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
        var uri = Uri.parse('${Constants.baseUrl}${Constants.updateCompany}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['company'] = selectedComapanyname.join(',');

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Update  Company response: $jsonBody");
          }
          showToastverifedborder('Company updated successfully', context);
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to update  Company. Status code: ${response.statusCode}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserCompany(context) async {
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
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.updateUserCompany}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['company'] = company.value.text;

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Update user Company response: $jsonBody");
          }

          // Process your response here if needed
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to update user Company. Status code: ${response.statusCode}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
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
