import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/boost_on_top_classified_premium_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/boost_on_top_classified_premium_entity.g.dart';

@JsonSerializable()
class BoostOnTopClassifiedPremiumEntity {
	int? status = 0;
	String? message = '';

	BoostOnTopClassifiedPremiumEntity();

	factory BoostOnTopClassifiedPremiumEntity.fromJson(Map<String, dynamic> json) => $BoostOnTopClassifiedPremiumEntityFromJson(json);

	Map<String, dynamic> toJson() => $BoostOnTopClassifiedPremiumEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}