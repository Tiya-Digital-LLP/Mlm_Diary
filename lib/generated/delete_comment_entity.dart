import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/delete_comment_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/delete_comment_entity.g.dart';

@JsonSerializable()
class DeleteCommentEntity {
	int? status = 0;
	String? message = '';

	DeleteCommentEntity();

	factory DeleteCommentEntity.fromJson(Map<String, dynamic> json) => $DeleteCommentEntityFromJson(json);

	Map<String, dynamic> toJson() => $DeleteCommentEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}