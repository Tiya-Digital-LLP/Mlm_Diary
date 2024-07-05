import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_user_all_post_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_user_all_post_entity.g.dart';

@JsonSerializable()
class GetUserAllPostEntity {
	int? status = 0;
	String? message = '';
	List<GetUserAllPostData>? data = [];

	GetUserAllPostEntity();

	factory GetUserAllPostEntity.fromJson(Map<String, dynamic> json) => $GetUserAllPostEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetUserAllPostEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserAllPostData {
	int? id = 0;
	String? title = '';
	String? urlcomponent = '';
	String? company = '';
	String? popular = '';
	dynamic premiumsdate;
	String? category = '';
	String? subcategory = '';
	String? description = '';
	String? website = '';
	dynamic email;
	dynamic phone;
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
	dynamic plan;
	dynamic city;
	dynamic state;
	dynamic country;
	String? posttype = '';
	int? totallike = 0;
	int? totalcomment = 0;
	@JSONField(name: "is_popular_classified")
	int? isPopularClassified = 0;
	@JSONField(name: "bookmark_by_user")
	bool? bookmarkByUser = false;
	@JSONField(name: "liked_by_user")
	bool? likedByUser = false;
	@JSONField(name: "image_url")
	String? imageUrl = '';
	@JSONField(name: "user_data")
	GetUserAllPostDataUserData? userData;

	GetUserAllPostData();

	factory GetUserAllPostData.fromJson(Map<String, dynamic> json) => $GetUserAllPostDataFromJson(json);

	Map<String, dynamic> toJson() => $GetUserAllPostDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserAllPostDataUserData {
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

	GetUserAllPostDataUserData();

	factory GetUserAllPostDataUserData.fromJson(Map<String, dynamic> json) => $GetUserAllPostDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $GetUserAllPostDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}