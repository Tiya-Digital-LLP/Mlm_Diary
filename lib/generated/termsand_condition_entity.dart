import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/termsand_condition_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/termsand_condition_entity.g.dart';

@JsonSerializable()
class TermsandConditionEntity {
	int? status = 0;
	String? policy = '';

	TermsandConditionEntity();

	factory TermsandConditionEntity.fromJson(Map<String, dynamic> json) => $TermsandConditionEntityFromJson(json);

	Map<String, dynamic> toJson() => $TermsandConditionEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}