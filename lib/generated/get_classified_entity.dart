import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_classified_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_classified_entity.g.dart';

@JsonSerializable()
class GetClassifiedEntity {
	int? status = 0;
	List<GetClassifiedData>? data = [];

	GetClassifiedEntity();

	factory GetClassifiedEntity.fromJson(Map<String, dynamic> json) => $GetClassifiedEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetClassifiedEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetClassifiedData {
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
	String? creatby = '';
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
	@JSONField(name: "user_data")
	GetClassifiedDataUserData? userData;
	@JSONField(name: "full_url")
	String? fullUrl = '';
	@JSONField(name: "image_url")
	String? imageUrl = '';
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	GetClassifiedData();

	factory GetClassifiedData.fromJson(Map<String, dynamic> json) => $GetClassifiedDataFromJson(json);

	Map<String, dynamic> toJson() => $GetClassifiedDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetClassifiedDataUserData {
	String? name = '';
	String? userimage = '';
	String? email = '';
	dynamic mobile;
	dynamic countrycode1;
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	GetClassifiedDataUserData();

	factory GetClassifiedDataUserData.fromJson(Map<String, dynamic> json) => $GetClassifiedDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $GetClassifiedDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}