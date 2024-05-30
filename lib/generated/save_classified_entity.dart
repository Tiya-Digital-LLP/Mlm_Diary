import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/save_classified_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/save_classified_entity.g.dart';

@JsonSerializable()
class SaveClassifiedEntity {
	int? status = 0;
	String? message = '';
	SaveClassifiedData? data;

	SaveClassifiedEntity();

	factory SaveClassifiedEntity.fromJson(Map<String, dynamic> json) => $SaveClassifiedEntityFromJson(json);

	Map<String, dynamic> toJson() => $SaveClassifiedEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SaveClassifiedData {
	String? title = '';
	String? description = '';
	String? subcategory = '';
	int? creatby = 0;
	String? location = '';
	String? city = '';
	String? state = '';
	String? image = '';
	String? country = '';
	String? company = '';
	String? ipp = '';
	String? website = '';
	String? datecreated = '';
	String? datemodified = '';
	int? id = 0;
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	SaveClassifiedData();

	factory SaveClassifiedData.fromJson(Map<String, dynamic> json) => $SaveClassifiedDataFromJson(json);

	Map<String, dynamic> toJson() => $SaveClassifiedDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}