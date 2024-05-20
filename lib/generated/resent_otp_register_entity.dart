import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/resent_otp_register_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/resent_otp_register_entity.g.dart';

@JsonSerializable()
class ResentOtpRegisterEntity {
	String? message = '';
	int? status = 0;
	@JSONField(name: "user_id")
	int? userId = 0;

	ResentOtpRegisterEntity();

	factory ResentOtpRegisterEntity.fromJson(Map<String, dynamic> json) => $ResentOtpRegisterEntityFromJson(json);

	Map<String, dynamic> toJson() => $ResentOtpRegisterEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}