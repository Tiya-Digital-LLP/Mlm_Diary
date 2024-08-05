import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/data/constants.dart';
import 'package:mlmdiary/generated/add_answer_comment_entity.dart';
import 'package:mlmdiary/generated/add_answer_entity.dart';
import 'package:mlmdiary/generated/add_faviourite_question_entity.dart';
import 'package:mlmdiary/generated/answer_liked_entity.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/generated/count_view_question_entity.dart';
import 'package:mlmdiary/generated/edit_comment_entity.dart';
import 'package:mlmdiary/generated/get_answers_entity.dart';
import 'package:mlmdiary/generated/get_category_entity.dart';
import 'package:mlmdiary/generated/get_question_list_entity.dart';
import 'package:mlmdiary/generated/get_sub_category_entity.dart';
import 'package:mlmdiary/generated/my_question_entity.dart';
import 'package:mlmdiary/generated/question_like_entity.dart';
import 'package:mlmdiary/generated/question_like_list_entity.dart';
import 'package:mlmdiary/generated/update_answer_entity.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class QuestionAnswerController extends GetxController {
  Rx<TextEditingController> title = TextEditingController().obs;
  Rx<TextEditingController> answer = TextEditingController().obs;

  //category
  RxList<GetCategoryCategory> categorylist = RxList<GetCategoryCategory>();
  final RxList<bool> isCategorySelectedList = RxList<bool>([]);
  //subcategory
  RxList<GetSubCategoryCategory> subcategoryList =
      RxList<GetSubCategoryCategory>();
  final RxList<bool> isSubCategorySelectedList = RxList<bool>([]);

  RxList<MyQuestionQuestions> myquestionList = <MyQuestionQuestions>[].obs;
  RxList<GetQuestionListQuestions> questionList =
      <GetQuestionListQuestions>[].obs;

  RxList<GetAnswersAnswers> answerList = <GetAnswersAnswers>[].obs;
  Rx<TextEditingController> commment = TextEditingController().obs;

  RxList<QuestionLikeListData> questionLikeList =
      RxList<QuestionLikeListData>();

  final search = TextEditingController();

  //error
  RxBool titleError = false.obs;
  RxBool answerError = false.obs;
  RxBool categoryError = false.obs;
  RxBool subCategoryError = false.obs;

  // ENABLED TYPING VALIDATION
  RxBool isTitleTyping = false.obs;
  RxBool isAnswerTyping = false.obs;
  RxBool isCategoryTyping = false.obs;
  RxBool isSubCategoryTyping = false.obs;

  //count
  RxInt selectedCountCategory = 0.obs;
  RxInt selectedCountSubCategory = 0.obs;

  //like
  var likedStatusMap = <int, bool>{};
  var likeCountMap = <int, int>{};

  //answer-like
  var answerlikedStatusMap = <int, bool>{};
  var answerlikeCountMap = <int, int>{};

