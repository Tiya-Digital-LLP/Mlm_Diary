import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/update_post_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/update_post_entity.g.dart';

@JsonSerializable()
class UpdatePostEntity {
	int? status = 0;
	String? message = '';
	UpdatePostUserpost? userpost;

	UpdatePostEntity();

	factory UpdatePostEntity.fromJson(Map<String, dynamic> json) => $UpdatePostEntityFromJson(json);

	Map<String, dynamic> toJson() => $UpdatePostEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class UpdatePostUserpost {
	int? id = 0;
	String? userid = '';
	String? comments = '';
	String? attachment = '';
	int? pgcnt = 0;
	String? comtype = '';
	String? createdate = '';
	dynamic status;
	String? postid = '';
	@JSONField(name: "attachment_path")
	String? attachmentPath = '';

	UpdatePostUserpost();

	factory UpdatePostUserpost.fromJson(Map<String, dynamic> json) => $UpdatePostUserpostFromJson(json);

	Map<String, dynamic> toJson() => $UpdatePostUserpostToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}