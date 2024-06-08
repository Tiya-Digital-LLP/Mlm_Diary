import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/add_faviourite_question_entity.dart';

AddFaviouriteQuestionEntity $AddFaviouriteQuestionEntityFromJson(
    Map<String, dynamic> json) {
  final AddFaviouriteQuestionEntity addFaviouriteQuestionEntity = AddFaviouriteQuestionEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    addFaviouriteQuestionEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    addFaviouriteQuestionEntity.message = message;
  }
  return addFaviouriteQuestionEntity;
}

Map<String, dynamic> $AddFaviouriteQuestionEntityToJson(
    AddFaviouriteQuestionEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension AddFaviouriteQuestionEntityExtension on AddFaviouriteQuestionEntity {
  AddFaviouriteQuestionEntity copyWith({
    int? status,
    String? message,
  }) {
    return AddFaviouriteQuestionEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}