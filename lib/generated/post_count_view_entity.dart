import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/post_count_view_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/post_count_view_entity.g.dart';

@JsonSerializable()
class PostCountViewEntity {
	int? status = 0;
	String? message = '';

	PostCountViewEntity();

	factory PostCountViewEntity.fromJson(Map<String, dynamic> json) => $PostCountViewEntityFromJson(json);

	Map<String, dynamic> toJson() => $PostCountViewEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}