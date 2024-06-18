import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/add_post_comment_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/add_post_comment_entity.g.dart';

@JsonSerializable()
class AddPostCommentEntity {
	int? status = 0;
	String? message = '';
	AddPostCommentData? data;

	AddPostCommentEntity();

	factory AddPostCommentEntity.fromJson(Map<String, dynamic> json) => $AddPostCommentEntityFromJson(json);

	Map<String, dynamic> toJson() => $AddPostCommentEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AddPostCommentData {
	String? pid = '';
	int? userid = 0;
	@JSONField(name: "parent_id")
	String? parentId = '';
	String? comment = '';
	String? createdate = '';
	int? id = 0;

	AddPostCommentData();

	factory AddPostCommentData.fromJson(Map<String, dynamic> json) => $AddPostCommentDataFromJson(json);

	Map<String, dynamic> toJson() => $AddPostCommentDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}