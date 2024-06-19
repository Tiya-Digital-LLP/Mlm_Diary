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
	String? name = '';
	String? userimage = '';
	int? totallike = 0;
	@JSONField(name: "liked_by_user")
	bool? likedByUser = false;
	List<GetAnswersAnswersComments>? comments = [];

	GetAnswersAnswers();

	factory GetAnswersAnswers.fromJson(Map<String, dynamic> json) => $GetAnswersAnswersFromJson(json);

	Map<String, dynamic> toJson() => $GetAnswersAnswersToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetAnswersAnswersComments {
	int? id = 0;
	String? comment = '';
	String? createdate = '';
	int? userid = 0;
	String? name = '';
	String? userimage = '';
	List<GetAnswersAnswersCommentsReplies>? replies = [];

	GetAnswersAnswersComments();

	factory GetAnswersAnswersComments.fromJson(Map<String, dynamic> json) => $GetAnswersAnswersCommentsFromJson(json);

	Map<String, dynamic> toJson() => $GetAnswersAnswersCommentsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetAnswersAnswersCommentsReplies {
	int? id = 0;
	String? comment = '';
	String? createdate = '';
	int? userid = 0;
	String? name = '';
	String? userimage = '';
	List<GetAnswersAnswersCommentsRepliesReplies>? replies = [];

	GetAnswersAnswersCommentsReplies();

	factory GetAnswersAnswersCommentsReplies.fromJson(Map<String, dynamic> json) => $GetAnswersAnswersCommentsRepliesFromJson(json);

	Map<String, dynamic> toJson() => $GetAnswersAnswersCommentsRepliesToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetAnswersAnswersCommentsRepliesReplies {
	int? id = 0;
	String? comment = '';
	String? createdate = '';
	int? userid = 0;
	String? name = '';
	String? userimage = '';
	List<dynamic>? replies = [];

	GetAnswersAnswersCommentsRepliesReplies();

	factory GetAnswersAnswersCommentsRepliesReplies.fromJson(Map<String, dynamic> json) => $GetAnswersAnswersCommentsRepliesRepliesFromJson(json);

	Map<String, dynamic> toJson() => $GetAnswersAnswersCommentsRepliesRepliesToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}