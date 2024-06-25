import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_notification_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_notification_entity.g.dart';

@JsonSerializable()
class GetNotificationEntity {
	int? status = 0;
	String? message = '';
	List<GetNotificationData>? data = [];

	GetNotificationEntity();

	factory GetNotificationEntity.fromJson(Map<String, dynamic> json) => $GetNotificationEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetNotificationEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNotificationData {
	int? id = 0;
	int? postid = 0;
	int? userid = 0;
	int? byuserid = 0;
	String? type = '';
	@JSONField(name: "read_status")
	String? readStatus = '';
	@JSONField(name: "post_type")
	String? postType = '';
	String? creatdate = '';
	dynamic title;
	dynamic image;
	dynamic message;
	dynamic ntype;
	String? name = '';
	String? userimage = '';
	@JSONField(name: "is_admin_notification")
	String? isAdminNotification = '';

	GetNotificationData();

	factory GetNotificationData.fromJson(Map<String, dynamic> json) => $GetNotificationDataFromJson(json);

	Map<String, dynamic> toJson() => $GetNotificationDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}