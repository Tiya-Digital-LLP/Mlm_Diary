import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/bookmark_user_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/bookmark_user_entity.g.dart';

@JsonSerializable()
class BookmarkUserEntity {
	int? status = 0;
	String? message = '';

	BookmarkUserEntity();

	factory BookmarkUserEntity.fromJson(Map<String, dynamic> json) => $BookmarkUserEntityFromJson(json);

	Map<String, dynamic> toJson() => $BookmarkUserEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}