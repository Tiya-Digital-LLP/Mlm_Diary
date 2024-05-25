import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/user_register_entity_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/user_register_entity_entity.g.dart';

@JsonSerializable()
class UserRegisterEntityEntity {
	String? message = '';
	int? status = 0;
	@JSONField(name: "user_id")
	int? userId = 0;
	@JSONField(name: "api_token")
	String? apiToken = '';

	UserRegisterEntityEntity();

	factory UserRegisterEntityEntity.fromJson(Map<String, dynamic> json) => $UserRegisterEntityEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserRegisterEntityEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}