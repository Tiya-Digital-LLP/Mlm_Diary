import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/boost_on_top_classified_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/boost_on_top_classified_entity.g.dart';

@JsonSerializable()
class BoostOnTopClassifiedEntity {
	int? status = 0;
	String? message = '';

	BoostOnTopClassifiedEntity();

	factory BoostOnTopClassifiedEntity.fromJson(Map<String, dynamic> json) => $BoostOnTopClassifiedEntityFromJson(json);

	Map<String, dynamic> toJson() => $BoostOnTopClassifiedEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}