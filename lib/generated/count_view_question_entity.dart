import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/count_view_question_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/count_view_question_entity.g.dart';

@JsonSerializable()
class CountViewQuestionEntity {
	int? status = 0;
	String? message = '';

	CountViewQuestionEntity();

	factory CountViewQuestionEntity.fromJson(Map<String, dynamic> json) => $CountViewQuestionEntityFromJson(json);

	Map<String, dynamic> toJson() => $CountViewQuestionEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}