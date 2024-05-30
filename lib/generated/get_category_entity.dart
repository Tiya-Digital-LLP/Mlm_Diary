import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_category_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_category_entity.g.dart';

@JsonSerializable()
class GetCategoryEntity {
	int? status = 0;
	List<GetCategoryCategory>? category = [];

	GetCategoryEntity();

	factory GetCategoryEntity.fromJson(Map<String, dynamic> json) => $GetCategoryEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetCategoryEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetCategoryCategory {
	int? id = 0;
	String? name = '';
	@JSONField(name: "parent_id")
	String? parentId = '';
	String? adddate = '';
	String? useradded = '';
	dynamic userid;

	GetCategoryCategory();

	factory GetCategoryCategory.fromJson(Map<String, dynamic> json) => $GetCategoryCategoryFromJson(json);

	Map<String, dynamic> toJson() => $GetCategoryCategoryToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}