import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/question_like_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/question_like_list_entity.g.dart';

@JsonSerializable()
class QuestionLikeListEntity {
	int? status = 0;
	List<QuestionLikeListData>? data = [];

	QuestionLikeListEntity();

	factory QuestionLikeListEntity.fromJson(Map<String, dynamic> json) => $QuestionLikeListEntityFromJson(json);

	Map<String, dynamic> toJson() => $QuestionLikeListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class QuestionLikeListData {
	int? id = 0;
	int? qid = 0;
	int? userid = 0;
	String? addeddate = '';
	String? ipaddress = '';
	String? type = '';
	String? ntype = '';
	String? distype = '';
	@JSONField(name: "user_data")
	QuestionLikeListDataUserData? userData;

	QuestionLikeListData();

	factory QuestionLikeListData.fromJson(Map<String, dynamic> json) => $QuestionLikeListDataFromJson(json);

	Map<String, dynamic> toJson() => $QuestionLikeListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class QuestionLikeListDataUserData {
	String? name = '';
	String? userimage = '';
	int? id = 0;
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	QuestionLikeListDataUserData();

	factory QuestionLikeListDataUserData.fromJson(Map<String, dynamic> json) => $QuestionLikeListDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $QuestionLikeListDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}