import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_classified_detail_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_classified_detail_entity.g.dart';

@JsonSerializable()
class GetClassifiedDetailEntity {
	int? status = 0;
	GetClassifiedDetailData? data;

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
	int? id = 0;
	String? title = '';
	String? image = '';
	String? description = '';
	int? pgcnt = 0;
	String? company = '';
	String? premiumsdate = '';
	String? premiumedate = '';
	String? datemodified = '';
	String? createdate = '';
	String? category = '';
	int? creatby = 0;
	String? subcategory = '';
	String? popular = '';
	String? website = '';
	String? location = '';
	String? city = '';
	String? state = '';
	String? country = '';
	String? lat = '';
	String? lng = '';
	String? urlcomponent = '';
	int? totallike = 0;
	int? totalbookmark = 0;
	int? totalcomment = 0;
	@JSONField(name: "liked_by_user")
	bool? likedByUser = false;
	@JSONField(name: "bookmarked_by_user")
	bool? bookmarkedByUser = false;
	@JSONField(name: "category_name")
	String? categoryName = '';
	@JSONField(name: "subcategory_name")
	String? subcategoryName = '';
	@JSONField(name: "user_data")
	GetClassifiedDetailDataUserData? userData;
	@JSONField(name: "full_url")
	String? fullUrl = '';
	@JSONField(name: "user_id")
	int? userId = 0;
	@JSONField(name: "image_url")
	String? imageUrl = '';
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

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
	String? name = '';
	String? userimage = '';
	String? email = '';
	String? mobile = '';
	String? countrycode1 = '';
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	GetClassifiedDetailDataUserData();

	factory GetClassifiedDetailDataUserData.fromJson(Map<String, dynamic> json) => $GetClassifiedDetailDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $GetClassifiedDetailDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}