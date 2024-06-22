import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_plan_with_selected_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_plan_with_selected_entity.g.dart';

@JsonSerializable()
class GetPlanWithSelectedEntity {
	int? status = 0;
	List<GetPlanWithSelectedPlan>? plan = [];

	GetPlanWithSelectedEntity();

	factory GetPlanWithSelectedEntity.fromJson(Map<String, dynamic> json) => $GetPlanWithSelectedEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetPlanWithSelectedEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetPlanWithSelectedPlan {
	int? id = 0;
	String? name = '';
	String? addby = '';
	String? active = '';
	String? adddate = '';
	int? sortorder = 0;
	bool? selected = false;

	GetPlanWithSelectedPlan();

	factory GetPlanWithSelectedPlan.fromJson(Map<String, dynamic> json) => $GetPlanWithSelectedPlanFromJson(json);

	Map<String, dynamic> toJson() => $GetPlanWithSelectedPlanToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}