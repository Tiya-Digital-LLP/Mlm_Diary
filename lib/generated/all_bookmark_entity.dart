import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/all_bookmark_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/all_bookmark_entity.g.dart';

@JsonSerializable()
class AllBookmarkEntity {
	int? status = 0;
	String? message = '';
	List<AllBookmarkData>? data = [];

	AllBookmarkEntity();

	factory AllBookmarkEntity.fromJson(Map<String, dynamic> json) => $AllBookmarkEntityFromJson(json);

	Map<String, dynamic> toJson() => $AllBookmarkEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AllBookmarkData {
	int? id = 0;
	String? title = '';
	String? urlcomponent = '';
	String? company = '';
	String? category = '';
	String? subcategory = '';
	String? description = '';
	String? website = '';
	String? createdate = '';
	int? pgcnt = 0;
	String? location = '';
	String? image = '';
	@JSONField(name: "user_id")
	String? userId = '';
	String? type = '';
	dynamic immlm;
	String? plan = '';
	String? city = '';
	String? state = '';
	String? country = '';
	@JSONField(name: "bookmark_date")
	String? bookmarkDate = '';
	int? totallike = 0;
	int? totalcomment = 0;
	@JSONField(name: "liked_by_user")
	bool? likedByUser = false;
	@JSONField(name: "image_url")
	String? imageUrl = '';
	@JSONField(name: "user_data")
	AllBookmarkDataUserData? userData;

	AllBookmarkData();

	factory AllBookmarkData.fromJson(Map<String, dynamic> json) => $AllBookmarkDataFromJson(json);

	Map<String, dynamic> toJson() => $AllBookmarkDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AllBookmarkDataUserData {
	int? id = 0;
	String? name = '';
	String? email = '';
	String? userimage = '';
	String? countrycode1 = '';
	String? mobile = '';
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	AllBookmarkDataUserData();

	factory AllBookmarkDataUserData.fromJson(Map<String, dynamic> json) => $AllBookmarkDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $AllBookmarkDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}