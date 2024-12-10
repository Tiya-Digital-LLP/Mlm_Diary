import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_question_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_question_list_entity.g.dart';

@JsonSerializable()
class GetQuestionListEntity {
	int? status = 0;
	String? message = '';
	List<GetQuestionListQuestions>? questions = [];

	GetQuestionListEntity();

	factory GetQuestionListEntity.fromJson(Map<String, dynamic> json) => $GetQuestionListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetQuestionListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetQuestionListQuestions {
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
	@JSONField(name: "user_data")
	GetQuestionListQuestionsUserData? userData;
	@JSONField(name: "liked_by_user")
	bool? likedByUser = false;
	@JSONField(name: "bookmarked_by_user")
	bool? bookmarkedByUser = false;

	GetQuestionListQuestions();

	factory GetQuestionListQuestions.fromJson(Map<String, dynamic> json) => $GetQuestionListQuestionsFromJson(json);

	Map<String, dynamic> toJson() => $GetQuestionListQuestionsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetQuestionListQuestionsUserData {
	String? name = '';
	String? userimage = '';
	int? id = 0;
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	GetQuestionListQuestionsUserData();

	factory GetQuestionListQuestionsUserData.fromJson(Map<String, dynamic> json) => $GetQuestionListQuestionsUserDataFromJson(json);

	Map<String, dynamic> toJson() => $GetQuestionListQuestionsUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}