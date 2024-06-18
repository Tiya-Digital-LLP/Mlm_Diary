import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_company_comment_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_company_comment_entity.g.dart';

@JsonSerializable()
class GetCompanyCommentEntity {
	int? status = 0;
	List<GetCompanyCommentData>? data = [];

	GetCompanyCommentEntity();

	factory GetCompanyCommentEntity.fromJson(Map<String, dynamic> json) => $GetCompanyCommentEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetCompanyCommentEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetCompanyCommentData {
	int? id = 0;
	String? comment = '';
	String? createdate = '';
	int? userid = 0;
	String? name = '';
	String? userimage = '';
	@JSONField(name: "comments_replays")
	List<GetCompanyCommentDataCommentsReplays>? commentsReplays = [];

	GetCompanyCommentData();

	factory GetCompanyCommentData.fromJson(Map<String, dynamic> json) => $GetCompanyCommentDataFromJson(json);

	Map<String, dynamic> toJson() => $GetCompanyCommentDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetCompanyCommentDataCommentsReplays {
	int? id = 0;
	String? comment = '';
	String? createdate = '';
	int? userid = 0;
	String? name = '';
	String? userimage = '';

	GetCompanyCommentDataCommentsReplays();

	factory GetCompanyCommentDataCommentsReplays.fromJson(Map<String, dynamic> json) => $GetCompanyCommentDataCommentsReplaysFromJson(json);

	Map<String, dynamic> toJson() => $GetCompanyCommentDataCommentsReplaysToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}