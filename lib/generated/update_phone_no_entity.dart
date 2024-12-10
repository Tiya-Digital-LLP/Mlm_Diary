import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/update_phone_no_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/update_phone_no_entity.g.dart';

@JsonSerializable()
class UpdatePhoneNoEntity {
	int? status = 0;
	String? message = '';

	UpdatePhoneNoEntity();

	factory UpdatePhoneNoEntity.fromJson(Map<String, dynamic> json) => $UpdatePhoneNoEntityFromJson(json);

	Map<String, dynamic> toJson() => $UpdatePhoneNoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}