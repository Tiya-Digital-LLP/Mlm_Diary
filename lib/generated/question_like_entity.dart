import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/question_like_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/question_like_entity.g.dart';

@JsonSerializable()
class QuestionLikeEntity {
	int? status = 0;
	String? message = '';

	QuestionLikeEntity();

	factory QuestionLikeEntity.fromJson(Map<String, dynamic> json) => $QuestionLikeEntityFromJson(json);

	Map<String, dynamic> toJson() => $QuestionLikeEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}