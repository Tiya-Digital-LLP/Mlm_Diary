import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_home_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_home_entity.g.dart';

@JsonSerializable()
class GetHomeEntity {
	int? status = 0;
	String? message = '';
	List<GetHomeData>? data = [];

	GetHomeEntity();

	factory GetHomeEntity.fromJson(Map<String, dynamic> json) => $GetHomeEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetHomeEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetHomeData {
	int? id = 0;
	String? title = '';
	String? urlcomponent = '';
	String? company = '';
	String? category = '';
	String? subcategory = '';
	String? description = '';
	String? website = '';
	String? createdate = '';
	@JSONField(name: "updated_at")
	String? updatedAt = '';
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
	String? posttype = '';
	int? totallike = 0;
	int? totalcomment = 0;
	@JSONField(name: "liked_by_user")
	bool? likedByUser = false;
	@JSONField(name: "image_url")
	String? imageUrl = '';
	@JSONField(name: "user_data")
	GetHomeDataUserData? userData;

	GetHomeData();

	factory GetHomeData.fromJson(Map<String, dynamic> json) => $GetHomeDataFromJson(json);

	Map<String, dynamic> toJson() => $GetHomeDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetHomeDataUserData {
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

	GetHomeDataUserData();

	factory GetHomeDataUserData.fromJson(Map<String, dynamic> json) => $GetHomeDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $GetHomeDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}