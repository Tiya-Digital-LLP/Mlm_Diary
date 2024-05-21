import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/user_register_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/user_register_entity.g.dart';

@JsonSerializable()
class UserRegisterEntity {
	String? message = '';
	int? status = 0;
	@JSONField(name: "user_id")
	int? userId = 0;

	UserRegisterEntity();

	factory UserRegisterEntity.fromJson(Map<String, dynamic> json) => $UserRegisterEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserRegisterEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}