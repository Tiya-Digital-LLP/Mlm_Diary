import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_category_entity.dart';

GetCategoryEntity $GetCategoryEntityFromJson(Map<String, dynamic> json) {
  final GetCategoryEntity getCategoryEntity = GetCategoryEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getCategoryEntity.status = status;
  }
  final List<GetCategoryCategory>? category = (json['category'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetCategoryCategory>(e) as GetCategoryCategory)
      .toList();
  if (category != null) {
    getCategoryEntity.category = category;
  }
  return getCategoryEntity;
}

Map<String, dynamic> $GetCategoryEntityToJson(GetCategoryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['category'] = entity.category?.map((v) => v.toJson()).toList();
  return data;
}

extension GetCategoryEntityExtension on GetCategoryEntity {
  GetCategoryEntity copyWith({
    int? status,
    List<GetCategoryCategory>? category,
  }) {
    return GetCategoryEntity()
      ..status = status ?? this.status
      ..category = category ?? this.category;
  }
}

GetCategoryCategory $GetCategoryCategoryFromJson(Map<String, dynamic> json) {
  final GetCategoryCategory getCategoryCategory = GetCategoryCategory();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getCategoryCategory.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getCategoryCategory.name = name;
  }
  final String? parentId = jsonConvert.convert<String>(json['parent_id']);
  if (parentId != null) {
    getCategoryCategory.parentId = parentId;
  }
  final String? adddate = jsonConvert.convert<String>(json['adddate']);
  if (adddate != null) {
    getCategoryCategory.adddate = adddate;
  }
  final String? useradded = jsonConvert.convert<String>(json['useradded']);
  if (useradded != null) {
    getCategoryCategory.useradded = useradded;
  }
  final dynamic userid = json['userid'];
  if (userid != null) {
    getCategoryCategory.userid = userid;
  }
  return getCategoryCategory;
}

Map<String, dynamic> $GetCategoryCategoryToJson(GetCategoryCategory entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['parent_id'] = entity.parentId;
  data['adddate'] = entity.adddate;
  data['useradded'] = entity.useradded;
  data['userid'] = entity.userid;
  return data;
}

extension GetCategoryCategoryExtension on GetCategoryCategory {
  GetCategoryCategory copyWith({
    int? id,
    String? name,
    String? parentId,
    String? adddate,
    String? useradded,
    dynamic userid,
  }) {
    return GetCategoryCategory()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..parentId = parentId ?? this.parentId
      ..adddate = adddate ?? this.adddate
      ..useradded = useradded ?? this.useradded
      ..userid = userid ?? this.userid;
  }
}