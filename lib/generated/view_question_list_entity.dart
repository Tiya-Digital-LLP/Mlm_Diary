import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/view_question_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/view_question_list_entity.g.dart';

@JsonSerializable()
class ViewQuestionListEntity {
	int? status = 0;
	List<ViewQuestionListData>? data = [];

	ViewQuestionListEntity();

	factory ViewQuestionListEntity.fromJson(Map<String, dynamic> json) => $ViewQuestionListEntityFromJson(json);

	Map<String, dynamic> toJson() => $ViewQuestionListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ViewQuestionListData {
	int? id = 0;
	int? qid = 0;
	@JSONField(name: 'user_id')
	int? userId = 0;
	@JSONField(name: 'created_at')
	String? createdAt = '';
	@JSONField(name: 'user_data')
	ViewQuestionListDataUserData? userData;

	ViewQuestionListData();

	factory ViewQuestionListData.fromJson(Map<String, dynamic> json) => $ViewQuestionListDataFromJson(json);

	Map<String, dynamic> toJson() => $ViewQuestionListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ViewQuestionListDataUserData {
	int? id = 0;
	String? name = '';
	String? userimage = '';
	String? immlm = '';
	String? city = '';
	String? state = '';
	String? country = '';
	@JSONField(name: 'image_path')
	String? imagePath = '';
	@JSONField(name: 'image_thum_path')
	String? imageThumPath = '';

	ViewQuestionListDataUserData();

	factory ViewQuestionListDataUserData.fromJson(Map<String, dynamic> json) => $ViewQuestionListDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $ViewQuestionListDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}