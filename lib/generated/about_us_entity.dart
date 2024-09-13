import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/about_us_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/about_us_entity.g.dart';

@JsonSerializable()
class AboutUsEntity {
	late int status;
	late AboutUsAbout about;

	AboutUsEntity();

	factory AboutUsEntity.fromJson(Map<String, dynamic> json) => $AboutUsEntityFromJson(json);

	Map<String, dynamic> toJson() => $AboutUsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AboutUsAbout {
	late int id;
	late String description1;
	late String title1;
	late String description2;
	late String title2;
	late String description3;
	late String title3;
	late String description4;
	late String title4;
	dynamic description5;
	dynamic title5;

	AboutUsAbout();

	factory AboutUsAbout.fromJson(Map<String, dynamic> json) => $AboutUsAboutFromJson(json);

	Map<String, dynamic> toJson() => $AboutUsAboutToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}