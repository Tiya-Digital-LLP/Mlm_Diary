import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/my_question_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/my_question_entity.g.dart';

@JsonSerializable()
class MyQuestionEntity {
	int? status = 0;
	String? message = '';
	List<MyQuestionQuestions>? questions = [];

	MyQuestionEntity();

	factory MyQuestionEntity.fromJson(Map<String, dynamic> json) => $MyQuestionEntityFromJson(json);

	Map<String, dynamic> toJson() => $MyQuestionEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MyQuestionQuestions {
	int? id = 0;
	String? title = '';
	String? category = '';
	String? subcategory = '';
	String? creatdate = '';
	@JSONField(name: "user_id")
	int? userId = 0;
	int? pgcnt = 0;
	int? totallike = 0;
	int? totalbookmark = 0;
	@JSONField(name: "totalquestion_answer")
	int? totalquestionAnswer = 0;
	int? userliked = 0;
	int? userbookmarked = 0;
	@JSONField(name: "user_data")
	MyQuestionQuestionsUserData? userData;
	@JSONField(name: "full_url")
	String? fullUrl = '';

	MyQuestionQuestions();

	factory MyQuestionQuestions.fromJson(Map<String, dynamic> json) => $MyQuestionQuestionsFromJson(json);

	Map<String, dynamic> toJson() => $MyQuestionQuestionsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MyQuestionQuestionsUserData {
	String? name = '';
	String? userimage = '';
	int? id = 0;
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	MyQuestionQuestionsUserData();

	factory MyQuestionQuestionsUserData.fromJson(Map<String, dynamic> json) => $MyQuestionQuestionsUserDataFromJson(json);

	Map<String, dynamic> toJson() => $MyQuestionQuestionsUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}