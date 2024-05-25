import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/change_password_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/change_password_entity.g.dart';

@JsonSerializable()
class ChangePasswordEntity {
	int? result = 0;
	String? message = '';

	ChangePasswordEntity();

	factory ChangePasswordEntity.fromJson(Map<String, dynamic> json) => $ChangePasswordEntityFromJson(json);

	Map<String, dynamic> toJson() => $ChangePasswordEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}