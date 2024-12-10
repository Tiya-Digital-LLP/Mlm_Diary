import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/add_faviourite_question_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/add_faviourite_question_entity.g.dart';

@JsonSerializable()
class AddFaviouriteQuestionEntity {
	int? status = 0;
	String? message = '';

	AddFaviouriteQuestionEntity();

	factory AddFaviouriteQuestionEntity.fromJson(Map<String, dynamic> json) => $AddFaviouriteQuestionEntityFromJson(json);

	Map<String, dynamic> toJson() => $AddFaviouriteQuestionEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}