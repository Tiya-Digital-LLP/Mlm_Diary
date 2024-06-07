import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/count_view_question_entity.dart';

CountViewQuestionEntity $CountViewQuestionEntityFromJson(
    Map<String, dynamic> json) {
  final CountViewQuestionEntity countViewQuestionEntity = CountViewQuestionEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    countViewQuestionEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    countViewQuestionEntity.message = message;
  }
  return countViewQuestionEntity;
}

Map<String, dynamic> $CountViewQuestionEntityToJson(
    CountViewQuestionEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension CountViewQuestionEntityExtension on CountViewQuestionEntity {
  CountViewQuestionEntity copyWith({
    int? status,
    String? message,
  }) {
    return CountViewQuestionEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}