import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/news_count_view_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/news_count_view_entity.g.dart';

@JsonSerializable()
class NewsCountViewEntity {
	int? status = 0;
	String? message = '';

	NewsCountViewEntity();

	factory NewsCountViewEntity.fromJson(Map<String, dynamic> json) => $NewsCountViewEntityFromJson(json);

	Map<String, dynamic> toJson() => $NewsCountViewEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}