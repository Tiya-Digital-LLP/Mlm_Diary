import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/add_answer_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/add_answer_entity.g.dart';

@JsonSerializable()
class AddAnswerEntity {
	int? status = 0;
	String? message = '';
	AddAnswerAnswer? answer;

	AddAnswerEntity();

	factory AddAnswerEntity.fromJson(Map<String, dynamic> json) => $AddAnswerEntityFromJson(json);

	Map<String, dynamic> toJson() => $AddAnswerEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AddAnswerAnswer {
	String? qusid = '';
	@JSONField(name: "user_id")
	int? userId = 0;
	@JSONField(name: "ans_title")
	String? ansTitle = '';
	String? createdate = '';
	@JSONField(name: "main_qustion")
	String? mainQustion = '';
	String? ansquestion = '';
	String? datemodified = '';
	int? id = 0;

	AddAnswerAnswer();

	factory AddAnswerAnswer.fromJson(Map<String, dynamic> json) => $AddAnswerAnswerFromJson(json);

	Map<String, dynamic> toJson() => $AddAnswerAnswerToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}