//bookmark
  var bookmarkStatusMap = <int, bool>{};
  var bookmarkCountMap = <int, int>{};

  var isLoading = false.obs;

  var isEndOfData = false.obs;

  //scrollercontroller
  final ScrollController scrollController = ScrollController();

  var selectedCategoryId = 0.obs;
  var selectedSubCategoryId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryList();
    fetchMyQuestion();
    getQuestion(1);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isEndOfData.value) {
        int nextPage = (questionList.length ~/ 10) + 1;
        getQuestion(nextPage);
      }
    });
  }

  //update-Blog
  Future<void> updateQuestion({context}) async {
    isLoading(true);
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? questionId = prefs.getInt('lastquestionId');

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${Constants.baseUrl}${Constants.editquestion}'),
        );

        request.fields['device'] = device;
        request.fields['question_id'] = questionId.toString();
        request.fields['title'] = title.value.text;
        request.fields['category'] = selectedCategoryId.value.toString();
        request.fields['subcategory'] = selectedSubCategoryId.value.toString();

        if (kDebugMode) {
          print('Question id  $questionId');
        }

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Response body: $jsonBody");
          }
          // Check if all fields in the response are true (you may need to adjust this condition based on the actual response structure)
          if (jsonBody['status'] == 1) {
            toastification.show(
              context: context,
              alignment: Alignment.bottomCenter,
              backgroundColor: AppColors.white,
              type: ToastificationType.success,
              style: ToastificationStyle.flatColored,
              showProgressBar: false,
              autoCloseDuration: const Duration(seconds: 3),
              icon: Image.asset(
                Assets.imagesChecked,
                height: 35,
              ),
              primaryColor: Colors.green,
              title: const Text('Question Updated Successfully'),
            );
            fetchMyQuestion();
            Get.back();
          } else if (jsonBody['status'] == 0) {
            toastification.show(
              context: context,
              alignment: Alignment.bottomCenter,
              backgroundColor: AppColors.white,
              type: ToastificationType.error,
              style: ToastificationStyle.flatColored,
              showProgressBar: false,
              autoCloseDuration: const Duration(seconds: 3),
              icon: Image.asset(
                Assets.imagesCancel,
                height: 35,
              ),
              primaryColor: Colors.red,
              title: Text('${jsonBody['message']}'),
            );
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to Update Blog details. Status code: ${response.statusCode}");
            print("Response body: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred while saving Blog details: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> getQuestion(int page, {int? questionid}) async {
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
        var uri = Uri.parse('${Constants.baseUrl}${Constants.getquestion}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['page'] = page.toString();
        request.fields['search'] = search.value.text;
        request.fields['question_id'] = questionid?.toString() ?? '';

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var getQuestionEntity = GetQuestionListEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $getQuestionEntity');
          }

          if (getQuestionEntity.questions != null &&
              getQuestionEntity.questions!.isNotEmpty) {
            if (page == 1) {
              if (questionid == null) {
                questionList.value = getQuestionEntity.questions!;
              } else {
                questionList.value = [getQuestionEntity.questions!.first];
              }
            } else {
              if (questionid == null) {
                questionList.addAll(getQuestionEntity.questions!);
              } else {
                if (getQuestionEntity.questions!.isNotEmpty) {
                  questionList.add(getQuestionEntity.questions!.first);
                }
              }
            }
            isEndOfData(false);
          } else {
            if (page == 1) {
              questionList.clear();
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

  Future<void> getAnswers(int page, int answerId) async {
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
        var uri = Uri.parse('${Constants.baseUrl}${Constants.getanswer}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['page'] = page.toString();
        request.fields['question_id'] = answerId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var getAnswerEntity = GetAnswersEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $getAnswerEntity');
          }

          if (getAnswerEntity.answers != null &&
              getAnswerEntity.answers!.isNotEmpty) {
            if (page == 1) {
              answerList.value = getAnswerEntity.answers!;
            } else {
              answerList.addAll(getAnswerEntity.answers!);
            }
            isEndOfData(false);
          } else {
            if (page == 1) {
              answerList.clear();
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

  Future<void> deleteComment(int newsId, int commentId, context) async {
    isLoading(true);

    if (kDebugMode) {
      print('Starting deleteComment function');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (kDebugMode) {
        print('Connectivity check result: $connectivityResult');
      }

      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        if (kDebugMode) {
          print('Internet connection detected');
        }

        var uri = Uri.parse('${Constants.baseUrl}${Constants.deletecommment}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['type'] = 'answer';
        request.fields['comment_id'] = commentId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          if (kDebugMode) {
            print('Comment deleted successfully');
          }
          jsonDecode(response.body);
          // Handle success response as needed
          await getAnswers(1, newsId);
        } else {
          if (kDebugMode) {
            print('Error response received: ${response.statusCode}');
          }
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      } else {
        if (kDebugMode) {
          print('No internet connection');
        }
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception occurred: $e');
      }
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
      if (kDebugMode) {
        print('deleteComment function completed');
      }
    }
  }

  Future<void> deleteAnswers(int newsId, int answerid, context) async {
    isLoading(true);

    if (kDebugMode) {
      print('Starting deleteAnswer function');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (kDebugMode) {
        print('Connectivity check result: $connectivityResult');
      }

      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        if (kDebugMode) {
          print('Internet connection detected');
        }

        var uri = Uri.parse('${Constants.baseUrl}${Constants.deleteanswer}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['answer_id'] = answerid.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          if (kDebugMode) {
            print('Answer deleted successfully');
          }
          jsonDecode(response.body);
          // Handle success response as needed
          await getAnswers(1, newsId);
        } else {
          if (kDebugMode) {
            print('Error response received: ${response.statusCode}');
          }
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      } else {
        if (kDebugMode) {
          print('No internet connection');
        }
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception occurred: $e');
      }
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
      if (kDebugMode) {
        print('deleteComment function completed');
      }
    }
  }

  Future<void> editComment(int newsId, int commentId, String newComment,
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
          await getAnswers(1, newsId);

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

  Future<void> editAnswer(
      int newsId, int answerid, String newComment, context) async {
    isLoading(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.editanswer}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['answer_id'] = answerid.toString();
        request.fields['answer'] = commment.value.text;

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var editCommentEntity = UpdateAnswerEntity.fromJson(data);
          await getAnswers(1, newsId);

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

  Future<void> countViewQuestion(int answerId, context) async {
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
            Uri.parse('${Constants.baseUrl}${Constants.countviewquestion}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['question_id'] = answerId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var countViewQuestionEntity = CountViewQuestionEntity.fromJson(data);

          if (kDebugMode) {
            print('Success: $countViewQuestionEntity');
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

  Future<void> addAnswers(int answerId, context) async {
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
        var uri = Uri.parse('${Constants.baseUrl}${Constants.addanswer}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['question_id'] = answerId.toString();
        request.fields['answer'] = answer.value.text;

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var addAnswerEntity = AddAnswerEntity.fromJson(data);
          await getAnswers(1, answerId);
          if (kDebugMode) {
            print('Success: $addAnswerEntity');
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
      answer.value.clear();
    }
  }

  Future<void> addReplyAnswerComment(
      int answerId, int commentId, context) async {
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
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.addcommentanswerreply}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['answer_id'] = answerId.toString();
        request.fields['comment_id'] = commentId.toString();
        request.fields['comment'] = commment.value.text;

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var addCommentNewsEntity = AddAnswerCommentEntity.fromJson(data);
          getAnswers(1, answerId);

          if (kDebugMode) {
            print('Success: $addCommentNewsEntity');
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

  Future<void> addReplyAnswer(int answerId, context) async {
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
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.addcommentanswerreply}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['answer_id'] = answerId.toString();
        request.fields['comment'] = commment.value.text;

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var addCommentNewsEntity = AddAnswerCommentEntity.fromJson(data);
          getAnswers(1, answerId);

          if (kDebugMode) {
            print('Success: $addCommentNewsEntity');
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

  // Method to fetch data from API
  Future<void> fetchMyQuestion({
    int page = 1,
    BuildContext? context,
    int? questionId,
  }) async {
    isLoading.value = true;
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }

    if (kDebugMode) {
      print('Device Name: $device');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        if (context != null) {
          // ignore: use_build_context_synchronously
          showToasterrorborder("No internet connection", context);
        }
        isLoading.value = false;
        return;
      }

      Map<String, String> formData = {
        'api_token': apiToken ?? '',
        'device': device,
        'page': page.toString(),
      };

      // If articleId is provided, add it to formData
      if (questionId != null) {
        formData['id'] = questionId.toString();
      }

      Uri uri = Uri.parse(Constants.baseUrl + Constants.myqusetionanswer);
      final response = await http.post(uri, body: formData);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final MyQuestionEntity myBlogEntity =
            MyQuestionEntity.fromJson(responseData);

        if (kDebugMode) {
          print('Manage Blog data: $responseData');
        }

        final List<MyQuestionQuestions> myQuestionData =
            myBlogEntity.questions ?? [];

        // Assign or add data to myBlogList based on the page number
        if (page == 1) {
          myquestionList.assignAll(myQuestionData);
        } else {
          myquestionList.addAll(myQuestionData);
        }

        // Save the articleId to SharedPreferences
        if (questionId != null) {
          await prefs.setInt('lastquestionId', questionId);
        }

        // Update UI with appropriate blog data
        if (questionId != null) {
          // Find the selected blog by articleId
          MyQuestionQuestions? selectedBlog;
          for (var blog in myQuestionData) {
            if (blog.id == questionId) {
              selectedBlog = blog;
              break;
            }
          }

          if (selectedBlog != null) {
            updateUIWithQuestionData(selectedBlog);
          } else {
            // Show error message if blog with articleId is not found
            if (context != null) {
              showToasterrorborder(
                  "Question with ID $questionId not found",
                  // ignore: use_build_context_synchronously
                  context);
            }
          }
        } else {
          // If articleId is not provided, update UI with the first news
          if (myQuestionData.isNotEmpty) {
            updateUIWithQuestionData(myQuestionData[0]);
          } else {
            // Show error message if no data found
            if (context != null) {
              // ignore: use_build_context_synchronously
              showToasterrorborder("No data found", context);
            }
          }
        }
      } else {
        // Show error message if response status code is not 200
        if (context != null) {
          // ignore: use_build_context_synchronously
          if (kDebugMode) {
            print("Error: ${response.body}");
          }
        }
      }
    } catch (error) {
      // Show error message for any caught exception
      if (context != null) {
        // ignore: use_build_context_synchronously
        if (kDebugMode) {
          print("Error: $error");
        }
      }
    } finally {
      // Set isLoading to false after completing fetch operation
      isLoading.value = false;
    }
  }

  void updateUIWithQuestionData(MyQuestionQuestions blogData) {
    title.value.text = blogData.title ?? '';

    isCategorySelectedList.clear();
    for (var category in categorylist) {
      bool isSelected = blogData.category == (category.id.toString());
      isCategorySelectedList.add(isSelected);
    }

    isSubCategorySelectedList.clear();
    for (var subcategory in subcategoryList) {
      bool isSelected = blogData.subcategory == (subcategory.id.toString());
      isSubCategorySelectedList.add(isSelected);
    }
  }

  Future<void> fetchCategoryList() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        final response = await http
            .get(Uri.parse('${Constants.baseUrl}${Constants.getcategorylist}'));

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Response body: $jsonBody");
          }

          final categoryListEntity = GetCategoryEntity.fromJson(jsonBody);

          if (categoryListEntity.status == 1) {
            if (kDebugMode) {
              print("category list fetched successfully");
            }

            categorylist.value = categoryListEntity.category ?? [];
            isCategorySelectedList
                .assignAll(List<bool>.filled(categorylist.length, false));
            if (categorylist.isNotEmpty) {
              // Fetch subcategories for the first category by default
              fetchSubCategoryList(categorylist[0].id!);
            }
            if (kDebugMode) {
              print("category list: $categorylist");
            }
          } else {
            // Handle error when status is not 1
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to fetch category list. Status code: ${response.statusCode}");
          }
        }
      } else {
        //
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }
    }
  }

  Future<void> fetchSubCategoryList(int categoryId) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        final uri =
            Uri.parse('${Constants.baseUrl}${Constants.getsubcategorylist}')
                .replace(
                    queryParameters: {'category_id': categoryId.toString()});
        final response = await http.get(uri);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Subcategory response body: $jsonBody");
          }

          final subCategoryListEntity = GetSubCategoryEntity.fromJson(jsonBody);

          if (subCategoryListEntity.status == 1) {
            if (kDebugMode) {
              print("Subcategory list fetched successfully");
            }

            subcategoryList.value = subCategoryListEntity.category ?? [];
            isSubCategorySelectedList
                .assignAll(List<bool>.filled(subcategoryList.length, false));
            if (kDebugMode) {
              print("Subcategory list: $subcategoryList");
            }
          } else {
            // Handle error when status is not 1
            if (kDebugMode) {
              print(
                  "Failed to fetch subcategory list, status: ${subCategoryListEntity.status}");
            }
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to fetch subcategory list. Status code: ${response.statusCode}");
          }
        }
      } else {
        //
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }
    }
  }

  // Category
  void toggleCategorySelected(int index, BuildContext context) {
    // Unselect all categories
    for (int i = 0; i < isCategorySelectedList.length; i++) {
      isCategorySelectedList[i] = false;
    }

    // Select the current category
    isCategorySelectedList[index] = true;
    selectedCountCategory.value = 1;
    selectedCategoryId.value = categorylist[index].id!;

    // Fetch subcategory list for the selected category
    fetchSubCategoryList(categorylist[index].id!);

    // ignore: unrelated_type_equality_checks
    categoryError.value = selectedCountCategory == 0;

    isCategoryTyping.value = true;
  }

  TextEditingController getSelectedCategoryTextController() {
    List<String> selectedCategoryNames = [];

    for (int i = 0; i < isCategorySelectedList.length; i++) {
      if (isCategorySelectedList[i]) {
        selectedCategoryNames.add(categorylist[i].name ?? '');
      }
    }

    return TextEditingController(text: selectedCategoryNames.join(', '));
  }

  void mlmCategoryValidation() {
    // ignore: unrelated_type_equality_checks
    categoryError.value = selectedCountCategory == 0;

    if (categoryError.value) {
      isCategoryTyping.value = true;
    }
  }

  // sub Category
  void toggleSubCategorySelected(int index) {
    bool isCurrentlySelected = isSubCategorySelectedList[index];

    // Unselect all subcategories
    for (int i = 0; i < isSubCategorySelectedList.length; i++) {
      isSubCategorySelectedList[i] = false;
    }

    // Toggle the selected state of the current subcategory
    isSubCategorySelectedList[index] = !isCurrentlySelected;
    selectedCountSubCategory.value = isSubCategorySelectedList[index] ? 1 : 0;
    selectedSubCategoryId.value = subcategoryList[index].id!;

    // ignore: unrelated_type_equality_checks
    subCategoryError.value = selectedCountSubCategory == 0;

    isSubCategoryTyping.value = true;
  }

  TextEditingController getSelectedSubCategoryTextController() {
    List<String> selectedSubCategoryNames = [];
    for (int i = 0; i < isSubCategorySelectedList.length; i++) {
      if (isSubCategorySelectedList[i]) {
        selectedSubCategoryNames.add(subcategoryList[i].name ?? '');
      }
    }

    return TextEditingController(text: selectedSubCategoryNames.join(', '));
  }

  void mlmsubCategoryValidation() {
    // ignore: unrelated_type_equality_checks
    subCategoryError.value = selectedCountSubCategory == 0;

    if (subCategoryError.value) {
      isSubCategoryTyping.value = true;
    }
  }

  Future<void> addQuestion({required File? imageFile, context}) async {
    isLoading(true);
    String device = '';
    if (Platform.isAndroid) {
      device = 'android';
    } else if (Platform.isIOS) {
      device = 'ios';
    }
    if (kDebugMode) {
      print('Device Name: $device');
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        // Create a multipart request
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${Constants.baseUrl}${Constants.addquestionanswer}'),
        );

        // Add fields
        request.fields['device'] = device;
        request.fields['title'] = title.value.text;
        request.fields['description'] = answer.value.text;
        request.fields['category'] = selectedCategoryId.value.toString();
        request.fields['subcategory'] = selectedSubCategoryId.value.toString();
        request.fields['api_token'] = apiToken ?? '';

        // Send request
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("Response body: $jsonBody");
          }
          // Check if all fields in the response are true (you may need to adjust this condition based on the actual response structure)
          if (jsonBody['success'] == true) {
            toastification.show(
              context: context,
              alignment: Alignment.bottomCenter,
              backgroundColor: AppColors.white,
              type: ToastificationType.success,
              style: ToastificationStyle.flatColored,
              showProgressBar: false,
              autoCloseDuration: const Duration(seconds: 3),
              icon: Image.asset(
                Assets.imagesChecked,
                height: 35,
              ),
              primaryColor: Colors.green,
              title: const Text('Your Question is Successfully Submitted'),
            );
            getQuestion(1);
            clearFormFields();
            Get.back();
          } else if (jsonBody['status'] == 0) {
            toastification.show(
              context: context,
              alignment: Alignment.bottomCenter,
              backgroundColor: AppColors.white,
              type: ToastificationType.error,
              style: ToastificationStyle.flatColored,
              showProgressBar: false,
              autoCloseDuration: const Duration(seconds: 3),
              icon: Image.asset(
                Assets.imagesCancel,
                height: 35,
              ),
              primaryColor: Colors.red,
              title: Text('${jsonBody['message']}'),
            );
          }
        } else {
          if (kDebugMode) {
            print(
                "HTTP error: Failed to save company details. Status code: ${response.statusCode}");
            print("Response body: ${response.body}");
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred while saving company details: $e");
      }
    } finally {
      clearFormFields();
    }
  }

  void clearFormFields() {
    title.value.clear();
    categorylist.clear();
    subcategoryList.clear();
  }

  // like_list_question
  Future<void> fetchLikeListQuestion(int questionId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);
    String device = Platform.isAndroid ? 'android' : 'ios';

    isLoading(true);
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // Log connectivity result
      if (kDebugMode) {
        print('Connectivity result: $connectivityResult');
      }

      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.likelistquestion}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['question_id'] = questionId.toString();

        // Log request details
        if (kDebugMode) {
          print('Request URL: $uri');
          print('Request fields: ${request.fields}');
        }

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        // Log response status code
        if (kDebugMode) {
          print('Response status code: ${response.statusCode}');
        }

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var status = data['status'];

          // Log response body
          if (kDebugMode) {
            print('Response body: ${response.body}');
          }

          if (status == 1) {
            var questionLikeListEntity = QuestionLikeListEntity.fromJson(data);
            questionLikeList.value = questionLikeListEntity.data ?? [];

            // Log parsed data
            if (kDebugMode) {
              print('Parsed entity: $questionLikeListEntity');
            }
          } else {
            var message = data['message'];

            // Log failure message
            if (kDebugMode) {
              print('Failed to fetch likelist Question: $message');
            }
          }
        } else {
          // Log error response
          if (kDebugMode) {
            print('Error: ${response.body}');
          }
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      // Log exception
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isLoading(false);
      // Log end of method execution
      if (kDebugMode) {
        print('Finished fetchLikeListBlog method');
      }
    }
  }

  //liked Question
  Future<void> likedQuestion(int questionId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.likedquestion}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['question_id'] = questionId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var likedBlogEntity = QuestionLikeEntity.fromJson(data);
          var message = likedBlogEntity.message;

          // Update the liked status and like count based on the message
          if (message == 'You have liked this Question') {
            likedStatusMap[questionId] = true;
            likeCountMap[questionId] = (likeCountMap[questionId] ?? 0) + 1;
          } else if (message == 'You have unliked this Question') {
            likedStatusMap[questionId] = false;
            likeCountMap[questionId] = (likeCountMap[questionId] ?? 0) - 1;
          }

          showToastverifedborder(message!, context);
        } else {
          showToasterrorborder("Error: ${response.body}", context);
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

  //liked Question
  Future<void> likedAnswers(int answerId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri = Uri.parse('${Constants.baseUrl}${Constants.likedanswer}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['answer_id'] = answerId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var likeAnswerdEntity = AnswerLikedEntity.fromJson(data);
          var message = likeAnswerdEntity.message;

          // Update the liked status and like count based on the message
          if (message == 'You have liked this Answer') {
            answerlikedStatusMap[answerId] = true;
            answerlikeCountMap[answerId] = (likeCountMap[answerId] ?? 0) + 1;
          } else if (message == 'You have unliked this Answer') {
            answerlikedStatusMap[answerId] = false;
            answerlikeCountMap[answerId] = (likeCountMap[answerId] ?? 0) - 1;
          }

          showToastverifedborder(message!, context);
        } else {
          showToasterrorborder("Error: ${response.body}", context);
        }
      } else {
        showToasterrorborder("No internet connection", context);
      }
    } catch (e) {
      if (kDebugMode) {
        print(
          "Error: $e",
        );
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleanswerLike(int answerId, context) async {
    bool isLiked = answerlikedStatusMap[answerId] ?? false;
    isLiked = !isLiked;
    answerlikedStatusMap[answerId] = isLiked;
    answerlikeCountMap.update(
        answerId, (value) => isLiked ? value + 1 : value - 1,
        ifAbsent: () => isLiked ? 1 : 0);

    await likedAnswers(answerId, context);
  }

  // Bookmark
  Future<void> questionBookmark(int questionId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs.getString(Constants.accessToken);

    String device = Platform.isAndroid ? 'android' : 'ios';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult != ConnectivityResult.none) {
        var uri =
            Uri.parse('${Constants.baseUrl}${Constants.questionBookmark}');
        var request = http.MultipartRequest('POST', uri);

        request.fields['api_token'] = apiToken ?? '';
        request.fields['device'] = device;
        request.fields['question_id'] = questionId.toString();

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var bookmarkQuestionEntity =
              AddFaviouriteQuestionEntity.fromJson(data);
          var message = bookmarkQuestionEntity.message;

          // Update the liked status and like count based on the message
          if (message == 'You have bookmark this Question') {
            bookmarkStatusMap[questionId] = true;
            bookmarkCountMap[questionId] =
                (bookmarkCountMap[questionId] ?? 0) + 1;
          } else if (message == 'You have unbookmark this Question') {
            bookmarkStatusMap[questionId] = false;
            bookmarkCountMap[questionId] =
                (bookmarkCountMap[questionId] ?? 0) - 1;
          }

          showToastverifedborder(message!, context);
        } else {
          if (kDebugMode) {
            print('Error: ${response.body}');
          }
        }
      } else {
        showToastverifedborder('No internet connection', context);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleLike(int questionId, context) async {
    bool isLiked = likedStatusMap[questionId] ?? false;
    isLiked = !isLiked;
    likedStatusMap[questionId] = isLiked;
    likeCountMap.update(questionId, (value) => isLiked ? value + 1 : value - 1,
        ifAbsent: () => isLiked ? 1 : 0);

    await likedQuestion(questionId, context);
  }

  Future<void> toggleBookMark(int questionId, context) async {
    bool isBookmark = bookmarkStatusMap[questionId] ?? false;
    isBookmark = !isBookmark;
    bookmarkStatusMap[questionId] = isBookmark;
    bookmarkCountMap.update(
        questionId, (value) => isBookmark ? value + 1 : value - 1,
        ifAbsent: () => isBookmark ? 1 : 0);

    await questionBookmark(questionId, context);
  }

  void titleValidation(context) {
    String enteredTitle = title.value.text;
    if (enteredTitle.isEmpty || hasSpecialCharactersOrNumbers(enteredTitle)) {
      titleError.value = true;
    } else {
      titleError.value = false;
    }

    if (titleError.value) {
      isTitleTyping.value = true;
    }
  }

  void answerValidation(context) {
    String enteredDiscription = answer.value.text;
    if (enteredDiscription.isEmpty ||
        hasSpecialTextOrNumbers(enteredDiscription)) {
      showToasterrorborder("Please Enter Answer", context);
      answerError.value = true;
    } else {
      answerError.value = false;
    }
  }

  bool hasSpecialCharactersOrNumbers(String text) {
    RegExp specialCharOrNumber = RegExp(r'[!@#\$&*()]|[0-9]');
    return specialCharOrNumber.hasMatch(text);
  }

  bool hasSpecialTextOrNumbers(String text) {
    RegExp alphanumericRegex = RegExp(r'[a-zA-Z0-9]');
    return !alphanumericRegex.hasMatch(text);
  }
}
