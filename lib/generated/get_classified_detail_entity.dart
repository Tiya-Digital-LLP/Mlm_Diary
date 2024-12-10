import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_classified_detail_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_classified_detail_entity.g.dart';

@JsonSerializable()
class GetClassifiedDetailEntity {
	late int status;
	late GetClassifiedDetailData data;

	GetClassifiedDetailEntity();

	factory GetClassifiedDetailEntity.fromJson(Map<String, dynamic> json) => $GetClassifiedDetailEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetClassifiedDetailEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetClassifiedDetailData {
	late int id;
	late String title;
	late String image;
	late String description;
	late int pgcnt;
	late String company;
	dynamic premiumsdate;
	dynamic premiumedate;
	late String datemodified;
	late String createdate;
	late String category;
	late int creatby;
	late String subcategory;
	late String popular;
	late String website;
	late String city;
	late String state;
	late String country;
	late String lat;
	late String lng;
	late String urlcomponent;
	late int totallike;
	late int totalbookmark;
	late int totalcomment;
	@JSONField(name: "liked_by_user")
	late bool likedByUser;
	@JSONField(name: "bookmarked_by_user")
	late bool bookmarkedByUser;
	@JSONField(name: "category_name")
	late String categoryName;
	@JSONField(name: "subcategory_name")
	late String subcategoryName;
	@JSONField(name: "user_data")
	late GetClassifiedDetailDataUserData userData;
	@JSONField(name: "full_url")
	late String fullUrl;
	@JSONField(name: "image_url")
	late String imageUrl;
	@JSONField(name: "image_path")
	late String imagePath;
	@JSONField(name: "image_thum_path")
	late String imageThumPath;

	GetClassifiedDetailData();

	factory GetClassifiedDetailData.fromJson(Map<String, dynamic> json) => $GetClassifiedDetailDataFromJson(json);

	Map<String, dynamic> toJson() => $GetClassifiedDetailDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetClassifiedDetailDataUserData {
	late String name;
	late String userimage;
	late String email;
	late String mobile;
	late String countrycode1;
	@JSONField(name: "image_path")
	late String imagePath;
	@JSONField(name: "image_thum_path")
	late String imageThumPath;

	GetClassifiedDetailDataUserData();

	factory GetClassifiedDetailDataUserData.fromJson(Map<String, dynamic> json) => $GetClassifiedDetailDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $GetClassifiedDetailDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}