import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_blog_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_blog_entity.g.dart';

@JsonSerializable()
class GetBlogEntity {
	int? status = 0;
	String? message = '';
	List<GetBlogData>? data = [];

	GetBlogEntity();

	factory GetBlogEntity.fromJson(Map<String, dynamic> json) => $GetBlogEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetBlogEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetBlogData {
	int? id = 0;
	String? title = '';
	String? image = '';
	String? description = '';
	int? pgcnt = 0;
	String? createdate = '';
	String? datemodified = '';
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
	GetBlogDataUserData? userData;
	@JSONField(name: "image_url")
	String? imageUrl = '';
	@JSONField(name: "image_path")
	String? imagePath = '';

	GetBlogData();

	factory GetBlogData.fromJson(Map<String, dynamic> json) => $GetBlogDataFromJson(json);

	Map<String, dynamic> toJson() => $GetBlogDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetBlogDataUserData {
	int? id = 0;
	String? name = '';
	String? userimage = '';
	String? email = '';
	dynamic mobile;
	dynamic countrycode1;
	String? company = '';
	String? country = '';
	String? city = '';
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	GetBlogDataUserData();

	factory GetBlogDataUserData.fromJson(Map<String, dynamic> json) => $GetBlogDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $GetBlogDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}