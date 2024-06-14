import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/my_blog_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/my_blog_list_entity.g.dart';

@JsonSerializable()
class MyBlogListEntity {
	int? status = 0;
	String? message = '';
	List<MyBlogListData>? data = [];

	MyBlogListEntity();

	factory MyBlogListEntity.fromJson(Map<String, dynamic> json) => $MyBlogListEntityFromJson(json);

	Map<String, dynamic> toJson() => $MyBlogListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MyBlogListData {
	@JSONField(name: "article_id")
	int? articleId = 0;
	String? title = '';
	String? image = '';
	String? description = '';
	int? pgcnt = 0;
	@JSONField(name: "created_date")
	String? createdDate = '';
	String? category = '';
	@JSONField(name: "user_id")
	int? userId = 0;
	String? subcategory = '';
	int? status = 0;
	String? website = '';
	String? urlcomponent = '';
	int? totallike = 0;
	int? totalbookmark = 0;
	int? totalcomment = 0;
	@JSONField(name: "liked_by_user")
	bool? likedByUser = false;
	@JSONField(name: "bookmarked_by_user")
	bool? bookmarkedByUser = false;
	@JSONField(name: "user_data")
	MyBlogListDataUserData? userData;
	@JSONField(name: "image_path")
	String? imagePath = '';

	MyBlogListData();

	factory MyBlogListData.fromJson(Map<String, dynamic> json) => $MyBlogListDataFromJson(json);

	Map<String, dynamic> toJson() => $MyBlogListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MyBlogListDataUserData {
	int? id = 0;
	String? name = '';
	String? userimage = '';
	String? email = '';
	String? mobile = '';
	String? countrycode1 = '';
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	MyBlogListDataUserData();

	factory MyBlogListDataUserData.fromJson(Map<String, dynamic> json) => $MyBlogListDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $MyBlogListDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}