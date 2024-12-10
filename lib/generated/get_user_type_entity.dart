import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_user_type_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_user_type_entity.g.dart';

@JsonSerializable()
class GetUserTypeEntity {
	List<GetUserTypeUsertype>? usertype = [];
	int? status = 0;

	GetUserTypeEntity();

	factory GetUserTypeEntity.fromJson(Map<String, dynamic> json) => $GetUserTypeEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetUserTypeEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserTypeUsertype {
	int? id = 0;
	String? name = '';

	GetUserTypeUsertype();

	factory GetUserTypeUsertype.fromJson(Map<String, dynamic> json) => $GetUserTypeUsertypeFromJson(json);

	Map<String, dynamic> toJson() => $GetUserTypeUsertypeToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}