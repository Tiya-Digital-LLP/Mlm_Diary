import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/post_bookmark_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/post_bookmark_entity.g.dart';

@JsonSerializable()
class PostBookmarkEntity {
	int? status = 0;
	String? message = '';

	PostBookmarkEntity();

	factory PostBookmarkEntity.fromJson(Map<String, dynamic> json) => $PostBookmarkEntityFromJson(json);

	Map<String, dynamic> toJson() => $PostBookmarkEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}