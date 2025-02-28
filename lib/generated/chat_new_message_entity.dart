import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/chat_new_message_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/chat_new_message_entity.g.dart';

@JsonSerializable()
class ChatNewMessageEntity {
	List<ChatNewMessageMychatoverview>? mychatoverview = [];
	int? status = 0;
	String? message = '';

	ChatNewMessageEntity();

	factory ChatNewMessageEntity.fromJson(Map<String, dynamic> json) => $ChatNewMessageEntityFromJson(json);

	Map<String, dynamic> toJson() => $ChatNewMessageEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ChatNewMessageMychatoverview {
	int? id = 0;
	int? toid = 0;
	int? fromid = 0;
	String? msg = '';
	@JSONField(name: 'chat_id')
	String? chatId = '';
	@JSONField(name: 'read_status')
	int? readStatus = 0;
	@JSONField(name: 'deleted_by_user_id')
	dynamic deletedByUserId;
	@JSONField(name: 'created_at')
	String? createdAt = '';
	@JSONField(name: 'updated_at')
	String? updatedAt = '';
	@JSONField(name: 'deleted_at')
	dynamic deletedAt;

	ChatNewMessageMychatoverview();

	factory ChatNewMessageMychatoverview.fromJson(Map<String, dynamic> json) => $ChatNewMessageMychatoverviewFromJson(json);

	Map<String, dynamic> toJson() => $ChatNewMessageMychatoverviewToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}