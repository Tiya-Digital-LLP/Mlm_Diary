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
	String? premiumsdate = '';
	String? premiumedate = '';
	String? popular = '';
	dynamic user;
	@JSONField(name: "total_like")
	int? totalLike = 0;
	@JSONField(name: "total_comment")
	int? totalComment = 0;
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