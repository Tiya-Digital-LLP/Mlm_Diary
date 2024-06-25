import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_notification_entity.dart';

GetNotificationEntity $GetNotificationEntityFromJson(
    Map<String, dynamic> json) {
  final GetNotificationEntity getNotificationEntity = GetNotificationEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getNotificationEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getNotificationEntity.message = message;
  }
  final List<GetNotificationData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetNotificationData>(e) as GetNotificationData)
      .toList();
  if (data != null) {
    getNotificationEntity.data = data;
  }
  return getNotificationEntity;
}

Map<String, dynamic> $GetNotificationEntityToJson(
    GetNotificationEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetNotificationEntityExtension on GetNotificationEntity {
  GetNotificationEntity copyWith({
    int? status,
    String? message,
    List<GetNotificationData>? data,
  }) {
    return GetNotificationEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

GetNotificationData $GetNotificationDataFromJson(Map<String, dynamic> json) {
  final GetNotificationData getNotificationData = GetNotificationData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getNotificationData.id = id;
  }
  final int? postid = jsonConvert.convert<int>(json['postid']);
  if (postid != null) {
    getNotificationData.postid = postid;
  }
  final int? userid = jsonConvert.convert<int>(json['userid']);
  if (userid != null) {
    getNotificationData.userid = userid;
  }
  final int? byuserid = jsonConvert.convert<int>(json['byuserid']);
  if (byuserid != null) {
    getNotificationData.byuserid = byuserid;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    getNotificationData.type = type;
  }
  final String? readStatus = jsonConvert.convert<String>(json['read_status']);
  if (readStatus != null) {
    getNotificationData.readStatus = readStatus;
  }
  final String? postType = jsonConvert.convert<String>(json['post_type']);
  if (postType != null) {
    getNotificationData.postType = postType;
  }
  final String? creatdate = jsonConvert.convert<String>(json['creatdate']);
  if (creatdate != null) {
    getNotificationData.creatdate = creatdate;
  }
  final dynamic title = json['title'];
  if (title != null) {
    getNotificationData.title = title;
  }
  final dynamic image = json['image'];
  if (image != null) {
    getNotificationData.image = image;
  }
  final dynamic message = json['message'];
  if (message != null) {
    getNotificationData.message = message;
  }
  final dynamic ntype = json['ntype'];
  if (ntype != null) {
    getNotificationData.ntype = ntype;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getNotificationData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getNotificationData.userimage = userimage;
  }
  final String? isAdminNotification = jsonConvert.convert<String>(
      json['is_admin_notification']);
  if (isAdminNotification != null) {
    getNotificationData.isAdminNotification = isAdminNotification;
  }
  return getNotificationData;
}

Map<String, dynamic> $GetNotificationDataToJson(GetNotificationData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['postid'] = entity.postid;
  data['userid'] = entity.userid;
  data['byuserid'] = entity.byuserid;
  data['type'] = entity.type;
  data['read_status'] = entity.readStatus;
  data['post_type'] = entity.postType;
  data['creatdate'] = entity.creatdate;
  data['title'] = entity.title;
  data['image'] = entity.image;
  data['message'] = entity.message;
  data['ntype'] = entity.ntype;
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['is_admin_notification'] = entity.isAdminNotification;
  return data;
}

extension GetNotificationDataExtension on GetNotificationData {
  GetNotificationData copyWith({
    int? id,
    int? postid,
    int? userid,
    int? byuserid,
    String? type,
    String? readStatus,
    String? postType,
    String? creatdate,
    dynamic title,
    dynamic image,
    dynamic message,
    dynamic ntype,
    String? name,
    String? userimage,
    String? isAdminNotification,
  }) {
    return GetNotificationData()
      ..id = id ?? this.id
      ..postid = postid ?? this.postid
      ..userid = userid ?? this.userid
      ..byuserid = byuserid ?? this.byuserid
      ..type = type ?? this.type
      ..readStatus = readStatus ?? this.readStatus
      ..postType = postType ?? this.postType
      ..creatdate = creatdate ?? this.creatdate
      ..title = title ?? this.title
      ..image = image ?? this.image
      ..message = message ?? this.message
      ..ntype = ntype ?? this.ntype
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..isAdminNotification = isAdminNotification ?? this.isAdminNotification;
  }
}