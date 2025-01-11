import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_news_detail_entity.dart';

GetNewsDetailEntity $GetNewsDetailEntityFromJson(Map<String, dynamic> json) {
  final GetNewsDetailEntity getNewsDetailEntity = GetNewsDetailEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getNewsDetailEntity.status = status;
  }
  final GetNewsDetailData? data = jsonConvert.convert<GetNewsDetailData>(
      json['data']);
  if (data != null) {
    getNewsDetailEntity.data = data;
  }
  return getNewsDetailEntity;
}

Map<String, dynamic> $GetNewsDetailEntityToJson(GetNewsDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.toJson();
  return data;
}

extension GetNewsDetailEntityExtension on GetNewsDetailEntity {
  GetNewsDetailEntity copyWith({
    int? status,
    GetNewsDetailData? data,
  }) {
    return GetNewsDetailEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

GetNewsDetailData $GetNewsDetailDataFromJson(Map<String, dynamic> json) {
  final GetNewsDetailData getNewsDetailData = GetNewsDetailData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getNewsDetailData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getNewsDetailData.title = title;
  }
  final String? photo = jsonConvert.convert<String>(json['photo']);
  if (photo != null) {
    getNewsDetailData.photo = photo;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    getNewsDetailData.description = description;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    getNewsDetailData.pgcnt = pgcnt;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getNewsDetailData.createdate = createdate;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    getNewsDetailData.datemodified = datemodified;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    getNewsDetailData.category = category;
  }
  final int? creatby = jsonConvert.convert<int>(json['creatby']);
  if (creatby != null) {
    getNewsDetailData.creatby = creatby;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getNewsDetailData.status = status;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    getNewsDetailData.subcategory = subcategory;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    getNewsDetailData.website = website;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    getNewsDetailData.urlcomponent = urlcomponent;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    getNewsDetailData.totallike = totallike;
  }
  final int? totalbookmark = jsonConvert.convert<int>(json['totalbookmark']);
  if (totalbookmark != null) {
    getNewsDetailData.totalbookmark = totalbookmark;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    getNewsDetailData.totalcomment = totalcomment;
  }
  final String? fullUrl = jsonConvert.convert<String>(json['full_url']);
  if (fullUrl != null) {
    getNewsDetailData.fullUrl = fullUrl;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    getNewsDetailData.imageUrl = imageUrl;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    getNewsDetailData.likedByUser = likedByUser;
  }
  final bool? bookmarkedByUser = jsonConvert.convert<bool>(
      json['bookmarked_by_user']);
  if (bookmarkedByUser != null) {
    getNewsDetailData.bookmarkedByUser = bookmarkedByUser;
  }
  final GetNewsDetailDataUserData? userData = jsonConvert.convert<
      GetNewsDetailDataUserData>(json['user_data']);
  if (userData != null) {
    getNewsDetailData.userData = userData;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getNewsDetailData.imagePath = imagePath;
  }
  return getNewsDetailData;
}

Map<String, dynamic> $GetNewsDetailDataToJson(GetNewsDetailData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['photo'] = entity.photo;
  data['description'] = entity.description;
  data['pgcnt'] = entity.pgcnt;
  data['createdate'] = entity.createdate;
  data['datemodified'] = entity.datemodified;
  data['category'] = entity.category;
  data['creatby'] = entity.creatby;
  data['status'] = entity.status;
  data['subcategory'] = entity.subcategory;
  data['website'] = entity.website;
  data['urlcomponent'] = entity.urlcomponent;
  data['totallike'] = entity.totallike;
  data['totalbookmark'] = entity.totalbookmark;
  data['totalcomment'] = entity.totalcomment;
  data['full_url'] = entity.fullUrl;
  data['image_url'] = entity.imageUrl;
  data['liked_by_user'] = entity.likedByUser;
  data['bookmarked_by_user'] = entity.bookmarkedByUser;
  data['user_data'] = entity.userData?.toJson();
  data['image_path'] = entity.imagePath;
  return data;
}

extension GetNewsDetailDataExtension on GetNewsDetailData {
  GetNewsDetailData copyWith({
    int? id,
    String? title,
    String? photo,
    String? description,
    int? pgcnt,
    String? createdate,
    String? datemodified,
    String? category,
    int? creatby,
    int? status,
    String? subcategory,
    String? website,
    String? urlcomponent,
    int? totallike,
    int? totalbookmark,
    int? totalcomment,
    String? fullUrl,
    String? imageUrl,
    bool? likedByUser,
    bool? bookmarkedByUser,
    GetNewsDetailDataUserData? userData,
    String? imagePath,
  }) {
    return GetNewsDetailData()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..photo = photo ?? this.photo
      ..description = description ?? this.description
      ..pgcnt = pgcnt ?? this.pgcnt
      ..createdate = createdate ?? this.createdate
      ..datemodified = datemodified ?? this.datemodified
      ..category = category ?? this.category
      ..creatby = creatby ?? this.creatby
      ..status = status ?? this.status
      ..subcategory = subcategory ?? this.subcategory
      ..website = website ?? this.website
      ..urlcomponent = urlcomponent ?? this.urlcomponent
      ..totallike = totallike ?? this.totallike
      ..totalbookmark = totalbookmark ?? this.totalbookmark
      ..totalcomment = totalcomment ?? this.totalcomment
      ..fullUrl = fullUrl ?? this.fullUrl
      ..imageUrl = imageUrl ?? this.imageUrl
      ..likedByUser = likedByUser ?? this.likedByUser
      ..bookmarkedByUser = bookmarkedByUser ?? this.bookmarkedByUser
      ..userData = userData ?? this.userData
      ..imagePath = imagePath ?? this.imagePath;
  }
}

GetNewsDetailDataUserData $GetNewsDetailDataUserDataFromJson(
    Map<String, dynamic> json) {
  final GetNewsDetailDataUserData getNewsDetailDataUserData = GetNewsDetailDataUserData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getNewsDetailDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getNewsDetailDataUserData.userimage = userimage;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    getNewsDetailDataUserData.email = email;
  }
  final dynamic mobile = json['mobile'];
  if (mobile != null) {
    getNewsDetailDataUserData.mobile = mobile;
  }
  final dynamic countrycode1 = json['countrycode1'];
  if (countrycode1 != null) {
    getNewsDetailDataUserData.countrycode1 = countrycode1;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getNewsDetailDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getNewsDetailDataUserData.imageThumPath = imageThumPath;
  }
  return getNewsDetailDataUserData;
}

Map<String, dynamic> $GetNewsDetailDataUserDataToJson(
    GetNewsDetailDataUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['email'] = entity.email;
  data['mobile'] = entity.mobile;
  data['countrycode1'] = entity.countrycode1;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension GetNewsDetailDataUserDataExtension on GetNewsDetailDataUserData {
  GetNewsDetailDataUserData copyWith({
    String? name,
    String? userimage,
    String? email,
    dynamic mobile,
    dynamic countrycode1,
    String? imagePath,
    String? imageThumPath,
  }) {
    return GetNewsDetailDataUserData()
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..email = email ?? this.email
      ..mobile = mobile ?? this.mobile
      ..countrycode1 = countrycode1 ?? this.countrycode1
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}