import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/forgot_password_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/forgot_password_entity.g.dart';

@JsonSerializable()
class ForgotPasswordEntity {
	int? result = 0;
	String? message = '';
	@JSONField(name: "user_otp")
	int? userOtp = 0;
	@JSONField(name: "user_id")
	int? userId = 0;

	ForgotPasswordEntity();

	factory ForgotPasswordEntity.fromJson(Map<String, dynamic> json) => $ForgotPasswordEntityFromJson(json);

	Map<String, dynamic> toJson() => $ForgotPasswordEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}