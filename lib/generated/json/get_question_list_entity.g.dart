import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_question_list_entity.dart';

GetQuestionListEntity $GetQuestionListEntityFromJson(
    Map<String, dynamic> json) {
  final GetQuestionListEntity getQuestionListEntity = GetQuestionListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getQuestionListEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getQuestionListEntity.message = message;
  }
  final List<GetQuestionListQuestions>? questions = (json['questions'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetQuestionListQuestions>(
          e) as GetQuestionListQuestions).toList();
  if (questions != null) {
    getQuestionListEntity.questions = questions;
  }
  return getQuestionListEntity;
}

Map<String, dynamic> $GetQuestionListEntityToJson(
    GetQuestionListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['questions'] = entity.questions?.map((v) => v.toJson()).toList();
  return data;
}

extension GetQuestionListEntityExtension on GetQuestionListEntity {
  GetQuestionListEntity copyWith({
    int? status,
    String? message,
    List<GetQuestionListQuestions>? questions,
  }) {
    return GetQuestionListEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..questions = questions ?? this.questions;
  }
}

GetQuestionListQuestions $GetQuestionListQuestionsFromJson(
    Map<String, dynamic> json) {
  final GetQuestionListQuestions getQuestionListQuestions = GetQuestionListQuestions();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getQuestionListQuestions.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getQuestionListQuestions.title = title;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    getQuestionListQuestions.category = category;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    getQuestionListQuestions.subcategory = subcategory;
  }
  final String? creatdate = jsonConvert.convert<String>(json['creatdate']);
  if (creatdate != null) {
    getQuestionListQuestions.creatdate = creatdate;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    getQuestionListQuestions.userId = userId;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    getQuestionListQuestions.pgcnt = pgcnt;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    getQuestionListQuestions.totallike = totallike;
  }
  final int? totalbookmark = jsonConvert.convert<int>(json['totalbookmark']);
  if (totalbookmark != null) {
    getQuestionListQuestions.totalbookmark = totalbookmark;
  }
  final int? totalquestionAnswer = jsonConvert.convert<int>(
      json['totalquestion_answer']);
  if (totalquestionAnswer != null) {
    getQuestionListQuestions.totalquestionAnswer = totalquestionAnswer;
  }
  final GetQuestionListQuestionsUserData? userData = jsonConvert.convert<
      GetQuestionListQuestionsUserData>(json['user_data']);
  if (userData != null) {
    getQuestionListQuestions.userData = userData;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    getQuestionListQuestions.likedByUser = likedByUser;
  }
  final bool? bookmarkedByUser = jsonConvert.convert<bool>(
      json['bookmarked_by_user']);
  if (bookmarkedByUser != null) {
    getQuestionListQuestions.bookmarkedByUser = bookmarkedByUser;
  }
  return getQuestionListQuestions;
}

Map<String, dynamic> $GetQuestionListQuestionsToJson(
    GetQuestionListQuestions entity) {
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
  data['user_data'] = entity.userData?.toJson();
  data['liked_by_user'] = entity.likedByUser;
  data['bookmarked_by_user'] = entity.bookmarkedByUser;
  return data;
}

extension GetQuestionListQuestionsExtension on GetQuestionListQuestions {
  GetQuestionListQuestions copyWith({
    int? id,
    String? title,
    String? category,
    String? subcategory,
    String? creatdate,
    String? userId,
    int? pgcnt,
    int? totallike,
    int? totalbookmark,
    int? totalquestionAnswer,
    GetQuestionListQuestionsUserData? userData,
    bool? likedByUser,
    bool? bookmarkedByUser,
  }) {
    return GetQuestionListQuestions()
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
      ..userData = userData ?? this.userData
      ..likedByUser = likedByUser ?? this.likedByUser
      ..bookmarkedByUser = bookmarkedByUser ?? this.bookmarkedByUser;
  }
}

GetQuestionListQuestionsUserData $GetQuestionListQuestionsUserDataFromJson(
    Map<String, dynamic> json) {
  final GetQuestionListQuestionsUserData getQuestionListQuestionsUserData = GetQuestionListQuestionsUserData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getQuestionListQuestionsUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getQuestionListQuestionsUserData.userimage = userimage;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getQuestionListQuestionsUserData.id = id;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getQuestionListQuestionsUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getQuestionListQuestionsUserData.imageThumPath = imageThumPath;
  }
  return getQuestionListQuestionsUserData;
}

Map<String, dynamic> $GetQuestionListQuestionsUserDataToJson(
    GetQuestionListQuestionsUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['id'] = entity.id;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension GetQuestionListQuestionsUserDataExtension on GetQuestionListQuestionsUserData {
  GetQuestionListQuestionsUserData copyWith({
    String? name,
    String? userimage,
    int? id,
    String? imagePath,
    String? imageThumPath,
  }) {
    return GetQuestionListQuestionsUserData()
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..id = id ?? this.id
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}