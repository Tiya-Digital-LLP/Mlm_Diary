import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/database_detail_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/database_detail_entity.g.dart';

@JsonSerializable()
class DatabaseDetailEntity {
	int? status = 0;
	String? message = '';
	DatabaseDetailData? data;

	DatabaseDetailEntity();

	factory DatabaseDetailEntity.fromJson(Map<String, dynamic> json) => $DatabaseDetailEntityFromJson(json);

	Map<String, dynamic> toJson() => $DatabaseDetailEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class DatabaseDetailData {
	int? id = 0;
	String? name = '';
	String? sex = '';
	String? email = '';
	String? mobile = '';
	dynamic aboutcompany;
	dynamic aboutyou;
	String? immlm = '';
	String? userimage = '';
	String? city = '';
	String? state = '';
	String? country = '';
	String? company = '';
	String? plan = '';
	int? views = 0;
	@JSONField(name: "followers_count")
	int? followersCount = 0;
	@JSONField(name: "following_count")
	int? followingCount = 0;
	@JSONField(name: "follow_status")
	bool? followStatus = false;
	@JSONField(name: "fav_status")
	bool? favStatus = false;
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	DatabaseDetailData();

	factory DatabaseDetailData.fromJson(Map<String, dynamic> json) => $DatabaseDetailDataFromJson(json);

	Map<String, dynamic> toJson() => $DatabaseDetailDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}