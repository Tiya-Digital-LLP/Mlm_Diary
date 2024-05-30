import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_sub_category_entity.dart';

GetSubCategoryEntity $GetSubCategoryEntityFromJson(Map<String, dynamic> json) {
  final GetSubCategoryEntity getSubCategoryEntity = GetSubCategoryEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getSubCategoryEntity.status = status;
  }
  final List<GetSubCategoryCategory>? category = (json['category'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetSubCategoryCategory>(e) as GetSubCategoryCategory)
      .toList();
  if (category != null) {
    getSubCategoryEntity.category = category;
  }
  return getSubCategoryEntity;
}

Map<String, dynamic> $GetSubCategoryEntityToJson(GetSubCategoryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['category'] = entity.category?.map((v) => v.toJson()).toList();
  return data;
}

extension GetSubCategoryEntityExtension on GetSubCategoryEntity {
  GetSubCategoryEntity copyWith({
    int? status,
    List<GetSubCategoryCategory>? category,
  }) {
    return GetSubCategoryEntity()
      ..status = status ?? this.status
      ..category = category ?? this.category;
  }
}

GetSubCategoryCategory $GetSubCategoryCategoryFromJson(
    Map<String, dynamic> json) {
  final GetSubCategoryCategory getSubCategoryCategory = GetSubCategoryCategory();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getSubCategoryCategory.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getSubCategoryCategory.name = name;
  }
  final String? parentId = jsonConvert.convert<String>(json['parent_id']);
  if (parentId != null) {
    getSubCategoryCategory.parentId = parentId;
  }
  final String? adddate = jsonConvert.convert<String>(json['adddate']);
  if (adddate != null) {
    getSubCategoryCategory.adddate = adddate;
  }
  final String? useradded = jsonConvert.convert<String>(json['useradded']);
  if (useradded != null) {
    getSubCategoryCategory.useradded = useradded;
  }
  final dynamic userid = json['userid'];
  if (userid != null) {
    getSubCategoryCategory.userid = userid;
  }
  return getSubCategoryCategory;
}

Map<String, dynamic> $GetSubCategoryCategoryToJson(
    GetSubCategoryCategory entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['parent_id'] = entity.parentId;
  data['adddate'] = entity.adddate;
  data['useradded'] = entity.useradded;
  data['userid'] = entity.userid;
  return data;
}

extension GetSubCategoryCategoryExtension on GetSubCategoryCategory {
  GetSubCategoryCategory copyWith({
    int? id,
    String? name,
    String? parentId,
    String? adddate,
    String? useradded,
    dynamic userid,
  }) {
    return GetSubCategoryCategory()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..parentId = parentId ?? this.parentId
      ..adddate = adddate ?? this.adddate
      ..useradded = useradded ?? this.useradded
      ..userid = userid ?? this.userid;
  }
}