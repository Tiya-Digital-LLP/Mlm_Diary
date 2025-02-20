import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_blog_detail_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_blog_detail_entity.g.dart';

@JsonSerializable()
class GetBlogDetailEntity {
	int? status = 0;
	GetBlogDetailData? data;

	GetBlogDetailEntity();

	factory GetBlogDetailEntity.fromJson(Map<String, dynamic> json) => $GetBlogDetailEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetBlogDetailEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetBlogDetailData {
	int? id = 0;
	String? title = '';
	String? image = '';
	String? description = '';
	int? pgcnt = 0;
	String? createdate = '';
	String? datemodified = '';
	String? category = '';
	@JSONField(name: 'user_id')
	int? userId = 0;
	String? subcategory = '';
	int? status = 0;
	String? website = '';
	String? urlcomponent = '';
	int? totallike = 0;
	int? totalbookmark = 0;
	int? totalcomment = 0;
	@JSONField(name: 'full_url')
	String? fullUrl = '';
	@JSONField(name: 'image_url')
	String? imageUrl = '';
	@JSONField(name: 'liked_by_user')
	bool? likedByUser = false;
	@JSONField(name: 'bookmarked_by_user')
	bool? bookmarkedByUser = false;
	@JSONField(name: 'category_name')
	String? categoryName = '';
	@JSONField(name: 'subcategory_name')
	String? subcategoryName = '';
	@JSONField(name: 'user_data')
	GetBlogDetailDataUserData? userData;
	@JSONField(name: 'image_path')
	String? imagePath = '';

	GetBlogDetailData();

	factory GetBlogDetailData.fromJson(Map<String, dynamic> json) => $GetBlogDetailDataFromJson(json);

	Map<String, dynamic> toJson() => $GetBlogDetailDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetBlogDetailDataUserData {
	String? name = '';
	String? userimage = '';
	String? email = '';
	String? mobile = '';
	String? countrycode1 = '';
	@JSONField(name: 'image_path')
	String? imagePath = '';
	@JSONField(name: 'image_thum_path')
	String? imageThumPath = '';

	GetBlogDetailDataUserData();

	factory GetBlogDetailDataUserData.fromJson(Map<String, dynamic> json) => $GetBlogDetailDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $GetBlogDetailDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}