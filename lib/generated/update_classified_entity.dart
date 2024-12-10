import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/update_classified_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/update_classified_entity.g.dart';

@JsonSerializable()
class UpdateClassifiedEntity {
	int? status = 0;
	String? message = '';
	UpdateClassifiedData? data;

	UpdateClassifiedEntity();

	factory UpdateClassifiedEntity.fromJson(Map<String, dynamic> json) => $UpdateClassifiedEntityFromJson(json);

	Map<String, dynamic> toJson() => $UpdateClassifiedEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class UpdateClassifiedData {
	int? id = 0;
	String? title = '';
	String? description = '';
	String? creatby = '';
	String? datecreated = '';
	String? datemodified = '';
	String? dateviewed = '';
	String? completee = '';
	int? pgcnt = 0;
	String? status = '';
	String? category = '';
	String? ipp = '';
	dynamic tags;
	int? facebook = 0;
	int? twitter = 0;
	int? googleplus = 0;
	int? logit = 0;
	int? updatee = 0;
	String? popular = '';
	int? premium = 0;
	@JSONField(name: "premium_date")
	dynamic premiumDate;
	dynamic premiumsdate;
	dynamic premiumedate;
	String? subcategory = '';
	dynamic ctype;
	String? location = '';
	String? image = '';
	String? company = '';
	String? website = '';
	String? city = '';
	String? state = '';
	String? country = '';
	String? urlcomponent = '';
	String? paidtype = '';
	String? classicheck = '';
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	UpdateClassifiedData();

	factory UpdateClassifiedData.fromJson(Map<String, dynamic> json) => $UpdateClassifiedDataFromJson(json);

	Map<String, dynamic> toJson() => $UpdateClassifiedDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}