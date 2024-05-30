import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_company_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_company_entity.g.dart';

@JsonSerializable()
class GetCompanyEntity {
	int? result = 0;
	String? message = '';
	List<String>? data = [];

	GetCompanyEntity();

	factory GetCompanyEntity.fromJson(Map<String, dynamic> json) => $GetCompanyEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetCompanyEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}