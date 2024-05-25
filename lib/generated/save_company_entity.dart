import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/save_company_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/save_company_entity.g.dart';

@JsonSerializable()
class SaveCompanyEntity {
	int? status = 0;
	String? message = '';
	@JSONField(name: "api_token")
	String? apiToken = '';
	@JSONField(name: "user_data")
	SaveCompanyUserData? userData;

	SaveCompanyEntity();

	factory SaveCompanyEntity.fromJson(Map<String, dynamic> json) => $SaveCompanyEntityFromJson(json);

	Map<String, dynamic> toJson() => $SaveCompanyEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SaveCompanyUserData {
	int? id = 0;
	String? sex = '';
	String? company = '';
	String? plan = '';
	String? address = '';
	String? city = '';
	String? state = '';
	String? pincode = '';
	String? country = '';
	String? userimage = '';

	SaveCompanyUserData();

	factory SaveCompanyUserData.fromJson(Map<String, dynamic> json) => $SaveCompanyUserDataFromJson(json);

	Map<String, dynamic> toJson() => $SaveCompanyUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}