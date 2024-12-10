import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_my_chat_detail_entity.dart';

GetMyChatDetailEntity $GetMyChatDetailEntityFromJson(
    Map<String, dynamic> json) {
  final GetMyChatDetailEntity getMyChatDetailEntity = GetMyChatDetailEntity();
  final GetMyChatDetailMychatoverview? mychatoverview = jsonConvert.convert<
      GetMyChatDetailMychatoverview>(json['mychatoverview']);
  if (mychatoverview != null) {
    getMyChatDetailEntity.mychatoverview = mychatoverview;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getMyChatDetailEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getMyChatDetailEntity.message = message;
  }
  final dynamic profilePic = json['profile_pic'];
  if (profilePic != null) {
    getMyChatDetailEntity.profilePic = profilePic;
  }
  return getMyChatDetailEntity;
}

Map<String, dynamic> $GetMyChatDetailEntityToJson(
    GetMyChatDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mychatoverview'] = entity.mychatoverview?.toJson();
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['profile_pic'] = entity.profilePic;
  return data;
}

extension GetMyChatDetailEntityExtension on GetMyChatDetailEntity {
  GetMyChatDetailEntity copyWith({
    GetMyChatDetailMychatoverview? mychatoverview,
    int? status,
    String? message,
    dynamic profilePic,
  }) {
    return GetMyChatDetailEntity()
      ..mychatoverview = mychatoverview ?? this.mychatoverview
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..profilePic = profilePic ?? this.profilePic;
  }
}

GetMyChatDetailMychatoverview $GetMyChatDetailMychatoverviewFromJson(
    Map<String, dynamic> json) {
  final GetMyChatDetailMychatoverview getMyChatDetailMychatoverview = GetMyChatDetailMychatoverview();
  final int? currentPage = jsonConvert.convert<int>(json['current_page']);
  if (currentPage != null) {
    getMyChatDetailMychatoverview.currentPage = currentPage;
  }
  final List<GetMyChatDetailMychatoverviewData>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetMyChatDetailMychatoverviewData>(
          e) as GetMyChatDetailMychatoverviewData).toList();
  if (data != null) {
    getMyChatDetailMychatoverview.data = data;
  }
  final String? firstPageUrl = jsonConvert.convert<String>(
      json['first_page_url']);
  if (firstPageUrl != null) {
    getMyChatDetailMychatoverview.firstPageUrl = firstPageUrl;
  }
  final int? from = jsonConvert.convert<int>(json['from']);
  if (from != null) {
    getMyChatDetailMychatoverview.from = from;
  }
  final int? lastPage = jsonConvert.convert<int>(json['last_page']);
  if (lastPage != null) {
    getMyChatDetailMychatoverview.lastPage = lastPage;
  }
  final String? lastPageUrl = jsonConvert.convert<String>(
      json['last_page_url']);
  if (lastPageUrl != null) {
    getMyChatDetailMychatoverview.lastPageUrl = lastPageUrl;
  }
  final List<
      GetMyChatDetailMychatoverviewLinks>? links = (json['links'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetMyChatDetailMychatoverviewLinks>(
          e) as GetMyChatDetailMychatoverviewLinks).toList();
  if (links != null) {
    getMyChatDetailMychatoverview.links = links;
  }
  final dynamic nextPageUrl = json['next_page_url'];
  if (nextPageUrl != null) {
    getMyChatDetailMychatoverview.nextPageUrl = nextPageUrl;
  }
  final String? path = jsonConvert.convert<String>(json['path']);
  if (path != null) {
    getMyChatDetailMychatoverview.path = path;
  }
  final int? perPage = jsonConvert.convert<int>(json['per_page']);
  if (perPage != null) {
    getMyChatDetailMychatoverview.perPage = perPage;
  }
  final dynamic prevPageUrl = json['prev_page_url'];
  if (prevPageUrl != null) {
    getMyChatDetailMychatoverview.prevPageUrl = prevPageUrl;
  }
  final int? to = jsonConvert.convert<int>(json['to']);
  if (to != null) {
    getMyChatDetailMychatoverview.to = to;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    getMyChatDetailMychatoverview.total = total;
  }
  return getMyChatDetailMychatoverview;
}

