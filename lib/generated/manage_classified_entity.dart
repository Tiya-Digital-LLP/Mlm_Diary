import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/manage_classified_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/manage_classified_entity.g.dart';

@JsonSerializable()
class ManageClassifiedEntity {
	int? status = 0;
	List<ManageClassifiedData>? data = [];

	ManageClassifiedEntity();

	factory ManageClassifiedEntity.fromJson(Map<String, dynamic> json) => $ManageClassifiedEntityFromJson(json);

	Map<String, dynamic> toJson() => $ManageClassifiedEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ManageClassifiedData {
	int? id = 0;
	String? title = '';
	String? image = '';
	String? description = '';
	int? pgcnt = 0;
	String? company = '';
	dynamic premiumsdate;
	dynamic premiumedate;
	String? datemodified = '';
	String? datecreated = '';
	String? category = '';
	String? creatby = '';
	String? subcategory = '';
	String? popular = '';
	String? website = '';
	String? city = '';
	String? state = '';
	String? country = '';
	String? urlcomponent = '';
	int? totallike = 0;
	int? totalbookmark = 0;
	@JSONField(name: "liked_by_user")
	bool? likedByUser = false;
	@JSONField(name: "bookmarked_by_user")
	bool? bookmarkedByUser = false;
	@JSONField(name: "user_data")
	ManageClassifiedDataUserData? userData;
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	ManageClassifiedData();

	factory ManageClassifiedData.fromJson(Map<String, dynamic> json) => $ManageClassifiedDataFromJson(json);

	Map<String, dynamic> toJson() => $ManageClassifiedDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ManageClassifiedDataUserData {
	int? id = 0;
	String? name = '';
	String? userimage = '';
	String? email = '';
	String? mobile = '';
	String? countrycode1 = '';
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	ManageClassifiedDataUserData();

	factory ManageClassifiedDataUserData.fromJson(Map<String, dynamic> json) => $ManageClassifiedDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $ManageClassifiedDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}