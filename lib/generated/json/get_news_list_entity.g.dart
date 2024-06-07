import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_news_list_entity.dart';

GetNewsListEntity $GetNewsListEntityFromJson(Map<String, dynamic> json) {
  final GetNewsListEntity getNewsListEntity = GetNewsListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getNewsListEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getNewsListEntity.message = message;
  }
  final List<GetNewsListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<GetNewsListData>(e) as GetNewsListData)
      .toList();
  if (data != null) {
    getNewsListEntity.data = data;
  }
  return getNewsListEntity;
}

Map<String, dynamic> $GetNewsListEntityToJson(GetNewsListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetNewsListEntityExtension on GetNewsListEntity {
  GetNewsListEntity copyWith({
    int? status,
    String? message,
    List<GetNewsListData>? data,
  }) {
    return GetNewsListEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

GetNewsListData $GetNewsListDataFromJson(Map<String, dynamic> json) {
  final GetNewsListData getNewsListData = GetNewsListData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getNewsListData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getNewsListData.title = title;
  }
  final String? photo = jsonConvert.convert<String>(json['photo']);
  if (photo != null) {
    getNewsListData.photo = photo;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    getNewsListData.description = description;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    getNewsListData.pgcnt = pgcnt;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getNewsListData.createdate = createdate;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    getNewsListData.category = category;
  }
  final String? creatby = jsonConvert.convert<String>(json['creatby']);
  if (creatby != null) {
    getNewsListData.creatby = creatby;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getNewsListData.status = status;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    getNewsListData.subcategory = subcategory;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    getNewsListData.website = website;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    getNewsListData.urlcomponent = urlcomponent;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    getNewsListData.totallike = totallike;
  }
  final int? totalbookmark = jsonConvert.convert<int>(json['totalbookmark']);
  if (totalbookmark != null) {
    getNewsListData.totalbookmark = totalbookmark;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    getNewsListData.totalcomment = totalcomment;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    getNewsListData.likedByUser = likedByUser;
  }
  final bool? bookmarkedByUser = jsonConvert.convert<bool>(
      json['bookmarked_by_user']);
  if (bookmarkedByUser != null) {
    getNewsListData.bookmarkedByUser = bookmarkedByUser;
  }
  final GetNewsListDataUserData? userData = jsonConvert.convert<
      GetNewsListDataUserData>(json['user_data']);
  if (userData != null) {
    getNewsListData.userData = userData;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getNewsListData.imagePath = imagePath;
  }
  return getNewsListData;
}

Map<String, dynamic> $GetNewsListDataToJson(GetNewsListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['photo'] = entity.photo;
  data['description'] = entity.description;
  data['pgcnt'] = entity.pgcnt;
  data['createdate'] = entity.createdate;
  data['category'] = entity.category;
  data['creatby'] = entity.creatby;
  data['status'] = entity.status;
  data['subcategory'] = entity.subcategory;
  data['website'] = entity.website;
  data['urlcomponent'] = entity.urlcomponent;
  data['totallike'] = entity.totallike;
  data['totalbookmark'] = entity.totalbookmark;
  data['totalcomment'] = entity.totalcomment;
  data['liked_by_user'] = entity.likedByUser;
  data['bookmarked_by_user'] = entity.bookmarkedByUser;
  data['user_data'] = entity.userData?.toJson();
  data['image_path'] = entity.imagePath;
  return data;
}

extension GetNewsListDataExtension on GetNewsListData {
  GetNewsListData copyWith({
    int? id,
    String? title,
    String? photo,
    String? description,
    int? pgcnt,
    String? createdate,
    String? category,
    String? creatby,
    int? status,
    String? subcategory,
    String? website,
    String? urlcomponent,
    int? totallike,
    int? totalbookmark,
    int? totalcomment,
    bool? likedByUser,
    bool? bookmarkedByUser,
    GetNewsListDataUserData? userData,
    String? imagePath,
  }) {
    return GetNewsListData()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..photo = photo ?? this.photo
      ..description = description ?? this.description
      ..pgcnt = pgcnt ?? this.pgcnt
      ..createdate = createdate ?? this.createdate
      ..category = category ?? this.category
      ..creatby = creatby ?? this.creatby
      ..status = status ?? this.status
      ..subcategory = subcategory ?? this.subcategory
      ..website = website ?? this.website
      ..urlcomponent = urlcomponent ?? this.urlcomponent
      ..totallike = totallike ?? this.totallike
      ..totalbookmark = totalbookmark ?? this.totalbookmark
      ..totalcomment = totalcomment ?? this.totalcomment
      ..likedByUser = likedByUser ?? this.likedByUser
      ..bookmarkedByUser = bookmarkedByUser ?? this.bookmarkedByUser
      ..userData = userData ?? this.userData
      ..imagePath = imagePath ?? this.imagePath;
  }
}

GetNewsListDataUserData $GetNewsListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final GetNewsListDataUserData getNewsListDataUserData = GetNewsListDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getNewsListDataUserData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getNewsListDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getNewsListDataUserData.userimage = userimage;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    getNewsListDataUserData.email = email;
  }
  final dynamic mobile = json['mobile'];
  if (mobile != null) {
    getNewsListDataUserData.mobile = mobile;
  }
  final dynamic countrycode1 = json['countrycode1'];
  if (countrycode1 != null) {
    getNewsListDataUserData.countrycode1 = countrycode1;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getNewsListDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getNewsListDataUserData.imageThumPath = imageThumPath;
  }
  return getNewsListDataUserData;
}

Map<String, dynamic> $GetNewsListDataUserDataToJson(
    GetNewsListDataUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['email'] = entity.email;
  data['mobile'] = entity.mobile;
  data['countrycode1'] = entity.countrycode1;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension GetNewsListDataUserDataExtension on GetNewsListDataUserData {
  GetNewsListDataUserData copyWith({
    int? id,
    String? name,
    String? userimage,
    String? email,
    dynamic mobile,
    dynamic countrycode1,
    String? imagePath,
    String? imageThumPath,
  }) {
    return GetNewsListDataUserData()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..email = email ?? this.email
      ..mobile = mobile ?? this.mobile
      ..countrycode1 = countrycode1 ?? this.countrycode1
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}