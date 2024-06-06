import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/add_post_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/add_post_entity.g.dart';

@JsonSerializable()
class AddPostEntity {
	int? status = 0;
	String? message = '';
	AddPostUserpost? userpost;

	AddPostEntity();

	factory AddPostEntity.fromJson(Map<String, dynamic> json) => $AddPostEntityFromJson(json);

	Map<String, dynamic> toJson() => $AddPostEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AddPostUserpost {
	int? userid = 0;
	int? postid = 0;
	String? createdate = '';
	String? comments = '';
	dynamic attachment;
	String? comtype = '';
	int? id = 0;
	@JSONField(name: "attachment_path")
	dynamic attachmentPath;

	AddPostUserpost();

	factory AddPostUserpost.fromJson(Map<String, dynamic> json) => $AddPostUserpostFromJson(json);

	Map<String, dynamic> toJson() => $AddPostUserpostToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}