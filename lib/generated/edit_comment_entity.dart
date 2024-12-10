import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/edit_comment_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/edit_comment_entity.g.dart';

@JsonSerializable()
class EditCommentEntity {
	int? status = 0;
	String? message = '';

	EditCommentEntity();

	factory EditCommentEntity.fromJson(Map<String, dynamic> json) => $EditCommentEntityFromJson(json);

	Map<String, dynamic> toJson() => $EditCommentEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}