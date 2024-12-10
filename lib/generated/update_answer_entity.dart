import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/update_answer_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/update_answer_entity.g.dart';

@JsonSerializable()
class UpdateAnswerEntity {
	int? status = 0;
	String? message = '';
	UpdateAnswerAnswer? answer;

	UpdateAnswerEntity();

	factory UpdateAnswerEntity.fromJson(Map<String, dynamic> json) => $UpdateAnswerEntityFromJson(json);

	Map<String, dynamic> toJson() => $UpdateAnswerEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class UpdateAnswerAnswer {
	int? id = 0;
	@JSONField(name: "user_id")
	int? userId = 0;
	int? qusid = 0;
	@JSONField(name: "ans_title")
	String? ansTitle = '';
	String? createdate = '';
	String? datemodified = '';
	@JSONField(name: "main_qustion")
	String? mainQustion = '';
	String? ansquestion = '';
	String? pgcnt = '';

	UpdateAnswerAnswer();

	factory UpdateAnswerAnswer.fromJson(Map<String, dynamic> json) => $UpdateAnswerAnswerFromJson(json);

	Map<String, dynamic> toJson() => $UpdateAnswerAnswerToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}