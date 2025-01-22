import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/my_question_entity.dart';

MyQuestionEntity $MyQuestionEntityFromJson(Map<String, dynamic> json) {
  final MyQuestionEntity myQuestionEntity = MyQuestionEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    myQuestionEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    myQuestionEntity.message = message;
  }
  final List<MyQuestionQuestions>? questions = (json['questions'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<MyQuestionQuestions>(e) as MyQuestionQuestions)
      .toList();
  if (questions != null) {
    myQuestionEntity.questions = questions;
  }
  return myQuestionEntity;
}

Map<String, dynamic> $MyQuestionEntityToJson(MyQuestionEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['questions'] = entity.questions?.map((v) => v.toJson()).toList();
  return data;
}

extension MyQuestionEntityExtension on MyQuestionEntity {
  MyQuestionEntity copyWith({
    int? status,
    String? message,
    List<MyQuestionQuestions>? questions,
  }) {
    return MyQuestionEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..questions = questions ?? this.questions;
  }
}

MyQuestionQuestions $MyQuestionQuestionsFromJson(Map<String, dynamic> json) {
  final MyQuestionQuestions myQuestionQuestions = MyQuestionQuestions();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    myQuestionQuestions.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    myQuestionQuestions.title = title;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    myQuestionQuestions.category = category;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    myQuestionQuestions.subcategory = subcategory;
  }
  final String? creatdate = jsonConvert.convert<String>(json['creatdate']);
  if (creatdate != null) {
    myQuestionQuestions.creatdate = creatdate;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    myQuestionQuestions.userId = userId;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    myQuestionQuestions.pgcnt = pgcnt;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    myQuestionQuestions.totallike = totallike;
  }
  final int? totalbookmark = jsonConvert.convert<int>(json['totalbookmark']);
  if (totalbookmark != null) {
    myQuestionQuestions.totalbookmark = totalbookmark;
  }
  final int? totalquestionAnswer = jsonConvert.convert<int>(
      json['totalquestion_answer']);
  if (totalquestionAnswer != null) {
    myQuestionQuestions.totalquestionAnswer = totalquestionAnswer;
  }
  final int? userliked = jsonConvert.convert<int>(json['userliked']);
  if (userliked != null) {
    myQuestionQuestions.userliked = userliked;
  }
  final int? userbookmarked = jsonConvert.convert<int>(json['userbookmarked']);
  if (userbookmarked != null) {
    myQuestionQuestions.userbookmarked = userbookmarked;
  }
  final MyQuestionQuestionsUserData? userData = jsonConvert.convert<
      MyQuestionQuestionsUserData>(json['user_data']);
  if (userData != null) {
    myQuestionQuestions.userData = userData;
  }
  final String? fullUrl = jsonConvert.convert<String>(json['full_url']);
  if (fullUrl != null) {
    myQuestionQuestions.fullUrl = fullUrl;
  }
  return myQuestionQuestions;
}

Map<String, dynamic> $MyQuestionQuestionsToJson(MyQuestionQuestions entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['category'] = entity.category;
  data['subcategory'] = entity.subcategory;
  data['creatdate'] = entity.creatdate;
  data['user_id'] = entity.userId;
  data['pgcnt'] = entity.pgcnt;
  data['totallike'] = entity.totallike;
  data['totalbookmark'] = entity.totalbookmark;
  data['totalquestion_answer'] = entity.totalquestionAnswer;
  data['userliked'] = entity.userliked;
  data['userbookmarked'] = entity.userbookmarked;
  data['user_data'] = entity.userData?.toJson();
  data['full_url'] = entity.fullUrl;
  return data;
}

extension MyQuestionQuestionsExtension on MyQuestionQuestions {
  MyQuestionQuestions copyWith({
    int? id,
    String? title,
    String? category,
    String? subcategory,
    String? creatdate,
    int? userId,
    int? pgcnt,
    int? totallike,
    int? totalbookmark,
    int? totalquestionAnswer,
    int? userliked,
    int? userbookmarked,
    MyQuestionQuestionsUserData? userData,
    String? fullUrl,
  }) {
    return MyQuestionQuestions()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..category = category ?? this.category
      ..subcategory = subcategory ?? this.subcategory
      ..creatdate = creatdate ?? this.creatdate
      ..userId = userId ?? this.userId
      ..pgcnt = pgcnt ?? this.pgcnt
      ..totallike = totallike ?? this.totallike
      ..totalbookmark = totalbookmark ?? this.totalbookmark
      ..totalquestionAnswer = totalquestionAnswer ?? this.totalquestionAnswer
      ..userliked = userliked ?? this.userliked
      ..userbookmarked = userbookmarked ?? this.userbookmarked
      ..userData = userData ?? this.userData
      ..fullUrl = fullUrl ?? this.fullUrl;
  }
}

MyQuestionQuestionsUserData $MyQuestionQuestionsUserDataFromJson(
    Map<String, dynamic> json) {
  final MyQuestionQuestionsUserData myQuestionQuestionsUserData = MyQuestionQuestionsUserData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    myQuestionQuestionsUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    myQuestionQuestionsUserData.userimage = userimage;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    myQuestionQuestionsUserData.id = id;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    myQuestionQuestionsUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    myQuestionQuestionsUserData.imageThumPath = imageThumPath;
  }
  return myQuestionQuestionsUserData;
}

Map<String, dynamic> $MyQuestionQuestionsUserDataToJson(
    MyQuestionQuestionsUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['id'] = entity.id;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension MyQuestionQuestionsUserDataExtension on MyQuestionQuestionsUserData {
  MyQuestionQuestionsUserData copyWith({
    String? name,
    String? userimage,
    int? id,
    String? imagePath,
    String? imageThumPath,
  }) {
    return MyQuestionQuestionsUserData()
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..id = id ?? this.id
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}