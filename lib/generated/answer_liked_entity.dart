import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/answer_liked_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/answer_liked_entity.g.dart';

@JsonSerializable()
class AnswerLikedEntity {
	int? status = 0;
	String? message = '';

	AnswerLikedEntity();

	factory AnswerLikedEntity.fromJson(Map<String, dynamic> json) => $AnswerLikedEntityFromJson(json);

	Map<String, dynamic> toJson() => $AnswerLikedEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}