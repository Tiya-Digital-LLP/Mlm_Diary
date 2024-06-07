import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/bookmark_news_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/bookmark_news_entity.g.dart';

@JsonSerializable()
class BookmarkNewsEntity {
	int? status = 0;
	String? message = '';

	BookmarkNewsEntity();

	factory BookmarkNewsEntity.fromJson(Map<String, dynamic> json) => $BookmarkNewsEntityFromJson(json);

	Map<String, dynamic> toJson() => $BookmarkNewsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}