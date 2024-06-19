import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/add_answer_comment_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/add_answer_comment_entity.g.dart';

@JsonSerializable()
class AddAnswerCommentEntity {
	int? status = 0;
	String? message = '';
	AddAnswerCommentData? data;

	AddAnswerCommentEntity();

	factory AddAnswerCommentEntity.fromJson(Map<String, dynamic> json) => $AddAnswerCommentEntityFromJson(json);

	Map<String, dynamic> toJson() => $AddAnswerCommentEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AddAnswerCommentData {
	String? ancid = '';
	int? userid = 0;
	@JSONField(name: "parent_id")
	String? parentId = '';
	String? comment = '';
	String? createdate = '';
	int? id = 0;

	AddAnswerCommentData();

	factory AddAnswerCommentData.fromJson(Map<String, dynamic> json) => $AddAnswerCommentDataFromJson(json);

	Map<String, dynamic> toJson() => $AddAnswerCommentDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}