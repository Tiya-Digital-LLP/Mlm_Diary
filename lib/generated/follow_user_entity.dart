import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/follow_user_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/follow_user_entity.g.dart';

@JsonSerializable()
class FollowUserEntity {
	int? status = 0;
	String? message = '';

	FollowUserEntity();

	factory FollowUserEntity.fromJson(Map<String, dynamic> json) => $FollowUserEntityFromJson(json);

	Map<String, dynamic> toJson() => $FollowUserEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}