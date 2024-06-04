import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/add_news_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/add_news_entity.g.dart';

@JsonSerializable()
class AddNewsEntity {
	int? status = 0;
	String? message = '';
	AddNewsData? data;

	AddNewsEntity();

	factory AddNewsEntity.fromJson(Map<String, dynamic> json) => $AddNewsEntityFromJson(json);

	Map<String, dynamic> toJson() => $AddNewsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AddNewsData {
	String? title = '';
	String? description = '';
	String? subcategory = '';
	String? category = '';
	int? creatby = 0;
	String? photo = '';
	String? ipp = '';
	String? website = '';
	String? urlcomponent = '';
	String? createdate = '';
	String? datemodified = '';
	int? id = 0;

	AddNewsData();

	factory AddNewsData.fromJson(Map<String, dynamic> json) => $AddNewsDataFromJson(json);

	Map<String, dynamic> toJson() => $AddNewsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}