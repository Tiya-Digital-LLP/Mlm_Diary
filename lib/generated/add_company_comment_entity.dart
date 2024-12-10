import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/add_company_comment_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/add_company_comment_entity.g.dart';

@JsonSerializable()
class AddCompanyCommentEntity {
	int? status = 0;
	String? message = '';
	AddCompanyCommentData? data;

	AddCompanyCommentEntity();

	factory AddCompanyCommentEntity.fromJson(Map<String, dynamic> json) => $AddCompanyCommentEntityFromJson(json);

	Map<String, dynamic> toJson() => $AddCompanyCommentEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AddCompanyCommentData {
	String? oid = '';
	int? userid = 0;
	@JSONField(name: "parent_id")
	String? parentId = '';
	String? comment = '';
	String? createdate = '';
	int? id = 0;

	AddCompanyCommentData();

	factory AddCompanyCommentData.fromJson(Map<String, dynamic> json) => $AddCompanyCommentDataFromJson(json);

	Map<String, dynamic> toJson() => $AddCompanyCommentDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}