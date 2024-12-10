import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/update_blog_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/update_blog_entity.g.dart';

@JsonSerializable()
class UpdateBlogEntity {
	int? status = 0;
	String? message = '';
	UpdateBlogData? data;

	UpdateBlogEntity();

	factory UpdateBlogEntity.fromJson(Map<String, dynamic> json) => $UpdateBlogEntityFromJson(json);

	Map<String, dynamic> toJson() => $UpdateBlogEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class UpdateBlogData {
	@JSONField(name: "article_id")
	int? articleId = 0;
	String? title = '';
	@JSONField(name: "title_url")
	String? titleUrl = '';
	String? description = '';
	String? image = '';
	@JSONField(name: "meta_keywords")
	dynamic metaKeywords;
	@JSONField(name: "meta_description")
	dynamic metaDescription;
	@JSONField(name: "user_id")
	int? userId = 0;
	String? ipp = '';
	int? pgcnt = 0;
	@JSONField(name: "lastview_date")
	dynamic lastviewDate;
	int? status = 0;
	@JSONField(name: "created_date")
	String? createdDate = '';
	@JSONField(name: "modified_date")
	String? modifiedDate = '';
	String? category = '';
	String? subcategory = '';
	String? website = '';
	dynamic appdate;
	String? urlcomponent = '';
	@JSONField(name: "image_path")
	String? imagePath = '';

	UpdateBlogData();

	factory UpdateBlogData.fromJson(Map<String, dynamic> json) => $UpdateBlogDataFromJson(json);

	Map<String, dynamic> toJson() => $UpdateBlogDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}