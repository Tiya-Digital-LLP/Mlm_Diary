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
	String? description = '';
	String? creatby = '';
	String? datecreated = '';
	String? datemodified = '';
	String? dateviewed = '';
	String? completee = '';
	int? pgcnt = 0;
	String? status = '';
	dynamic category;
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
	dynamic urlcomponent;
	String? paidtype = '';
	String? classicheck = '';
	int? totallike = 0;
	int? totalcomment = 0;
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