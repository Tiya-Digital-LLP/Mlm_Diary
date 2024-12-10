import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/delete_user_post_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/delete_user_post_entity.g.dart';

@JsonSerializable()
class DeleteUserPostEntity {
	int? status = 0;
	String? message = '';

	DeleteUserPostEntity();

	factory DeleteUserPostEntity.fromJson(Map<String, dynamic> json) => $DeleteUserPostEntityFromJson(json);

	Map<String, dynamic> toJson() => $DeleteUserPostEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}