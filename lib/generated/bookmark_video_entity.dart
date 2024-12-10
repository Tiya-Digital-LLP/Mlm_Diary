import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/bookmark_video_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/bookmark_video_entity.g.dart';

@JsonSerializable()
class BookmarkVideoEntity {
	int? status = 0;
	String? message = '';

	BookmarkVideoEntity();

	factory BookmarkVideoEntity.fromJson(Map<String, dynamic> json) => $BookmarkVideoEntityFromJson(json);

	Map<String, dynamic> toJson() => $BookmarkVideoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}