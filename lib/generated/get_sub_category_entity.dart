import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_sub_category_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_sub_category_entity.g.dart';

@JsonSerializable()
class GetSubCategoryEntity {
	int? status = 0;
	List<GetSubCategoryCategory>? category = [];

	GetSubCategoryEntity();

	factory GetSubCategoryEntity.fromJson(Map<String, dynamic> json) => $GetSubCategoryEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetSubCategoryEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetSubCategoryCategory {
	int? id = 0;
	String? name = '';
	@JSONField(name: "parent_id")
	String? parentId = '';
	String? adddate = '';
	String? useradded = '';
	dynamic userid;

	GetSubCategoryCategory();

	factory GetSubCategoryCategory.fromJson(Map<String, dynamic> json) => $GetSubCategoryCategoryFromJson(json);

	Map<String, dynamic> toJson() => $GetSubCategoryCategoryToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}