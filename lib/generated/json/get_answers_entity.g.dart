import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_answers_entity.dart';

GetAnswersEntity $GetAnswersEntityFromJson(Map<String, dynamic> json) {
  final GetAnswersEntity getAnswersEntity = GetAnswersEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getAnswersEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getAnswersEntity.message = message;
  }
  final List<GetAnswersAnswers>? answers = (json['answers'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<GetAnswersAnswers>(e) as GetAnswersAnswers)
      .toList();
  if (answers != null) {
    getAnswersEntity.answers = answers;
  }
  return getAnswersEntity;
}

Map<String, dynamic> $GetAnswersEntityToJson(GetAnswersEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['answers'] = entity.answers?.map((v) => v.toJson()).toList();
  return data;
}

extension GetAnswersEntityExtension on GetAnswersEntity {
  GetAnswersEntity copyWith({
    int? status,
    String? message,
    List<GetAnswersAnswers>? answers,
  }) {
    return GetAnswersEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..answers = answers ?? this.answers;
  }
}

GetAnswersAnswers $GetAnswersAnswersFromJson(Map<String, dynamic> json) {
  final GetAnswersAnswers getAnswersAnswers = GetAnswersAnswers();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getAnswersAnswers.id = id;
  }
  final String? ansTitle = jsonConvert.convert<String>(json['ans_title']);
  if (ansTitle != null) {
    getAnswersAnswers.ansTitle = ansTitle;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getAnswersAnswers.createdate = createdate;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    getAnswersAnswers.userId = userId;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getAnswersAnswers.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getAnswersAnswers.userimage = userimage;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    getAnswersAnswers.totallike = totallike;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    getAnswersAnswers.likedByUser = likedByUser;
  }
  final List<GetAnswersAnswersComments>? comments = (json['comments'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetAnswersAnswersComments>(
          e) as GetAnswersAnswersComments).toList();
  if (comments != null) {
    getAnswersAnswers.comments = comments;
  }
  return getAnswersAnswers;
}

Map<String, dynamic> $GetAnswersAnswersToJson(GetAnswersAnswers entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ans_title'] = entity.ansTitle;
  data['createdate'] = entity.createdate;
  data['user_id'] = entity.userId;
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['totallike'] = entity.totallike;
  data['liked_by_user'] = entity.likedByUser;
  data['comments'] = entity.comments?.map((v) => v.toJson()).toList();
  return data;
}

extension GetAnswersAnswersExtension on GetAnswersAnswers {
  GetAnswersAnswers copyWith({
    int? id,
    String? ansTitle,
    String? createdate,
    int? userId,
    String? name,
    String? userimage,
    int? totallike,
    bool? likedByUser,
    List<GetAnswersAnswersComments>? comments,
  }) {
    return GetAnswersAnswers()
      ..id = id ?? this.id
      ..ansTitle = ansTitle ?? this.ansTitle
      ..createdate = createdate ?? this.createdate
      ..userId = userId ?? this.userId
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..totallike = totallike ?? this.totallike
      ..likedByUser = likedByUser ?? this.likedByUser
      ..comments = comments ?? this.comments;
  }
}

GetAnswersAnswersComments $GetAnswersAnswersCommentsFromJson(
    Map<String, dynamic> json) {
  final GetAnswersAnswersComments getAnswersAnswersComments = GetAnswersAnswersComments();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getAnswersAnswersComments.id = id;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    getAnswersAnswersComments.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getAnswersAnswersComments.createdate = createdate;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    getAnswersAnswersComments.userid = userid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getAnswersAnswersComments.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getAnswersAnswersComments.userimage = userimage;
  }
  final List<
      GetAnswersAnswersCommentsReplies>? replies = (json['replies'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetAnswersAnswersCommentsReplies>(
          e) as GetAnswersAnswersCommentsReplies).toList();
  if (replies != null) {
    getAnswersAnswersComments.replies = replies;
  }
  return getAnswersAnswersComments;
}

Map<String, dynamic> $GetAnswersAnswersCommentsToJson(
    GetAnswersAnswersComments entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['comment'] = entity.comment;
  data['createdate'] = entity.createdate;
  data['userid'] = entity.userid;
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['replies'] = entity.replies?.map((v) => v.toJson()).toList();
  return data;
}

