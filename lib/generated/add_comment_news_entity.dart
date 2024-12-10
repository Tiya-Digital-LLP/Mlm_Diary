import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/add_comment_news_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/add_comment_news_entity.g.dart';

@JsonSerializable()
class AddCommentNewsEntity {
	int? status = 0;
	String? message = '';
	AddCommentNewsData? data;

	AddCommentNewsEntity();

	factory AddCommentNewsEntity.fromJson(Map<String, dynamic> json) => $AddCommentNewsEntityFromJson(json);

	Map<String, dynamic> toJson() => $AddCommentNewsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AddCommentNewsData {
	String? nid = '';
	int? userid = 0;
	@JSONField(name: "parent_id")
	int? parentId = 0;
	String? comment = '';
	String? createdate = '';
	int? id = 0;

	AddCommentNewsData();

	factory AddCommentNewsData.fromJson(Map<String, dynamic> json) => $AddCommentNewsDataFromJson(json);

	Map<String, dynamic> toJson() => $AddCommentNewsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}