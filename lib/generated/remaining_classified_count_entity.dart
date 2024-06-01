import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/remaining_classified_count_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/remaining_classified_count_entity.g.dart';

@JsonSerializable()
class RemainingClassifiedCountEntity {
	int? status = 0;
	String? message = '';

	RemainingClassifiedCountEntity();

	factory RemainingClassifiedCountEntity.fromJson(Map<String, dynamic> json) => $RemainingClassifiedCountEntityFromJson(json);

	Map<String, dynamic> toJson() => $RemainingClassifiedCountEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}