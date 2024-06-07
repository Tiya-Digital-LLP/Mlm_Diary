import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/post_like_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/post_like_entity.g.dart';

@JsonSerializable()
class PostLikeEntity {
	int? status = 0;
	String? message = '';

	PostLikeEntity();

	factory PostLikeEntity.fromJson(Map<String, dynamic> json) => $PostLikeEntityFromJson(json);

	Map<String, dynamic> toJson() => $PostLikeEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}