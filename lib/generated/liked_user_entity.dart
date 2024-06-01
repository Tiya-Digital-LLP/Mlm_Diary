import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/liked_user_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/liked_user_entity.g.dart';

@JsonSerializable()
class LikedUserEntity {
	int? status = 0;
	String? message = '';

	LikedUserEntity();

	factory LikedUserEntity.fromJson(Map<String, dynamic> json) => $LikedUserEntityFromJson(json);

	Map<String, dynamic> toJson() => $LikedUserEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}