Map<String, dynamic> $GetMyChatDetailMychatoverviewToJson(
    GetMyChatDetailMychatoverview entity) {
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

extension GetMyChatDetailMychatoverviewExtension on GetMyChatDetailMychatoverview {
  GetMyChatDetailMychatoverview copyWith({
    int? currentPage,
    List<GetMyChatDetailMychatoverviewData>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<GetMyChatDetailMychatoverviewLinks>? links,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) {
    return GetMyChatDetailMychatoverview()
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

GetMyChatDetailMychatoverviewData $GetMyChatDetailMychatoverviewDataFromJson(
    Map<String, dynamic> json) {
  final GetMyChatDetailMychatoverviewData getMyChatDetailMychatoverviewData = GetMyChatDetailMychatoverviewData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getMyChatDetailMychatoverviewData.id = id;
  }
  final int? toid = jsonConvert.convert<int>(json['toid']);
  if (toid != null) {
    getMyChatDetailMychatoverviewData.toid = toid;
  }
  final int? fromid = jsonConvert.convert<int>(json['fromid']);
  if (fromid != null) {
    getMyChatDetailMychatoverviewData.fromid = fromid;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getMyChatDetailMychatoverviewData.msg = msg;
  }
  final String? chatId = jsonConvert.convert<String>(json['chat_id']);
  if (chatId != null) {
    getMyChatDetailMychatoverviewData.chatId = chatId;
  }
  final int? readStatus = jsonConvert.convert<int>(json['read_status']);
  if (readStatus != null) {
    getMyChatDetailMychatoverviewData.readStatus = readStatus;
  }
  final dynamic deletedByUserId = json['deleted_by_user_id'];
  if (deletedByUserId != null) {
    getMyChatDetailMychatoverviewData.deletedByUserId = deletedByUserId;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    getMyChatDetailMychatoverviewData.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    getMyChatDetailMychatoverviewData.updatedAt = updatedAt;
  }
  final dynamic deletedAt = json['deleted_at'];
  if (deletedAt != null) {
    getMyChatDetailMychatoverviewData.deletedAt = deletedAt;
  }
  return getMyChatDetailMychatoverviewData;
}

Map<String, dynamic> $GetMyChatDetailMychatoverviewDataToJson(
    GetMyChatDetailMychatoverviewData entity) {
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

extension GetMyChatDetailMychatoverviewDataExtension on GetMyChatDetailMychatoverviewData {
  GetMyChatDetailMychatoverviewData copyWith({
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
    return GetMyChatDetailMychatoverviewData()
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

GetMyChatDetailMychatoverviewLinks $GetMyChatDetailMychatoverviewLinksFromJson(
    Map<String, dynamic> json) {
  final GetMyChatDetailMychatoverviewLinks getMyChatDetailMychatoverviewLinks = GetMyChatDetailMychatoverviewLinks();
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    getMyChatDetailMychatoverviewLinks.url = url;
  }
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    getMyChatDetailMychatoverviewLinks.label = label;
  }
  final bool? active = jsonConvert.convert<bool>(json['active']);
  if (active != null) {
    getMyChatDetailMychatoverviewLinks.active = active;
  }
  return getMyChatDetailMychatoverviewLinks;
}

Map<String, dynamic> $GetMyChatDetailMychatoverviewLinksToJson(
    GetMyChatDetailMychatoverviewLinks entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['url'] = entity.url;
  data['label'] = entity.label;
  data['active'] = entity.active;
  return data;
}

extension GetMyChatDetailMychatoverviewLinksExtension on GetMyChatDetailMychatoverviewLinks {
  GetMyChatDetailMychatoverviewLinks copyWith({
    String? url,
    String? label,
    bool? active,
  }) {
    return GetMyChatDetailMychatoverviewLinks()
      ..url = url ?? this.url
      ..label = label ?? this.label
      ..active = active ?? this.active;
  }
}