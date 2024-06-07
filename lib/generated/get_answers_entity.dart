import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_answers_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_answers_entity.g.dart';

@JsonSerializable()
class GetAnswersEntity {
	int? status = 0;
	String? message = '';
	List<GetAnswersAnswers>? answers = [];

	GetAnswersEntity();

	factory GetAnswersEntity.fromJson(Map<String, dynamic> json) => $GetAnswersEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetAnswersEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetAnswersAnswers {
	int? id = 0;
	@JSONField(name: "ans_title")
	String? ansTitle = '';
	String? createdate = '';
	@JSONField(name: "user_id")
	int? userId = 0;
	int? totallike = 0;
	int? userliked = 0;
	@JSONField(name: "user_data")
	GetAnswersAnswersUserData? userData;

	GetAnswersAnswers();

	factory GetAnswersAnswers.fromJson(Map<String, dynamic> json) => $GetAnswersAnswersFromJson(json);

	Map<String, dynamic> toJson() => $GetAnswersAnswersToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetAnswersAnswersUserData {
	String? name = '';
	String? userimage = '';
	int? id = 0;
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	GetAnswersAnswersUserData();

	factory GetAnswersAnswersUserData.fromJson(Map<String, dynamic> json) => $GetAnswersAnswersUserDataFromJson(json);

	Map<String, dynamic> toJson() => $GetAnswersAnswersUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}