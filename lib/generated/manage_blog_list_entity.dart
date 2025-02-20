import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/manage_blog_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/manage_blog_list_entity.g.dart';

@JsonSerializable()
class ManageBlogListEntity {
	int? status = 0;
	String? message = '';
	List<ManageBlogListData>? data = [];

	ManageBlogListEntity();

	factory ManageBlogListEntity.fromJson(Map<String, dynamic> json) => $ManageBlogListEntityFromJson(json);

	Map<String, dynamic> toJson() => $ManageBlogListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ManageBlogListData {
	@JSONField(name: 'article_id')
	int? articleId = 0;
	String? title = '';
	String? image = '';
	String? description = '';
	int? pgcnt = 0;
	@JSONField(name: 'created_date')
	String? createdDate = '';
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
	@JSONField(name: 'liked_by_user')
	bool? likedByUser = false;
	@JSONField(name: 'bookmarked_by_user')
	bool? bookmarkedByUser = false;
	@JSONField(name: 'user_data')
	ManageBlogListDataUserData? userData;
	@JSONField(name: 'category_name')
	String? categoryName = '';
	@JSONField(name: 'subcategory_name')
	String? subcategoryName = '';
	@JSONField(name: 'full_url')
	String? fullUrl = '';
	@JSONField(name: 'image_path')
	String? imagePath = '';

	ManageBlogListData();

	factory ManageBlogListData.fromJson(Map<String, dynamic> json) => $ManageBlogListDataFromJson(json);

	Map<String, dynamic> toJson() => $ManageBlogListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ManageBlogListDataUserData {
	int? id = 0;
	String? name = '';
	String? userimage = '';
	String? email = '';
	String? mobile = '';
	String? countrycode1 = '';
	String? company = '';
	String? state = '';
	String? country = '';
	String? city = '';
	@JSONField(name: 'full_address')
	String? fullAddress = '';
	@JSONField(name: 'image_path')
	String? imagePath = '';
	@JSONField(name: 'image_thum_path')
	String? imageThumPath = '';

	ManageBlogListDataUserData();

	factory ManageBlogListDataUserData.fromJson(Map<String, dynamic> json) => $ManageBlogListDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $ManageBlogListDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}