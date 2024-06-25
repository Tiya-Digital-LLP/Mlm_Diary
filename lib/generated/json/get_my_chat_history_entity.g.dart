import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_my_chat_history_entity.dart';

GetMyChatHistoryEntity $GetMyChatHistoryEntityFromJson(
    Map<String, dynamic> json) {
  final GetMyChatHistoryEntity getMyChatHistoryEntity = GetMyChatHistoryEntity();
  final GetMyChatHistoryMychatoverview? mychatoverview = jsonConvert.convert<
      GetMyChatHistoryMychatoverview>(json['mychatoverview']);
  if (mychatoverview != null) {
    getMyChatHistoryEntity.mychatoverview = mychatoverview;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getMyChatHistoryEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getMyChatHistoryEntity.message = message;
  }
  return getMyChatHistoryEntity;
}

Map<String, dynamic> $GetMyChatHistoryEntityToJson(
    GetMyChatHistoryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mychatoverview'] = entity.mychatoverview?.toJson();
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension GetMyChatHistoryEntityExtension on GetMyChatHistoryEntity {
  GetMyChatHistoryEntity copyWith({
    GetMyChatHistoryMychatoverview? mychatoverview,
    int? status,
    String? message,
  }) {
    return GetMyChatHistoryEntity()
      ..mychatoverview = mychatoverview ?? this.mychatoverview
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}

GetMyChatHistoryMychatoverview $GetMyChatHistoryMychatoverviewFromJson(
    Map<String, dynamic> json) {
  final GetMyChatHistoryMychatoverview getMyChatHistoryMychatoverview = GetMyChatHistoryMychatoverview();
  final int? currentPage = jsonConvert.convert<int>(json['current_page']);
  if (currentPage != null) {
    getMyChatHistoryMychatoverview.currentPage = currentPage;
  }
  final List<GetMyChatHistoryMychatoverviewData>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetMyChatHistoryMychatoverviewData>(
          e) as GetMyChatHistoryMychatoverviewData).toList();
  if (data != null) {
    getMyChatHistoryMychatoverview.data = data;
  }
  final String? firstPageUrl = jsonConvert.convert<String>(
      json['first_page_url']);
  if (firstPageUrl != null) {
    getMyChatHistoryMychatoverview.firstPageUrl = firstPageUrl;
  }
  final int? from = jsonConvert.convert<int>(json['from']);
  if (from != null) {
    getMyChatHistoryMychatoverview.from = from;
  }
  final int? lastPage = jsonConvert.convert<int>(json['last_page']);
  if (lastPage != null) {
    getMyChatHistoryMychatoverview.lastPage = lastPage;
  }
  final String? lastPageUrl = jsonConvert.convert<String>(
      json['last_page_url']);
  if (lastPageUrl != null) {
    getMyChatHistoryMychatoverview.lastPageUrl = lastPageUrl;
  }
  final List<
      GetMyChatHistoryMychatoverviewLinks>? links = (json['links'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetMyChatHistoryMychatoverviewLinks>(
          e) as GetMyChatHistoryMychatoverviewLinks).toList();
  if (links != null) {
    getMyChatHistoryMychatoverview.links = links;
  }
  final dynamic nextPageUrl = json['next_page_url'];
  if (nextPageUrl != null) {
    getMyChatHistoryMychatoverview.nextPageUrl = nextPageUrl;
  }
  final String? path = jsonConvert.convert<String>(json['path']);
  if (path != null) {
    getMyChatHistoryMychatoverview.path = path;
  }
  final int? perPage = jsonConvert.convert<int>(json['per_page']);
  if (perPage != null) {
    getMyChatHistoryMychatoverview.perPage = perPage;
  }
  final dynamic prevPageUrl = json['prev_page_url'];
  if (prevPageUrl != null) {
    getMyChatHistoryMychatoverview.prevPageUrl = prevPageUrl;
  }
  final int? to = jsonConvert.convert<int>(json['to']);
  if (to != null) {
    getMyChatHistoryMychatoverview.to = to;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    getMyChatHistoryMychatoverview.total = total;
  }
  return getMyChatHistoryMychatoverview;
}

Map<String, dynamic> $GetMyChatHistoryMychatoverviewToJson(
    GetMyChatHistoryMychatoverview entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['current_page'] = entity.currentPage;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['first_page_url'] = entity.firstPageUrl;
  data['from'] = entity.from;
  data['last_page'] = entity.lastPage;
  data['last_page_url'] = entity.lastPageUrl;
  data['links'] = entity.links?.map((v) => v.toJson()).toList();
  data['next_page_url'] = entity.nextPageUrl;
  data['path'] = entity.path;
  data['per_page'] = entity.perPage;
  data['prev_page_url'] = entity.prevPageUrl;
  data['to'] = entity.to;
  data['total'] = entity.total;
  return data;
}

extension GetMyChatHistoryMychatoverviewExtension on GetMyChatHistoryMychatoverview {
  GetMyChatHistoryMychatoverview copyWith({
    int? currentPage,
    List<GetMyChatHistoryMychatoverviewData>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<GetMyChatHistoryMychatoverviewLinks>? links,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) {
    return GetMyChatHistoryMychatoverview()
      ..currentPage = currentPage ?? this.currentPage
      ..data = data ?? this.data
      ..firstPageUrl = firstPageUrl ?? this.firstPageUrl
      ..from = from ?? this.from
      ..lastPage = lastPage ?? this.lastPage
      ..lastPageUrl = lastPageUrl ?? this.lastPageUrl
      ..links = links ?? this.links
      ..nextPageUrl = nextPageUrl ?? this.nextPageUrl
      ..path = path ?? this.path
      ..perPage = perPage ?? this.perPage
      ..prevPageUrl = prevPageUrl ?? this.prevPageUrl
      ..to = to ?? this.to
      ..total = total ?? this.total;
  }
}

GetMyChatHistoryMychatoverviewData $GetMyChatHistoryMychatoverviewDataFromJson(
    Map<String, dynamic> json) {
  final GetMyChatHistoryMychatoverviewData getMyChatHistoryMychatoverviewData = GetMyChatHistoryMychatoverviewData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getMyChatHistoryMychatoverviewData.id = id;
  }
  final int? toid = jsonConvert.convert<int>(json['toid']);
  if (toid != null) {
    getMyChatHistoryMychatoverviewData.toid = toid;
  }
  final int? fromid = jsonConvert.convert<int>(json['fromid']);
  if (fromid != null) {
    getMyChatHistoryMychatoverviewData.fromid = fromid;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getMyChatHistoryMychatoverviewData.msg = msg;
  }
  final String? chatId = jsonConvert.convert<String>(json['chat_id']);
  if (chatId != null) {
    getMyChatHistoryMychatoverviewData.chatId = chatId;
  }
  final int? readStatus = jsonConvert.convert<int>(json['read_status']);
  if (readStatus != null) {
    getMyChatHistoryMychatoverviewData.readStatus = readStatus;
  }
  final dynamic deletedByUserId = json['deleted_by_user_id'];
  if (deletedByUserId != null) {
    getMyChatHistoryMychatoverviewData.deletedByUserId = deletedByUserId;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    getMyChatHistoryMychatoverviewData.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    getMyChatHistoryMychatoverviewData.updatedAt = updatedAt;
  }
  final dynamic deletedAt = json['deleted_at'];
  if (deletedAt != null) {
    getMyChatHistoryMychatoverviewData.deletedAt = deletedAt;
  }
  final int? countOfEnread = jsonConvert.convert<int>(json['count_of_enread']);
  if (countOfEnread != null) {
    getMyChatHistoryMychatoverviewData.countOfEnread = countOfEnread;
  }
  final int? otherUserId = jsonConvert.convert<int>(json['other_user_id']);
  if (otherUserId != null) {
    getMyChatHistoryMychatoverviewData.otherUserId = otherUserId;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    getMyChatHistoryMychatoverviewData.username = username;
  }
  final dynamic userImage = json['userImage'];
  if (userImage != null) {
    getMyChatHistoryMychatoverviewData.userImage = userImage;
  }
  return getMyChatHistoryMychatoverviewData;
}

Map<String, dynamic> $GetMyChatHistoryMychatoverviewDataToJson(
    GetMyChatHistoryMychatoverviewData entity) {
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
  data['count_of_enread'] = entity.countOfEnread;
  data['other_user_id'] = entity.otherUserId;
  data['username'] = entity.username;
  data['userImage'] = entity.userImage;
  return data;
}

extension GetMyChatHistoryMychatoverviewDataExtension on GetMyChatHistoryMychatoverviewData {
  GetMyChatHistoryMychatoverviewData copyWith({
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
    int? countOfEnread,
    int? otherUserId,
    String? username,
    dynamic userImage,
  }) {
    return GetMyChatHistoryMychatoverviewData()
      ..id = id ?? this.id
      ..toid = toid ?? this.toid
      ..fromid = fromid ?? this.fromid
      ..msg = msg ?? this.msg
      ..chatId = chatId ?? this.chatId
      ..readStatus = readStatus ?? this.readStatus
      ..deletedByUserId = deletedByUserId ?? this.deletedByUserId
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..deletedAt = deletedAt ?? this.deletedAt
      ..countOfEnread = countOfEnread ?? this.countOfEnread
      ..otherUserId = otherUserId ?? this.otherUserId
      ..username = username ?? this.username
      ..userImage = userImage ?? this.userImage;
  }
}

GetMyChatHistoryMychatoverviewLinks $GetMyChatHistoryMychatoverviewLinksFromJson(
    Map<String, dynamic> json) {
  final GetMyChatHistoryMychatoverviewLinks getMyChatHistoryMychatoverviewLinks = GetMyChatHistoryMychatoverviewLinks();
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    getMyChatHistoryMychatoverviewLinks.url = url;
  }
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    getMyChatHistoryMychatoverviewLinks.label = label;
  }
  final bool? active = jsonConvert.convert<bool>(json['active']);
  if (active != null) {
    getMyChatHistoryMychatoverviewLinks.active = active;
  }
  return getMyChatHistoryMychatoverviewLinks;
}

Map<String, dynamic> $GetMyChatHistoryMychatoverviewLinksToJson(
    GetMyChatHistoryMychatoverviewLinks entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['url'] = entity.url;
  data['label'] = entity.label;
  data['active'] = entity.active;
  return data;
}

extension GetMyChatHistoryMychatoverviewLinksExtension on GetMyChatHistoryMychatoverviewLinks {
  GetMyChatHistoryMychatoverviewLinks copyWith({
    String? url,
    String? label,
    bool? active,
  }) {
    return GetMyChatHistoryMychatoverviewLinks()
      ..url = url ?? this.url
      ..label = label ?? this.label
      ..active = active ?? this.active;
  }
}