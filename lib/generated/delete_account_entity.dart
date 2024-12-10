import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/delete_account_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/delete_account_entity.g.dart';

@JsonSerializable()
class DeleteAccountEntity {
	int? status = 0;
	String? message = '';

	DeleteAccountEntity();

	factory DeleteAccountEntity.fromJson(Map<String, dynamic> json) => $DeleteAccountEntityFromJson(json);

	Map<String, dynamic> toJson() => $DeleteAccountEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}