import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/answer_liked_entity.dart';

AnswerLikedEntity $AnswerLikedEntityFromJson(Map<String, dynamic> json) {
  final AnswerLikedEntity answerLikedEntity = AnswerLikedEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    answerLikedEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    answerLikedEntity.message = message;
  }
  return answerLikedEntity;
}

Map<String, dynamic> $AnswerLikedEntityToJson(AnswerLikedEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension AnswerLikedEntityExtension on AnswerLikedEntity {
  AnswerLikedEntity copyWith({
    int? status,
    String? message,
  }) {
    return AnswerLikedEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}