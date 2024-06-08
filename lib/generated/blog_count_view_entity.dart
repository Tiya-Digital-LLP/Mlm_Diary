import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/blog_count_view_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/blog_count_view_entity.g.dart';

@JsonSerializable()
class BlogCountViewEntity {
	int? status = 0;
	String? message = '';

	BlogCountViewEntity();

	factory BlogCountViewEntity.fromJson(Map<String, dynamic> json) => $BlogCountViewEntityFromJson(json);

	Map<String, dynamic> toJson() => $BlogCountViewEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}