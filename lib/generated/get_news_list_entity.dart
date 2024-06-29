import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_news_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_news_list_entity.g.dart';

@JsonSerializable()
class GetNewsListEntity {
	int? status = 0;
	String? message = '';
	List<GetNewsListData>? data = [];

	GetNewsListEntity();

	factory GetNewsListEntity.fromJson(Map<String, dynamic> json) => $GetNewsListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetNewsListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNewsListData {
	int? id = 0;
	String? title = '';
	String? photo = '';
	String? description = '';
	int? pgcnt = 0;
	String? createdate = '';
	String? category = '';
	String? creatby = '';
	int? status = 0;
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
	GetNewsListDataUserData? userData;
	@JSONField(name: "image_url")
	String? imageUrl = '';
	@JSONField(name: "image_path")
	String? imagePath = '';

	GetNewsListData();

	factory GetNewsListData.fromJson(Map<String, dynamic> json) => $GetNewsListDataFromJson(json);

	Map<String, dynamic> toJson() => $GetNewsListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNewsListDataUserData {
	int? id = 0;
	String? name = '';
	String? userimage = '';
	String? email = '';
	dynamic mobile;
	dynamic countrycode1;
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	GetNewsListDataUserData();

	factory GetNewsListDataUserData.fromJson(Map<String, dynamic> json) => $GetNewsListDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $GetNewsListDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}