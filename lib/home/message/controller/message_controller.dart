import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/get_my_chat_detail_entity.dart';
import 'package:mlmdiary/generated/get_my_chat_history_entity.dart';
import 'package:mlmdiary/menu/controller/profile_controller.dart';
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
  final ProfileController profileController = Get.put(ProfileController());

  TextEditingController get searchController => _search;
  var chatId = ''.obs;

  Future<void> fetchMyChat() async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    if (apiToken.toString().isEmpty) {
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
            profileController.fetchUserProfile();

            if (kDebugMode) {
              print('Fetched ${chatList.length} chats');
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
          print('Response Body: ${response.body}');
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

  Future<void> fetchMyChatDetail(String? chatId) async {
    // Clear list and stop execution if chatId is null
    if (chatId == null) {
      chatdetailsList.clear();
      if (kDebugMode) {
        print('Chat ID is null, clearing chat details list');
      }
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    if (apiToken == null || apiToken.isEmpty) {
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
        print('api token: $apiToken');
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
            // Clear the old chat details list before adding new data
            profileController.fetchUserProfile();

            chatdetailsList.clear();
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
    }
  }

  Future<void> sendChat({
    required String toId,
    String? chatId,
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
      request.fields['chat_id'] = chatId ?? '';

      if (kDebugMode) {
        print('Request payload:');
        print('api_token: $apiToken');
        print('toid: $toId');
        print('msg: ${msg.value.text}');
        print('chat_id: ${chatId ?? ''}');
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) {
        print('Response status code: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Response body: ${response.body}');
      }

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);
        if (jsonBody.containsKey('status') && jsonBody['status'] == 1) {
          if (kDebugMode) {
            print('Chat sent successfully');
          }
          // Fetch the updated chat details
          final String updatedChatId =
              jsonBody['record']['chat_id']?.toString() ?? '';
          this.chatId.value = updatedChatId; // Store the updated chatId

          await fetchMyChatDetail(updatedChatId);

          // Clear the message input field after sending the message
          msg.value.clear();
        } else if (jsonBody.containsKey('error')) {
          if (kDebugMode) {
            print('Failed to send chat: ${jsonBody['error']}');
          }
        } else {
          if (kDebugMode) {
            print('Failed to send chat: Unexpected response format');
          }
          if (kDebugMode) {
            print('Response body: $jsonBody');
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to send chat. Status Code: ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Response body: ${response.body}');
        }
      }
    } catch (e) {
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

        // Check if response contains 'status' key with value 1
        if (jsonBody['status'] == 1) {
          fetchMyChat();
          Get.back();
          if (kDebugMode) {
            print('Chat Deleted successfully');
          }
        } else {
          // Handle failure scenario
          if (kDebugMode) {
            print('Failed to Delete chat: ${jsonBody['message']}');
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

  Future<void> fetchNewChat(int lastId, String chatId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var uri = Uri.parse('${Constants.baseUrl}${Constants.sendnewchat}');
      var request = http.MultipartRequest('POST', uri);
      request.fields['api_token'] = apiToken.toString();
      request.fields['device'] = device;
      request.fields['chat_id'] = chatId.toString();
      request.fields['last_id'] = lastId.toString();

      if (kDebugMode) {
        print('api_token: $apiToken');
        print('device: $device');
        print('chat_id: $chatId');
        print('last_id: $lastId');
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) {
        print('fetchNewChat: ${response.body}');
      }

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);

        if (jsonBody.containsKey('success')) {
          if (kDebugMode) {
            print('Chat sent successfully');
          }
        } else if (jsonBody.containsKey('error')) {
          if (kDebugMode) {
            print('Failed to send chat: ${jsonBody['error']}');
          }
        } else {
          try {
            // Check if mychatoverview is a Map or List and handle accordingly
            if (jsonBody['mychatoverview'] is Map<String, dynamic>) {
              GetMyChatDetailEntity chatDetailEntity =
                  GetMyChatDetailEntity.fromJson(jsonBody);

              if (kDebugMode) {
                print('Fetched Chat Details: ${chatDetailEntity.toString()}');
              }

              var chatOverview = chatDetailEntity.mychatoverview;
              if (chatOverview != null && chatOverview.data != null) {
                // Add new chats to the list and ensure UI is updated
                chatdetailsList.addAll(chatOverview.data!);
                if (kDebugMode) {
                  print('Chat Data Added: ${chatOverview.data}');
                }
              }
            } else if (jsonBody['mychatoverview'] is List) {
              List<dynamic> chatOverviewList = jsonBody['mychatoverview'];
              if (chatOverviewList.isNotEmpty) {
                for (var chat in chatOverviewList) {
                  GetMyChatDetailEntity chatDetailEntity =
                      GetMyChatDetailEntity.fromJson(
                          chat as Map<String, dynamic>);

                  if (chatDetailEntity.mychatoverview?.data != null) {
                    chatdetailsList
                        .addAll(chatDetailEntity.mychatoverview!.data!);
                  }
                }
                if (kDebugMode) {
                  print('Multiple Chat Data Added');
                }
              }
            }
          } catch (e) {
            if (kDebugMode) {
              print('Error parsing chat details: $e');
            }
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to send chat. Status Code: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sending chat: $e');
      }
    }
  }
}
