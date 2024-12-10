import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/blog_bookmark_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/blog_bookmark_entity.g.dart';

@JsonSerializable()
class BlogBookmarkEntity {
	int? status = 0;
	String? message = '';

	BlogBookmarkEntity();

	factory BlogBookmarkEntity.fromJson(Map<String, dynamic> json) => $BlogBookmarkEntityFromJson(json);

	Map<String, dynamic> toJson() => $BlogBookmarkEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}