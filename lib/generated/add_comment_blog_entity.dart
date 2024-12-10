import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/add_comment_blog_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/add_comment_blog_entity.g.dart';

@JsonSerializable()
class AddCommentBlogEntity {
	int? status = 0;
	String? message = '';
	AddCommentBlogData? data;

	AddCommentBlogEntity();

	factory AddCommentBlogEntity.fromJson(Map<String, dynamic> json) => $AddCommentBlogEntityFromJson(json);

	Map<String, dynamic> toJson() => $AddCommentBlogEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AddCommentBlogData {
	String? bid = '';
	int? userid = 0;
	@JSONField(name: "parent_id")
	int? parentId = 0;
	String? comment = '';
	String? createdate = '';
	int? id = 0;

	AddCommentBlogData();

	factory AddCommentBlogData.fromJson(Map<String, dynamic> json) => $AddCommentBlogDataFromJson(json);

	Map<String, dynamic> toJson() => $AddCommentBlogDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}