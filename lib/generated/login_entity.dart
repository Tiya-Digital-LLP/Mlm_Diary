import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/login_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/login_entity.g.dart';

@JsonSerializable()
class LoginEntity {
	int? result = 0;
	String? message = '';
	@JSONField(name: "api_token")
	String? apiToken = '';
	@JSONField(name: "redirect_to_company")
	bool? redirectToCompany = false;

	LoginEntity();

	factory LoginEntity.fromJson(Map<String, dynamic> json) => $LoginEntityFromJson(json);

	Map<String, dynamic> toJson() => $LoginEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}