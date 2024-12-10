import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_plan_list_entity.dart';

GetPlanListEntity $GetPlanListEntityFromJson(Map<String, dynamic> json) {
  final GetPlanListEntity getPlanListEntity = GetPlanListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getPlanListEntity.status = status;
  }
  final List<GetPlanListPlan>? plan = (json['plan'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<GetPlanListPlan>(e) as GetPlanListPlan)
      .toList();
  if (plan != null) {
    getPlanListEntity.plan = plan;
  }
  return getPlanListEntity;
}

Map<String, dynamic> $GetPlanListEntityToJson(GetPlanListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['plan'] = entity.plan?.map((v) => v.toJson()).toList();
  return data;
}

extension GetPlanListEntityExtension on GetPlanListEntity {
  GetPlanListEntity copyWith({
    int? status,
    List<GetPlanListPlan>? plan,
  }) {
    return GetPlanListEntity()
      ..status = status ?? this.status
      ..plan = plan ?? this.plan;
  }
}

GetPlanListPlan $GetPlanListPlanFromJson(Map<String, dynamic> json) {
  final GetPlanListPlan getPlanListPlan = GetPlanListPlan();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getPlanListPlan.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getPlanListPlan.name = name;
  }
  final String? addby = jsonConvert.convert<String>(json['addby']);
  if (addby != null) {
    getPlanListPlan.addby = addby;
  }
  final String? active = jsonConvert.convert<String>(json['active']);
  if (active != null) {
    getPlanListPlan.active = active;
  }
  final String? adddate = jsonConvert.convert<String>(json['adddate']);
  if (adddate != null) {
    getPlanListPlan.adddate = adddate;
  }
  final int? sortorder = jsonConvert.convert<int>(json['sortorder']);
  if (sortorder != null) {
    getPlanListPlan.sortorder = sortorder;
  }
  return getPlanListPlan;
}

Map<String, dynamic> $GetPlanListPlanToJson(GetPlanListPlan entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['addby'] = entity.addby;
  data['active'] = entity.active;
  data['adddate'] = entity.adddate;
  data['sortorder'] = entity.sortorder;
  return data;
}

extension GetPlanListPlanExtension on GetPlanListPlan {
  GetPlanListPlan copyWith({
    int? id,
    String? name,
    String? addby,
    String? active,
    String? adddate,
    int? sortorder,
  }) {
    return GetPlanListPlan()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..addby = addby ?? this.addby
      ..active = active ?? this.active
      ..adddate = adddate ?? this.adddate
      ..sortorder = sortorder ?? this.sortorder;
  }
}