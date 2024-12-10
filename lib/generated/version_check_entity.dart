import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/version_check_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/version_check_entity.g.dart';

@JsonSerializable()
class VersionCheckEntity {
	int? success = 0;
	String? message = '';

	VersionCheckEntity();

	factory VersionCheckEntity.fromJson(Map<String, dynamic> json) => $VersionCheckEntityFromJson(json);

	Map<String, dynamic> toJson() => $VersionCheckEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}