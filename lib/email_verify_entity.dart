import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/email_verify_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/email_verify_entity.g.dart';

@JsonSerializable()
class EmailVerifyEntity {
	String? message = '';
	int? status = 0;
	@JSONField(name: "user_id")
	int? userId = 0;

	EmailVerifyEntity();

	factory EmailVerifyEntity.fromJson(Map<String, dynamic> json) => $EmailVerifyEntityFromJson(json);

	Map<String, dynamic> toJson() => $EmailVerifyEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}