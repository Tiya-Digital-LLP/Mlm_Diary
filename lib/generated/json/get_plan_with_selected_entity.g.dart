import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_plan_with_selected_entity.dart';

GetPlanWithSelectedEntity $GetPlanWithSelectedEntityFromJson(
    Map<String, dynamic> json) {
  final GetPlanWithSelectedEntity getPlanWithSelectedEntity = GetPlanWithSelectedEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getPlanWithSelectedEntity.status = status;
  }
  final List<GetPlanWithSelectedPlan>? plan = (json['plan'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetPlanWithSelectedPlan>(
          e) as GetPlanWithSelectedPlan)
      .toList();
  if (plan != null) {
    getPlanWithSelectedEntity.plan = plan;
  }
  return getPlanWithSelectedEntity;
}

Map<String, dynamic> $GetPlanWithSelectedEntityToJson(
    GetPlanWithSelectedEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['plan'] = entity.plan?.map((v) => v.toJson()).toList();
  return data;
}

extension GetPlanWithSelectedEntityExtension on GetPlanWithSelectedEntity {
  GetPlanWithSelectedEntity copyWith({
    int? status,
    List<GetPlanWithSelectedPlan>? plan,
  }) {
    return GetPlanWithSelectedEntity()
      ..status = status ?? this.status
      ..plan = plan ?? this.plan;
  }
}

GetPlanWithSelectedPlan $GetPlanWithSelectedPlanFromJson(
    Map<String, dynamic> json) {
  final GetPlanWithSelectedPlan getPlanWithSelectedPlan = GetPlanWithSelectedPlan();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getPlanWithSelectedPlan.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getPlanWithSelectedPlan.name = name;
  }
  final String? addby = jsonConvert.convert<String>(json['addby']);
  if (addby != null) {
    getPlanWithSelectedPlan.addby = addby;
  }
  final String? active = jsonConvert.convert<String>(json['active']);
  if (active != null) {
    getPlanWithSelectedPlan.active = active;
  }
  final String? adddate = jsonConvert.convert<String>(json['adddate']);
  if (adddate != null) {
    getPlanWithSelectedPlan.adddate = adddate;
  }
  final int? sortorder = jsonConvert.convert<int>(json['sortorder']);
  if (sortorder != null) {
    getPlanWithSelectedPlan.sortorder = sortorder;
  }
  final bool? selected = jsonConvert.convert<bool>(json['selected']);
  if (selected != null) {
    getPlanWithSelectedPlan.selected = selected;
  }
  return getPlanWithSelectedPlan;
}

Map<String, dynamic> $GetPlanWithSelectedPlanToJson(
    GetPlanWithSelectedPlan entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['addby'] = entity.addby;
  data['active'] = entity.active;
  data['adddate'] = entity.adddate;
  data['sortorder'] = entity.sortorder;
  data['selected'] = entity.selected;
  return data;
}

extension GetPlanWithSelectedPlanExtension on GetPlanWithSelectedPlan {
  GetPlanWithSelectedPlan copyWith({
    int? id,
    String? name,
    String? addby,
    String? active,
    String? adddate,
    int? sortorder,
    bool? selected,
  }) {
    return GetPlanWithSelectedPlan()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..addby = addby ?? this.addby
      ..active = active ?? this.active
      ..adddate = adddate ?? this.adddate
      ..sortorder = sortorder ?? this.sortorder
      ..selected = selected ?? this.selected;
  }
}