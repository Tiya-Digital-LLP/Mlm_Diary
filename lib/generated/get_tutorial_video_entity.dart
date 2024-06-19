import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_tutorial_video_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_tutorial_video_entity.g.dart';

@JsonSerializable()
class GetTutorialVideoEntity {
	int? success = 0;
	String? message = '';
	List<GetTutorialVideoData>? data = [];

	GetTutorialVideoEntity();

	factory GetTutorialVideoEntity.fromJson(Map<String, dynamic> json) => $GetTutorialVideoEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetTutorialVideoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetTutorialVideoData {
	int? id = 0;
	String? title = '';
	String? video = '';
	String? position = '';

	GetTutorialVideoData();

	factory GetTutorialVideoData.fromJson(Map<String, dynamic> json) => $GetTutorialVideoDataFromJson(json);

	Map<String, dynamic> toJson() => $GetTutorialVideoDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}