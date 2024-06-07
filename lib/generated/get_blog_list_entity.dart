import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_blog_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_blog_list_entity.g.dart';

@JsonSerializable()
class GetBlogListEntity {
	int? status = 0;
	String? message = '';
	List<GetBlogListData>? data = [];

	GetBlogListEntity();

	factory GetBlogListEntity.fromJson(Map<String, dynamic> json) => $GetBlogListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetBlogListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetBlogListData {
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
	GetBlogListDataUserData? userData;
	@JSONField(name: "image_path")
	String? imagePath = '';

	GetBlogListData();

	factory GetBlogListData.fromJson(Map<String, dynamic> json) => $GetBlogListDataFromJson(json);

	Map<String, dynamic> toJson() => $GetBlogListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetBlogListDataUserData {
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

	GetBlogListDataUserData();

	factory GetBlogListDataUserData.fromJson(Map<String, dynamic> json) => $GetBlogListDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $GetBlogListDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}