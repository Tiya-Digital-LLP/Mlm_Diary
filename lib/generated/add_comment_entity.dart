import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/add_comment_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/add_comment_entity.g.dart';

@JsonSerializable()
class AddCommentEntity {
	int? status = 0;
	String? message = '';
	AddCommentData? data;

	AddCommentEntity();

	factory AddCommentEntity.fromJson(Map<String, dynamic> json) => $AddCommentEntityFromJson(json);

	Map<String, dynamic> toJson() => $AddCommentEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AddCommentData {
	String? cid = '';
	int? userid = 0;
	@JSONField(name: "parent_id")
	int? parentId = 0;
	String? comment = '';
	String? createdate = '';
	int? id = 0;

	AddCommentData();

	factory AddCommentData.fromJson(Map<String, dynamic> json) => $AddCommentDataFromJson(json);

	Map<String, dynamic> toJson() => $AddCommentDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}