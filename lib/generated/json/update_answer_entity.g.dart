import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/update_answer_entity.dart';

UpdateAnswerEntity $UpdateAnswerEntityFromJson(Map<String, dynamic> json) {
  final UpdateAnswerEntity updateAnswerEntity = UpdateAnswerEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    updateAnswerEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    updateAnswerEntity.message = message;
  }
  final UpdateAnswerAnswer? answer = jsonConvert.convert<UpdateAnswerAnswer>(
      json['answer']);
  if (answer != null) {
    updateAnswerEntity.answer = answer;
  }
  return updateAnswerEntity;
}

Map<String, dynamic> $UpdateAnswerEntityToJson(UpdateAnswerEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['answer'] = entity.answer?.toJson();
  return data;
}

extension UpdateAnswerEntityExtension on UpdateAnswerEntity {
  UpdateAnswerEntity copyWith({
    int? status,
    String? message,
    UpdateAnswerAnswer? answer,
  }) {
    return UpdateAnswerEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..answer = answer ?? this.answer;
  }
}

UpdateAnswerAnswer $UpdateAnswerAnswerFromJson(Map<String, dynamic> json) {
  final UpdateAnswerAnswer updateAnswerAnswer = UpdateAnswerAnswer();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    updateAnswerAnswer.id = id;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    updateAnswerAnswer.userId = userId;
  }
  final int? qusid = jsonConvert.convert<int>(json['qusid']);
  if (qusid != null) {
    updateAnswerAnswer.qusid = qusid;
  }
  final String? ansTitle = jsonConvert.convert<String>(json['ans_title']);
  if (ansTitle != null) {
    updateAnswerAnswer.ansTitle = ansTitle;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    updateAnswerAnswer.createdate = createdate;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    updateAnswerAnswer.datemodified = datemodified;
  }
  final String? mainQustion = jsonConvert.convert<String>(json['main_qustion']);
  if (mainQustion != null) {
    updateAnswerAnswer.mainQustion = mainQustion;
  }
  final String? ansquestion = jsonConvert.convert<String>(json['ansquestion']);
  if (ansquestion != null) {
    updateAnswerAnswer.ansquestion = ansquestion;
  }
  final String? pgcnt = jsonConvert.convert<String>(json['pgcnt']);
  if (pgcnt != null) {
    updateAnswerAnswer.pgcnt = pgcnt;
  }
  return updateAnswerAnswer;
}

Map<String, dynamic> $UpdateAnswerAnswerToJson(UpdateAnswerAnswer entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['user_id'] = entity.userId;
  data['qusid'] = entity.qusid;
  data['ans_title'] = entity.ansTitle;
  data['createdate'] = entity.createdate;
  data['datemodified'] = entity.datemodified;
  data['main_qustion'] = entity.mainQustion;
  data['ansquestion'] = entity.ansquestion;
  data['pgcnt'] = entity.pgcnt;
  return data;
}

extension UpdateAnswerAnswerExtension on UpdateAnswerAnswer {
  UpdateAnswerAnswer copyWith({
    int? id,
    int? userId,
    int? qusid,
    String? ansTitle,
    String? createdate,
    String? datemodified,
    String? mainQustion,
    String? ansquestion,
    String? pgcnt,
  }) {
    return UpdateAnswerAnswer()
      ..id = id ?? this.id
      ..userId = userId ?? this.userId
      ..qusid = qusid ?? this.qusid
      ..ansTitle = ansTitle ?? this.ansTitle
      ..createdate = createdate ?? this.createdate
      ..datemodified = datemodified ?? this.datemodified
      ..mainQustion = mainQustion ?? this.mainQustion
      ..ansquestion = ansquestion ?? this.ansquestion
      ..pgcnt = pgcnt ?? this.pgcnt;
  }
}