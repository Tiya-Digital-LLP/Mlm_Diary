import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/update_news_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/update_news_entity.g.dart';

@JsonSerializable()
class UpdateNewsEntity {
	int? status = 0;
	String? message = '';
	UpdateNewsData? data;

	UpdateNewsEntity();

	factory UpdateNewsEntity.fromJson(Map<String, dynamic> json) => $UpdateNewsEntityFromJson(json);

	Map<String, dynamic> toJson() => $UpdateNewsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class UpdateNewsData {
	int? id = 0;
	String? title = '';
	@JSONField(name: "title_hindi")
	dynamic titleHindi;
	@JSONField(name: "description_meta")
	dynamic descriptionMeta;
	String? description = '';
	String? creatby = '';
	String? datemodified = '';
	String? featured = '';
	int? pgcnt = 0;
	String? ipp = '';
	String? category = '';
	dynamic city;
	dynamic state;
	dynamic country;
	dynamic source;
	String? photo = '';
	dynamic video;
	dynamic tags;
	dynamic extra1;
	@JSONField(name: "short_content")
	dynamic shortContent;
	dynamic vtitle;
	int? status = 0;
	String? subcategory = '';
	String? website = '';
	dynamic appdate;
	String? createdate = '';
	String? urlcomponent = '';
	String? classicheck = '';
	@JSONField(name: "image_path")
	String? imagePath = '';

	UpdateNewsData();

	factory UpdateNewsData.fromJson(Map<String, dynamic> json) => $UpdateNewsDataFromJson(json);

	Map<String, dynamic> toJson() => $UpdateNewsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}