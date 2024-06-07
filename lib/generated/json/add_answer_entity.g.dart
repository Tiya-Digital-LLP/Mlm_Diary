import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/add_answer_entity.dart';

AddAnswerEntity $AddAnswerEntityFromJson(Map<String, dynamic> json) {
  final AddAnswerEntity addAnswerEntity = AddAnswerEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    addAnswerEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    addAnswerEntity.message = message;
  }
  final AddAnswerAnswer? answer = jsonConvert.convert<AddAnswerAnswer>(
      json['answer']);
  if (answer != null) {
    addAnswerEntity.answer = answer;
  }
  return addAnswerEntity;
}

Map<String, dynamic> $AddAnswerEntityToJson(AddAnswerEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['answer'] = entity.answer?.toJson();
  return data;
}

extension AddAnswerEntityExtension on AddAnswerEntity {
  AddAnswerEntity copyWith({
    int? status,
    String? message,
    AddAnswerAnswer? answer,
  }) {
    return AddAnswerEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..answer = answer ?? this.answer;
  }
}

AddAnswerAnswer $AddAnswerAnswerFromJson(Map<String, dynamic> json) {
  final AddAnswerAnswer addAnswerAnswer = AddAnswerAnswer();
  final String? qusid = jsonConvert.convert<String>(json['qusid']);
  if (qusid != null) {
    addAnswerAnswer.qusid = qusid;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    addAnswerAnswer.userId = userId;
  }
  final String? ansTitle = jsonConvert.convert<String>(json['ans_title']);
  if (ansTitle != null) {
    addAnswerAnswer.ansTitle = ansTitle;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    addAnswerAnswer.createdate = createdate;
  }
  final String? mainQustion = jsonConvert.convert<String>(json['main_qustion']);
  if (mainQustion != null) {
    addAnswerAnswer.mainQustion = mainQustion;
  }
  final String? ansquestion = jsonConvert.convert<String>(json['ansquestion']);
  if (ansquestion != null) {
    addAnswerAnswer.ansquestion = ansquestion;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    addAnswerAnswer.datemodified = datemodified;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    addAnswerAnswer.id = id;
  }
  return addAnswerAnswer;
}

Map<String, dynamic> $AddAnswerAnswerToJson(AddAnswerAnswer entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['qusid'] = entity.qusid;
  data['user_id'] = entity.userId;
  data['ans_title'] = entity.ansTitle;
  data['createdate'] = entity.createdate;
  data['main_qustion'] = entity.mainQustion;
  data['ansquestion'] = entity.ansquestion;
  data['datemodified'] = entity.datemodified;
  data['id'] = entity.id;
  return data;
}

extension AddAnswerAnswerExtension on AddAnswerAnswer {
  AddAnswerAnswer copyWith({
    String? qusid,
    int? userId,
    String? ansTitle,
    String? createdate,
    String? mainQustion,
    String? ansquestion,
    String? datemodified,
    int? id,
  }) {
    return AddAnswerAnswer()
      ..qusid = qusid ?? this.qusid
      ..userId = userId ?? this.userId
      ..ansTitle = ansTitle ?? this.ansTitle
      ..createdate = createdate ?? this.createdate
      ..mainQustion = mainQustion ?? this.mainQustion
      ..ansquestion = ansquestion ?? this.ansquestion
      ..datemodified = datemodified ?? this.datemodified
      ..id = id ?? this.id;
  }
}