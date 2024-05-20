import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/foreignphone_otp_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/foreignphone_otp_entity.g.dart';

@JsonSerializable()
class ForeignphoneOtpEntity {
	String? message = '';
	int? status = 0;
	@JSONField(name: "user_id")
	int? userId = 0;

	ForeignphoneOtpEntity();

	factory ForeignphoneOtpEntity.fromJson(Map<String, dynamic> json) => $ForeignphoneOtpEntityFromJson(json);

	Map<String, dynamic> toJson() => $ForeignphoneOtpEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}