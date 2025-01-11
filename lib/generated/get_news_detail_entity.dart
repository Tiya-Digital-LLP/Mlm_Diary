import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_news_detail_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_news_detail_entity.g.dart';

@JsonSerializable()
class GetNewsDetailEntity {
	int? status = 0;
	GetNewsDetailData? data;

	GetNewsDetailEntity();

	factory GetNewsDetailEntity.fromJson(Map<String, dynamic> json) => $GetNewsDetailEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetNewsDetailEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNewsDetailData {
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
	@JSONField(name: "full_url")
	String? fullUrl = '';
	@JSONField(name: "image_url")
	String? imageUrl = '';
	@JSONField(name: "liked_by_user")
	bool? likedByUser = false;
	@JSONField(name: "bookmarked_by_user")
	bool? bookmarkedByUser = false;
	@JSONField(name: "user_data")
	GetNewsDetailDataUserData? userData;
	@JSONField(name: "image_path")
	String? imagePath = '';

	GetNewsDetailData();

	factory GetNewsDetailData.fromJson(Map<String, dynamic> json) => $GetNewsDetailDataFromJson(json);

	Map<String, dynamic> toJson() => $GetNewsDetailDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNewsDetailDataUserData {
	String? name = '';
	String? userimage = '';
	String? email = '';
	dynamic mobile;
	dynamic countrycode1;
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	GetNewsDetailDataUserData();

	factory GetNewsDetailDataUserData.fromJson(Map<String, dynamic> json) => $GetNewsDetailDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $GetNewsDetailDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}