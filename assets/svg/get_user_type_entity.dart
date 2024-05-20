import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_user_type_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_user_type_entity.g.dart';

@JsonSerializable()
class GetUserTypeEntity {
	int? result = 0;
	List<GetUserTypeData>? data = [];
	String? message = '';

	GetUserTypeEntity();

	factory GetUserTypeEntity.fromJson(Map<String, dynamic> json) => $GetUserTypeEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetUserTypeEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserTypeData {
	String? id = '';
	String? name = '';

	GetUserTypeData();

	factory GetUserTypeData.fromJson(Map<String, dynamic> json) => $GetUserTypeDataFromJson(json);

	Map<String, dynamic> toJson() => $GetUserTypeDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}