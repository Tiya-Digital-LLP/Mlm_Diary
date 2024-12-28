import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_new_message_entity.dart';

GetNewMessageEntity $GetNewMessageEntityFromJson(Map<String, dynamic> json) {
  final GetNewMessageEntity getNewMessageEntity = GetNewMessageEntity();
  final List<
      GetNewMessageMychatoverview>? mychatoverview = (json['mychatoverview'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetNewMessageMychatoverview>(
          e) as GetNewMessageMychatoverview).toList();
  if (mychatoverview != null) {
    getNewMessageEntity.mychatoverview = mychatoverview;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getNewMessageEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getNewMessageEntity.message = message;
  }
  return getNewMessageEntity;
}

Map<String, dynamic> $GetNewMessageEntityToJson(GetNewMessageEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mychatoverview'] =
      entity.mychatoverview?.map((v) => v.toJson()).toList();
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension GetNewMessageEntityExtension on GetNewMessageEntity {
  GetNewMessageEntity copyWith({
    List<GetNewMessageMychatoverview>? mychatoverview,
    int? status,
    String? message,
  }) {
    return GetNewMessageEntity()
      ..mychatoverview = mychatoverview ?? this.mychatoverview
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}

GetNewMessageMychatoverview $GetNewMessageMychatoverviewFromJson(
    Map<String, dynamic> json) {
  final GetNewMessageMychatoverview getNewMessageMychatoverview = GetNewMessageMychatoverview();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getNewMessageMychatoverview.id = id;
  }
  final int? toid = jsonConvert.convert<int>(json['toid']);
  if (toid != null) {
    getNewMessageMychatoverview.toid = toid;
  }
  final int? fromid = jsonConvert.convert<int>(json['fromid']);
  if (fromid != null) {
    getNewMessageMychatoverview.fromid = fromid;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getNewMessageMychatoverview.msg = msg;
  }
  final String? chatId = jsonConvert.convert<String>(json['chat_id']);
  if (chatId != null) {
    getNewMessageMychatoverview.chatId = chatId;
  }
  final int? readStatus = jsonConvert.convert<int>(json['read_status']);
  if (readStatus != null) {
    getNewMessageMychatoverview.readStatus = readStatus;
  }
  final dynamic deletedByUserId = json['deleted_by_user_id'];
  if (deletedByUserId != null) {
    getNewMessageMychatoverview.deletedByUserId = deletedByUserId;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    getNewMessageMychatoverview.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    getNewMessageMychatoverview.updatedAt = updatedAt;
  }
  final dynamic deletedAt = json['deleted_at'];
  if (deletedAt != null) {
    getNewMessageMychatoverview.deletedAt = deletedAt;
  }
  return getNewMessageMychatoverview;
}

Map<String, dynamic> $GetNewMessageMychatoverviewToJson(
    GetNewMessageMychatoverview entity) {
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

extension GetNewMessageMychatoverviewExtension on GetNewMessageMychatoverview {
  GetNewMessageMychatoverview copyWith({
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
    return GetNewMessageMychatoverview()
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