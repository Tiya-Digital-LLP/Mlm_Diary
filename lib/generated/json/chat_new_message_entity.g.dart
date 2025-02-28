import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/chat_new_message_entity.dart';

ChatNewMessageEntity $ChatNewMessageEntityFromJson(Map<String, dynamic> json) {
  final ChatNewMessageEntity chatNewMessageEntity = ChatNewMessageEntity();
  final List<
      ChatNewMessageMychatoverview>? mychatoverview = (json['mychatoverview'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<ChatNewMessageMychatoverview>(
          e) as ChatNewMessageMychatoverview).toList();
  if (mychatoverview != null) {
    chatNewMessageEntity.mychatoverview = mychatoverview;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    chatNewMessageEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    chatNewMessageEntity.message = message;
  }
  return chatNewMessageEntity;
}

Map<String, dynamic> $ChatNewMessageEntityToJson(ChatNewMessageEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mychatoverview'] =
      entity.mychatoverview?.map((v) => v.toJson()).toList();
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension ChatNewMessageEntityExtension on ChatNewMessageEntity {
  ChatNewMessageEntity copyWith({
    List<ChatNewMessageMychatoverview>? mychatoverview,
    int? status,
    String? message,
  }) {
    return ChatNewMessageEntity()
      ..mychatoverview = mychatoverview ?? this.mychatoverview
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}

ChatNewMessageMychatoverview $ChatNewMessageMychatoverviewFromJson(
    Map<String, dynamic> json) {
  final ChatNewMessageMychatoverview chatNewMessageMychatoverview = ChatNewMessageMychatoverview();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    chatNewMessageMychatoverview.id = id;
  }
  final int? toid = jsonConvert.convert<int>(json['toid']);
  if (toid != null) {
    chatNewMessageMychatoverview.toid = toid;
  }
  final int? fromid = jsonConvert.convert<int>(json['fromid']);
  if (fromid != null) {
    chatNewMessageMychatoverview.fromid = fromid;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    chatNewMessageMychatoverview.msg = msg;
  }
  final String? chatId = jsonConvert.convert<String>(json['chat_id']);
  if (chatId != null) {
    chatNewMessageMychatoverview.chatId = chatId;
  }
  final int? readStatus = jsonConvert.convert<int>(json['read_status']);
  if (readStatus != null) {
    chatNewMessageMychatoverview.readStatus = readStatus;
  }
  final dynamic deletedByUserId = json['deleted_by_user_id'];
  if (deletedByUserId != null) {
    chatNewMessageMychatoverview.deletedByUserId = deletedByUserId;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    chatNewMessageMychatoverview.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    chatNewMessageMychatoverview.updatedAt = updatedAt;
  }
  final dynamic deletedAt = json['deleted_at'];
  if (deletedAt != null) {
    chatNewMessageMychatoverview.deletedAt = deletedAt;
  }
  return chatNewMessageMychatoverview;
}

Map<String, dynamic> $ChatNewMessageMychatoverviewToJson(
    ChatNewMessageMychatoverview entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['toid'] = entity.toid;
  data['fromid'] = entity.fromid;
  data['msg'] = entity.msg;
  data['chat_id'] = entity.chatId;
  data['read_status'] = entity.readStatus;
  data['deleted_by_user_id'] = entity.deletedByUserId;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  data['deleted_at'] = entity.deletedAt;
  return data;
}

extension ChatNewMessageMychatoverviewExtension on ChatNewMessageMychatoverview {
  ChatNewMessageMychatoverview copyWith({
    int? id,
    int? toid,
    int? fromid,
    String? msg,
    String? chatId,
    int? readStatus,
    dynamic deletedByUserId,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) {
    return ChatNewMessageMychatoverview()
      ..id = id ?? this.id
      ..toid = toid ?? this.toid
      ..fromid = fromid ?? this.fromid
      ..msg = msg ?? this.msg
      ..chatId = chatId ?? this.chatId
      ..readStatus = readStatus ?? this.readStatus
      ..deletedByUserId = deletedByUserId ?? this.deletedByUserId
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..deletedAt = deletedAt ?? this.deletedAt;
  }
}