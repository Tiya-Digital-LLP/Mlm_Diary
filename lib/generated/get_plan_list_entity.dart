import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_plan_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_plan_list_entity.g.dart';

@JsonSerializable()
class GetPlanListEntity {
	int? status = 0;
	List<GetPlanListPlan>? plan = [];

	GetPlanListEntity();

	factory GetPlanListEntity.fromJson(Map<String, dynamic> json) => $GetPlanListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetPlanListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetPlanListPlan {
	int? id = 0;
	String? name = '';
	String? addby = '';
	String? active = '';
	String? adddate = '';
	int? sortorder = 0;

	GetPlanListPlan();

	factory GetPlanListPlan.fromJson(Map<String, dynamic> json) => $GetPlanListPlanFromJson(json);

	Map<String, dynamic> toJson() => $GetPlanListPlanToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}