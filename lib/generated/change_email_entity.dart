import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/change_email_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/change_email_entity.g.dart';

@JsonSerializable()
class ChangeEmailEntity {
	int? result = 0;
	String? messsage = '';

	ChangeEmailEntity();

	factory ChangeEmailEntity.fromJson(Map<String, dynamic> json) => $ChangeEmailEntityFromJson(json);

	Map<String, dynamic> toJson() => $ChangeEmailEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}