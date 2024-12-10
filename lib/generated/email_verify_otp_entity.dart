import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/email_verify_otp_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/email_verify_otp_entity.g.dart';

@JsonSerializable()
class EmailVerifyOtpEntity {
	int? result = 0;
	String? message = '';

	EmailVerifyOtpEntity();

	factory EmailVerifyOtpEntity.fromJson(Map<String, dynamic> json) => $EmailVerifyOtpEntityFromJson(json);

	Map<String, dynamic> toJson() => $EmailVerifyOtpEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}