import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/delete_notification_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/delete_notification_entity.g.dart';

@JsonSerializable()
class DeleteNotificationEntity {
	int? status = 0;
	String? message = '';

	DeleteNotificationEntity();

	factory DeleteNotificationEntity.fromJson(Map<String, dynamic> json) => $DeleteNotificationEntityFromJson(json);

	Map<String, dynamic> toJson() => $DeleteNotificationEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}