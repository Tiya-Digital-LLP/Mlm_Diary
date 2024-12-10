import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/domestic_phoneotp_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/domestic_phoneotp_entity.g.dart';

@JsonSerializable()
class DomesticPhoneotpEntity {
	String? message = '';
	int? status = 0;
	@JSONField(name: "user_id")
	int? userId = 0;

	DomesticPhoneotpEntity();

	factory DomesticPhoneotpEntity.fromJson(Map<String, dynamic> json) => $DomesticPhoneotpEntityFromJson(json);

	Map<String, dynamic> toJson() => $DomesticPhoneotpEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}