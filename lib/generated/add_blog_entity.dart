import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/add_blog_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/add_blog_entity.g.dart';

@JsonSerializable()
class AddBlogEntity {
	int? status = 0;
	String? message = '';
	AddBlogData? data;

	AddBlogEntity();

	factory AddBlogEntity.fromJson(Map<String, dynamic> json) => $AddBlogEntityFromJson(json);

	Map<String, dynamic> toJson() => $AddBlogEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AddBlogData {
	String? title = '';
	String? description = '';
	String? subcategory = '';
	String? category = '';
	@JSONField(name: "user_id")
	int? userId = 0;
	String? image = '';
	String? ipp = '';
	String? website = '';
	String? urlcomponent = '';
	@JSONField(name: "created_date")
	String? createdDate = '';
	@JSONField(name: "modified_date")
	String? modifiedDate = '';
	@JSONField(name: "article_id")
	int? articleId = 0;
	@JSONField(name: "image_path")
	String? imagePath = '';

	AddBlogData();

	factory AddBlogData.fromJson(Map<String, dynamic> json) => $AddBlogDataFromJson(json);

	Map<String, dynamic> toJson() => $AddBlogDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}