import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_new_message_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_new_message_entity.g.dart';

@JsonSerializable()
class GetNewMessageEntity {
	List<GetNewMessageMychatoverview>? mychatoverview = [];
	int? status = 0;
	String? message = '';

	GetNewMessageEntity();

	factory GetNewMessageEntity.fromJson(Map<String, dynamic> json) => $GetNewMessageEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetNewMessageEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetNewMessageMychatoverview {
	int? id = 0;
	int? toid = 0;
	int? fromid = 0;
	String? msg = '';
	@JSONField(name: "chat_id")
	String? chatId = '';
	@JSONField(name: "read_status")
	int? readStatus = 0;
	@JSONField(name: "deleted_by_user_id")
	dynamic deletedByUserId;
	@JSONField(name: "created_at")
	String? createdAt = '';
	@JSONField(name: "updated_at")
	String? updatedAt = '';
	@JSONField(name: "deleted_at")
	dynamic deletedAt;

	GetNewMessageMychatoverview();

	factory GetNewMessageMychatoverview.fromJson(Map<String, dynamic> json) => $GetNewMessageMychatoverviewFromJson(json);

	Map<String, dynamic> toJson() => $GetNewMessageMychatoverviewToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}