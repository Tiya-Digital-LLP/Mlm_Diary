import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/notification_count_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/notification_count_entity.g.dart';

@JsonSerializable()
class NotificationCountEntity {
	int? status = 0;
	String? message = '';
	@JSONField(name: "notification_count")
	int? notificationCount = 0;

	NotificationCountEntity();

	factory NotificationCountEntity.fromJson(Map<String, dynamic> json) => $NotificationCountEntityFromJson(json);

	Map<String, dynamic> toJson() => $NotificationCountEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}