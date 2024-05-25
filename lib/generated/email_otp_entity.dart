import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/email_otp_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/email_otp_entity.g.dart';

@JsonSerializable()
class EmailOtpEntity {
	String? message = '';
	int? status = 0;
	@JSONField(name: "user_id")
	int? userId = 0;

	EmailOtpEntity();

	factory EmailOtpEntity.fromJson(Map<String, dynamic> json) => $EmailOtpEntityFromJson(json);

	Map<String, dynamic> toJson() => $EmailOtpEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}