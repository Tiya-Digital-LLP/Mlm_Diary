import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/database_detail_entity.dart';

DatabaseDetailEntity $DatabaseDetailEntityFromJson(Map<String, dynamic> json) {
  final DatabaseDetailEntity databaseDetailEntity = DatabaseDetailEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    databaseDetailEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    databaseDetailEntity.message = message;
  }
  final DatabaseDetailData? data = jsonConvert.convert<DatabaseDetailData>(
      json['data']);
  if (data != null) {
    databaseDetailEntity.data = data;
  }
  return databaseDetailEntity;
}

Map<String, dynamic> $DatabaseDetailEntityToJson(DatabaseDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension DatabaseDetailEntityExtension on DatabaseDetailEntity {
  DatabaseDetailEntity copyWith({
    int? status,
    String? message,
    DatabaseDetailData? data,
  }) {
    return DatabaseDetailEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

DatabaseDetailData $DatabaseDetailDataFromJson(Map<String, dynamic> json) {
  final DatabaseDetailData databaseDetailData = DatabaseDetailData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    databaseDetailData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    databaseDetailData.name = name;
  }
  final String? sex = jsonConvert.convert<String>(json['sex']);
  if (sex != null) {
    databaseDetailData.sex = sex;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    databaseDetailData.email = email;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    databaseDetailData.mobile = mobile;
  }
  final dynamic aboutcompany = json['aboutcompany'];
  if (aboutcompany != null) {
    databaseDetailData.aboutcompany = aboutcompany;
  }
  final dynamic aboutyou = json['aboutyou'];
  if (aboutyou != null) {
    databaseDetailData.aboutyou = aboutyou;
  }
  final String? immlm = jsonConvert.convert<String>(json['immlm']);
  if (immlm != null) {
    databaseDetailData.immlm = immlm;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    databaseDetailData.userimage = userimage;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    databaseDetailData.city = city;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    databaseDetailData.state = state;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    databaseDetailData.country = country;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    databaseDetailData.company = company;
  }
  final String? plan = jsonConvert.convert<String>(json['plan']);
  if (plan != null) {
    databaseDetailData.plan = plan;
  }
  final int? views = jsonConvert.convert<int>(json['views']);
  if (views != null) {
    databaseDetailData.views = views;
  }
  final int? followersCount = jsonConvert.convert<int>(json['followers_count']);
  if (followersCount != null) {
    databaseDetailData.followersCount = followersCount;
  }
  final int? followingCount = jsonConvert.convert<int>(json['following_count']);
  if (followingCount != null) {
    databaseDetailData.followingCount = followingCount;
  }
  final bool? followStatus = jsonConvert.convert<bool>(json['follow_status']);
  if (followStatus != null) {
    databaseDetailData.followStatus = followStatus;
  }
  final bool? favStatus = jsonConvert.convert<bool>(json['fav_status']);
  if (favStatus != null) {
    databaseDetailData.favStatus = favStatus;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    databaseDetailData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    databaseDetailData.imageThumPath = imageThumPath;
  }
  return databaseDetailData;
}

Map<String, dynamic> $DatabaseDetailDataToJson(DatabaseDetailData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['sex'] = entity.sex;
  data['email'] = entity.email;
  data['mobile'] = entity.mobile;
  data['aboutcompany'] = entity.aboutcompany;
  data['aboutyou'] = entity.aboutyou;
  data['immlm'] = entity.immlm;
  data['userimage'] = entity.userimage;
  data['city'] = entity.city;
  data['state'] = entity.state;
  data['country'] = entity.country;
  data['company'] = entity.company;
  data['plan'] = entity.plan;
  data['views'] = entity.views;
  data['followers_count'] = entity.followersCount;
  data['following_count'] = entity.followingCount;
  data['follow_status'] = entity.followStatus;
  data['fav_status'] = entity.favStatus;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension DatabaseDetailDataExtension on DatabaseDetailData {
  DatabaseDetailData copyWith({
    int? id,
    String? name,
    String? sex,
    String? email,
    String? mobile,
    dynamic aboutcompany,
    dynamic aboutyou,
    String? immlm,
    String? userimage,
    String? city,
    String? state,
    String? country,
    String? company,
    String? plan,
    int? views,
    int? followersCount,
    int? followingCount,
    bool? followStatus,
    bool? favStatus,
    String? imagePath,
    String? imageThumPath,
  }) {
    return DatabaseDetailData()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..sex = sex ?? this.sex
      ..email = email ?? this.email
      ..mobile = mobile ?? this.mobile
      ..aboutcompany = aboutcompany ?? this.aboutcompany
      ..aboutyou = aboutyou ?? this.aboutyou
      ..immlm = immlm ?? this.immlm
      ..userimage = userimage ?? this.userimage
      ..city = city ?? this.city
      ..state = state ?? this.state
      ..country = country ?? this.country
      ..company = company ?? this.company
      ..plan = plan ?? this.plan
      ..views = views ?? this.views
      ..followersCount = followersCount ?? this.followersCount
      ..followingCount = followingCount ?? this.followingCount
      ..followStatus = followStatus ?? this.followStatus
      ..favStatus = favStatus ?? this.favStatus
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}