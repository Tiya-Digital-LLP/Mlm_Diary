import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/mlm_like_company_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/mlm_like_company_entity.g.dart';

@JsonSerializable()
class MlmLikeCompanyEntity {
	int? status = 0;
	String? message = '';

	MlmLikeCompanyEntity();

	factory MlmLikeCompanyEntity.fromJson(Map<String, dynamic> json) => $MlmLikeCompanyEntityFromJson(json);

	Map<String, dynamic> toJson() => $MlmLikeCompanyEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}