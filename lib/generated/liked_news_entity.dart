import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/liked_news_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/liked_news_entity.g.dart';

@JsonSerializable()
class LikedNewsEntity {
	int? status = 0;
	String? message = '';

	LikedNewsEntity();

	factory LikedNewsEntity.fromJson(Map<String, dynamic> json) => $LikedNewsEntityFromJson(json);

	Map<String, dynamic> toJson() => $LikedNewsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}