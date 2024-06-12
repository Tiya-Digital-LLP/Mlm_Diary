import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/profile_bookmark_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/profile_bookmark_entity.g.dart';

@JsonSerializable()
class ProfileBookmarkEntity {
	int? status = 0;
	String? message = '';

	ProfileBookmarkEntity();

	factory ProfileBookmarkEntity.fromJson(Map<String, dynamic> json) => $ProfileBookmarkEntityFromJson(json);

	Map<String, dynamic> toJson() => $ProfileBookmarkEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}