extension GetAnswersAnswersCommentsExtension on GetAnswersAnswersComments {
  GetAnswersAnswersComments copyWith({
    int? id,
    String? comment,
    String? createdate,
    int? userid,
    String? name,
    String? userimage,
    List<GetAnswersAnswersCommentsReplies>? replies,
  }) {
    return GetAnswersAnswersComments()
      ..id = id ?? this.id
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..userid = userid ?? this.userid
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..replies = replies ?? this.replies;
  }
}

GetAnswersAnswersCommentsReplies $GetAnswersAnswersCommentsRepliesFromJson(
    Map<String, dynamic> json) {
  final GetAnswersAnswersCommentsReplies getAnswersAnswersCommentsReplies = GetAnswersAnswersCommentsReplies();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getAnswersAnswersCommentsReplies.id = id;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    getAnswersAnswersCommentsReplies.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getAnswersAnswersCommentsReplies.createdate = createdate;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    getAnswersAnswersCommentsReplies.userid = userid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getAnswersAnswersCommentsReplies.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getAnswersAnswersCommentsReplies.userimage = userimage;
  }
  final List<
      GetAnswersAnswersCommentsRepliesReplies>? replies = (json['replies'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetAnswersAnswersCommentsRepliesReplies>(
          e) as GetAnswersAnswersCommentsRepliesReplies).toList();
  if (replies != null) {
    getAnswersAnswersCommentsReplies.replies = replies;
  }
  return getAnswersAnswersCommentsReplies;
}

Map<String, dynamic> $GetAnswersAnswersCommentsRepliesToJson(
    GetAnswersAnswersCommentsReplies entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['comment'] = entity.comment;
  data['createdate'] = entity.createdate;
  data['userid'] = entity.userid;
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['replies'] = entity.replies?.map((v) => v.toJson()).toList();
  return data;
}

extension GetAnswersAnswersCommentsRepliesExtension on GetAnswersAnswersCommentsReplies {
  GetAnswersAnswersCommentsReplies copyWith({
    int? id,
    String? comment,
    String? createdate,
    int? userid,
    String? name,
    String? userimage,
    List<GetAnswersAnswersCommentsRepliesReplies>? replies,
  }) {
    return GetAnswersAnswersCommentsReplies()
      ..id = id ?? this.id
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..userid = userid ?? this.userid
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..replies = replies ?? this.replies;
  }
}

GetAnswersAnswersCommentsRepliesReplies $GetAnswersAnswersCommentsRepliesRepliesFromJson(
    Map<String, dynamic> json) {
  final GetAnswersAnswersCommentsRepliesReplies getAnswersAnswersCommentsRepliesReplies = GetAnswersAnswersCommentsRepliesReplies();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getAnswersAnswersCommentsRepliesReplies.id = id;
  }
  final String? comment = jsonConvert.convert<String>(json['comment']);
  if (comment != null) {
    getAnswersAnswersCommentsRepliesReplies.comment = comment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getAnswersAnswersCommentsRepliesReplies.createdate = createdate;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    getAnswersAnswersCommentsRepliesReplies.userid = userid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getAnswersAnswersCommentsRepliesReplies.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getAnswersAnswersCommentsRepliesReplies.userimage = userimage;
  }
  final List<dynamic>? replies = (json['replies'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (replies != null) {
    getAnswersAnswersCommentsRepliesReplies.replies = replies;
  }
  return getAnswersAnswersCommentsRepliesReplies;
}

Map<String, dynamic> $GetAnswersAnswersCommentsRepliesRepliesToJson(
    GetAnswersAnswersCommentsRepliesReplies entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['comment'] = entity.comment;
  data['createdate'] = entity.createdate;
  data['userid'] = entity.userid;
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['replies'] = entity.replies;
  return data;
}

extension GetAnswersAnswersCommentsRepliesRepliesExtension on GetAnswersAnswersCommentsRepliesReplies {
  GetAnswersAnswersCommentsRepliesReplies copyWith({
    int? id,
    String? comment,
    String? createdate,
    int? userid,
    String? name,
    String? userimage,
    List<dynamic>? replies,
  }) {
    return GetAnswersAnswersCommentsRepliesReplies()
      ..id = id ?? this.id
      ..comment = comment ?? this.comment
      ..createdate = createdate ?? this.createdate
      ..userid = userid ?? this.userid
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..replies = replies ?? this.replies;
  }
}