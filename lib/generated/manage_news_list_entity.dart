import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/manage_news_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/manage_news_list_entity.g.dart';

@JsonSerializable()
class ManageNewsListEntity {
	int? status = 0;
	ManageNewsListData? data;

	ManageNewsListEntity();

	factory ManageNewsListEntity.fromJson(Map<String, dynamic> json) => $ManageNewsListEntityFromJson(json);

	Map<String, dynamic> toJson() => $ManageNewsListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ManageNewsListData {
	int? id = 0;
	String? title = '';
	String? photo = '';
	String? description = '';
	int? pgcnt = 0;
	String? createdate = '';
	String? datemodified = '';
	String? category = '';
	int? creatby = 0;
	int? status = 0;
	String? subcategory = '';
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
	@JSONField(name: 'user_data')
	ManageNewsListDataUserData? userData;
	@JSONField(name: 'category_name')
	String? categoryName = '';
	@JSONField(name: 'subcategory_name')
	String? subcategoryName = '';
	@JSONField(name: 'image_path')
	String? imagePath = '';

	ManageNewsListData();

	factory ManageNewsListData.fromJson(Map<String, dynamic> json) => $ManageNewsListDataFromJson(json);

	Map<String, dynamic> toJson() => $ManageNewsListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ManageNewsListDataUserData {
	String? name = '';
	String? userimage = '';
	String? email = '';
	String? mobile = '';
	String? countrycode1 = '';
	@JSONField(name: 'image_path')
	String? imagePath = '';
	@JSONField(name: 'image_thum_path')
	String? imageThumPath = '';

	ManageNewsListDataUserData();

	factory ManageNewsListDataUserData.fromJson(Map<String, dynamic> json) => $ManageNewsListDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $ManageNewsListDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}