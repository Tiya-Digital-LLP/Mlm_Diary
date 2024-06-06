import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/l_iked_blog_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/l_iked_blog_entity.g.dart';

@JsonSerializable()
class LIkedBlogEntity {
	int? status = 0;
	String? message = '';

	LIkedBlogEntity();

	factory LIkedBlogEntity.fromJson(Map<String, dynamic> json) => $LIkedBlogEntityFromJson(json);

	Map<String, dynamic> toJson() => $LIkedBlogEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}