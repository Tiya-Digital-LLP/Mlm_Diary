import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_company_with_selected_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_company_with_selected_entity.g.dart';

@JsonSerializable()
class GetCompanyWithSelectedEntity {
	int? status = 0;
	List<GetCompanyWithSelectedCompany>? company = [];

	GetCompanyWithSelectedEntity();

	factory GetCompanyWithSelectedEntity.fromJson(Map<String, dynamic> json) => $GetCompanyWithSelectedEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetCompanyWithSelectedEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetCompanyWithSelectedCompany {
	int? id = 0;
	String? name = '';
	bool? selected = false;

	GetCompanyWithSelectedCompany();

	factory GetCompanyWithSelectedCompany.fromJson(Map<String, dynamic> json) => $GetCompanyWithSelectedCompanyFromJson(json);

	Map<String, dynamic> toJson() => $GetCompanyWithSelectedCompanyToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}