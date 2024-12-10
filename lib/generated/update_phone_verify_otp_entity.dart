import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/update_phone_verify_otp_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/update_phone_verify_otp_entity.g.dart';

@JsonSerializable()
class UpdatePhoneVerifyOtpEntity {
	int? status = 0;
	String? message = '';

	UpdatePhoneVerifyOtpEntity();

	factory UpdatePhoneVerifyOtpEntity.fromJson(Map<String, dynamic> json) => $UpdatePhoneVerifyOtpEntityFromJson(json);

	Map<String, dynamic> toJson() => $UpdatePhoneVerifyOtpEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}