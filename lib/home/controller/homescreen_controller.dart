import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/get_banner_entity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeController extends GetxController {
  RxBool isSearchBarVisible = false.obs;
  RxList<GetBannerData> banners = RxList<GetBannerData>();
  late WebViewController webController;
  RxBool isload = true.obs;

  @override
  void onInit() {
    super.onInit();
    ever(isload, (_) {
      if (isload.value) {
        fetchBanners();
      }
    });
  }

  void toggleSearchBarVisibility() {
    isSearchBarVisible.value = !isSearchBarVisible.value;
  }

  Future<void> fetchBanners() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        return;
      }

      final response = await http.get(
        Uri.parse('${Constants.baseUrl}${Constants.getbanner}'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody =
            jsonDecode(response.body) as Map<String, dynamic>;

        if (responseBody['status'] == '1') {
          final List<dynamic> jsonData = responseBody['data'];
          final List<GetBannerData> bannerDataList = jsonData.map((data) {
            return GetBannerData.fromJson(data as Map<String, dynamic>);
          }).toList();

          banners.assignAll(bannerDataList);

          for (var banner in banners) {
            if (kDebugMode) {
              print('Banner ID: ${banner.id}');
              print('Title: ${banner.title}');
              print('Web Link: ${banner.weblink}');
            }
          }

          // Initialize webController here
          webController = WebViewController();
        } else {
          if (kDebugMode) {
            print('Failed to load banners: ${response.statusCode}');
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to load banners: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading banners: $e');
      }
    }
  }
}
