import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/get_my_chat_detail_entity.dart';
import 'package:mlmdiary/generated/get_my_chat_history_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MessageController extends GetxController {
  var isLoading = false.obs;
  RxList<GetMyChatHistoryMychatoverviewData> chatList =
      <GetMyChatHistoryMychatoverviewData>[].obs;
  RxList<GetMyChatDetailMychatoverviewData> chatdetailsList =
      <GetMyChatDetailMychatoverviewData>[].obs;
  final TextEditingController _search = TextEditingController();
  Rx<TextEditingController> msg = TextEditingController().obs;

  TextEditingController get searchController => _search;

  @override
  void onInit() {
    fetchMyChat();
    super.onInit();
  }

  Future<void> fetchMyChat() async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    if (apiToken == null || apiToken.isEmpty) {
      isLoading(false);
      if (kDebugMode) {
        print('No API token found');
      }
      return;
    }

    try {
      var uri = Uri.parse('${Constants.baseUrl}${Constants.getchathistory}');
      var request = http.MultipartRequest('POST', uri);
      request.fields['api_token'] = apiToken.toString();

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);

        if (jsonBody.containsKey('mychatoverview')) {
          final GetMyChatHistoryEntity getMyChatHistoryEntity =
              GetMyChatHistoryEntity.fromJson(jsonBody);

          if (getMyChatHistoryEntity.mychatoverview != null &&
              getMyChatHistoryEntity.mychatoverview!.data != null) {
            chatList.assignAll(getMyChatHistoryEntity.mychatoverview!.data!);

            if (kDebugMode) {
              print('Fetched ${chatList.length} posts');
            }
          } else {
            if (kDebugMode) {
              print('Failed to fetch Chat. Data key not found in response.');
            }
          }
        } else {
          if (kDebugMode) {
            print('Failed to fetch Chat. Required data not found in response.');
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to fetch Chat. Status Code: ${response.statusCode}');
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

  Future<void> fetchMyChatDetail(String chatId) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    if (apiToken == null || apiToken.isEmpty) {
      isLoading(false);
      if (kDebugMode) {
        print('No API token found');
      }
      return;
    }

    try {
      var uri =
          Uri.parse('${Constants.baseUrl}${Constants.getchathistorydetail}');
      var request = http.MultipartRequest('POST', uri);
      request.fields['api_token'] = apiToken.toString();
      request.fields['chat_id'] = chatId.toString();
      if (kDebugMode) {
        print('api toke: $apiToken');
        print('chatId: $chatId');
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);

        if (jsonBody.containsKey('mychatoverview')) {
          final GetMyChatDetailEntity getMyChatHistoryEntity =
              GetMyChatDetailEntity.fromJson(jsonBody);

          if (getMyChatHistoryEntity.mychatoverview != null &&
              getMyChatHistoryEntity.mychatoverview!.data != null) {
            chatdetailsList
                .assignAll(getMyChatHistoryEntity.mychatoverview!.data!);

            if (kDebugMode) {
              print('Fetched ${chatdetailsList.length} posts');
            }
          } else {
            if (kDebugMode) {
              print(
                  'Failed to fetch Chat Detail. Data key not found in response.');
            }
          }
        } else {
          if (kDebugMode) {
            print(
                'Failed to fetch Chat Detail. Required data not found in response.');
          }
        }
      } else {
        if (kDebugMode) {
          print(
              'Failed to fetch Chat Detail. Status Code: ${response.statusCode}');
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

  Future<void> sendChat({
    required String toId,
    required String chatId,
  }) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? apiToken = prefs.getString(Constants.accessToken);

    try {
      var uri = Uri.parse('${Constants.baseUrl}${Constants.sendchat}');
      var request = http.MultipartRequest('POST', uri);
      request.fields['api_token'] = apiToken.toString();
      request.fields['toid'] = toId;
      request.fields['msg'] = msg.value.text;
      request.fields['chat_id'] = chatId;

      if (kDebugMode) {
        print('api_token : $apiToken');
        print('toid : $toId');
        print('msg : ${msg.value.text}');
        print('chat_id : $chatId');
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);

        // Check if response contains 'success' or 'error' keys
        if (jsonBody.containsKey('success')) {
          // Handle success scenario
          if (kDebugMode) {
            print('Chat sent successfully');
          }
        } else if (jsonBody.containsKey('error')) {
          // Handle failure scenario
          if (kDebugMode) {
            print('Failed to send chat: ${jsonBody['error']}');
          }
        } else {
          // Handle unexpected response format
          if (kDebugMode) {
            print('Failed to send chat: Unexpected response format');
            print('Response body: $jsonBody');
          }
        }
      } else {
        // Handle HTTP error status codes
        if (kDebugMode) {
          print('Failed to send chat. Status Code: ${response.statusCode}');
        }
      }
    } catch (e) {
      // Handle exceptions thrown during request or parsing
      if (kDebugMode) {
        print('Error sending chat: $e');
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteChat({
    required String chatId,
  }) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    try {
      var uri = Uri.parse('${Constants.baseUrl}${Constants.deleteChat}');
      var request = http.MultipartRequest('POST', uri);
      request.fields['api_token'] = apiToken.toString();
      request.fields['chat_id'] = chatId;

      if (kDebugMode) {
        print('api_token : $apiToken');
        print('chat_id : $chatId');
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);

        // Check if response contains 'success' or 'error' keys
        if (jsonBody.containsKey('success')) {
          // Handle success scenario
          if (kDebugMode) {
            print('Chat Delete successfully');
          }
        } else if (jsonBody.containsKey('error')) {
          // Handle failure scenario
          if (kDebugMode) {
            print('Failed to Delete chat: ${jsonBody['error']}');
          }
        } else {
          // Handle unexpected response format
          if (kDebugMode) {
            print('Failed to Delete chat: Unexpected response format');
            print('Response body: $jsonBody');
          }
        }
      } else {
        // Handle HTTP error status codes
        if (kDebugMode) {
          print('Failed to send chat. Status Code: ${response.statusCode}');
        }
      }
    } catch (e) {
      // Handle exceptions thrown during request or parsing
      if (kDebugMode) {
        print('Error sending chat: $e');
      }
    } finally {
      isLoading(false);
    }
  }
}
