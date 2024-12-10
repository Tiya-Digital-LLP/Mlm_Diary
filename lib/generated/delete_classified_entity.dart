import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/delete_classified_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/delete_classified_entity.g.dart';

@JsonSerializable()
class DeleteClassifiedEntity {
	int? status = 0;
	String? message = '';

	DeleteClassifiedEntity();

	factory DeleteClassifiedEntity.fromJson(Map<String, dynamic> json) => $DeleteClassifiedEntityFromJson(json);

	Map<String, dynamic> toJson() => $DeleteClassifiedEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}