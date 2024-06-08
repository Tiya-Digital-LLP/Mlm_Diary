import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/classified_count_view_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/classified_count_view_entity.g.dart';

@JsonSerializable()
class ClassifiedCountViewEntity {
	int? status = 0;
	String? message = '';

	ClassifiedCountViewEntity();

	factory ClassifiedCountViewEntity.fromJson(Map<String, dynamic> json) => $ClassifiedCountViewEntityFromJson(json);

	Map<String, dynamic> toJson() => $ClassifiedCountViewEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}