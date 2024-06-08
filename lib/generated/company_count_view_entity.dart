import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/company_count_view_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/company_count_view_entity.g.dart';

@JsonSerializable()
class CompanyCountViewEntity {
	int? status = 0;
	String? message = '';

	CompanyCountViewEntity();

	factory CompanyCountViewEntity.fromJson(Map<String, dynamic> json) => $CompanyCountViewEntityFromJson(json);

	Map<String, dynamic> toJson() => $CompanyCountViewEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}