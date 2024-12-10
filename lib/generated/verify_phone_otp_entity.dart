import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/verify_phone_otp_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/verify_phone_otp_entity.g.dart';

@JsonSerializable()
class VerifyPhoneOtpEntity {
	String? message = '';
	int? status = 0;
	@JSONField(name: "user_id")
	int? userId = 0;

	VerifyPhoneOtpEntity();

	factory VerifyPhoneOtpEntity.fromJson(Map<String, dynamic> json) => $VerifyPhoneOtpEntityFromJson(json);

	Map<String, dynamic> toJson() => $VerifyPhoneOtpEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}