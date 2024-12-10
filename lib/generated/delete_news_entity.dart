import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/delete_news_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/delete_news_entity.g.dart';

@JsonSerializable()
class DeleteNewsEntity {
	int? status = 0;
	String? message = '';

	DeleteNewsEntity();

	factory DeleteNewsEntity.fromJson(Map<String, dynamic> json) => $DeleteNewsEntityFromJson(json);

	Map<String, dynamic> toJson() => $DeleteNewsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}