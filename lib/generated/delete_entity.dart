import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/delete_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/delete_entity.g.dart';

@JsonSerializable()
class DeleteEntity {
	int? result = 0;
	String? message = '';
	@JSONField(name: "api_token")
	String? apiToken = '';
	@JSONField(name: "redirect_to_company")
	bool? redirectToCompany = false;
	@JSONField(name: "user_id")
	int? userId = 0;

	DeleteEntity();

	factory DeleteEntity.fromJson(Map<String, dynamic> json) => $DeleteEntityFromJson(json);

	Map<String, dynamic> toJson() => $DeleteEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}