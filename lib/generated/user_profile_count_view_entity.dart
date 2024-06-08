import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/user_profile_count_view_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/user_profile_count_view_entity.g.dart';

@JsonSerializable()
class UserProfileCountViewEntity {
	int? status = 0;
	String? message = '';

	UserProfileCountViewEntity();

	factory UserProfileCountViewEntity.fromJson(Map<String, dynamic> json) => $UserProfileCountViewEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserProfileCountViewEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}