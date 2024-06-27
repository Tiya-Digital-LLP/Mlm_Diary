import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_classified_detail_entity.dart';

GetClassifiedDetailEntity $GetClassifiedDetailEntityFromJson(
    Map<String, dynamic> json) {
  final GetClassifiedDetailEntity getClassifiedDetailEntity = GetClassifiedDetailEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getClassifiedDetailEntity.status = status;
  }
  final GetClassifiedDetailData? data = jsonConvert.convert<
      GetClassifiedDetailData>(json['data']);
  if (data != null) {
    getClassifiedDetailEntity.data = data;
  }
  return getClassifiedDetailEntity;
}

Map<String, dynamic> $GetClassifiedDetailEntityToJson(
    GetClassifiedDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.toJson();
  return data;
}

extension GetClassifiedDetailEntityExtension on GetClassifiedDetailEntity {
  GetClassifiedDetailEntity copyWith({
    int? status,
    GetClassifiedDetailData? data,
  }) {
    return GetClassifiedDetailEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

GetClassifiedDetailData $GetClassifiedDetailDataFromJson(
    Map<String, dynamic> json) {
  final GetClassifiedDetailData getClassifiedDetailData = GetClassifiedDetailData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getClassifiedDetailData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getClassifiedDetailData.title = title;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    getClassifiedDetailData.image = image;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    getClassifiedDetailData.description = description;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    getClassifiedDetailData.pgcnt = pgcnt;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    getClassifiedDetailData.company = company;
  }
  final String? premiumsdate = jsonConvert.convert<String>(
      json['premiumsdate']);
  if (premiumsdate != null) {
    getClassifiedDetailData.premiumsdate = premiumsdate;
  }
  final String? premiumedate = jsonConvert.convert<String>(
      json['premiumedate']);
  if (premiumedate != null) {
    getClassifiedDetailData.premiumedate = premiumedate;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    getClassifiedDetailData.datemodified = datemodified;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getClassifiedDetailData.createdate = createdate;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    getClassifiedDetailData.category = category;
  }
  final String? creatby = jsonConvert.convert<String>(json['creatby']);
  if (creatby != null) {
    getClassifiedDetailData.creatby = creatby;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    getClassifiedDetailData.subcategory = subcategory;
  }
  final String? popular = jsonConvert.convert<String>(json['popular']);
  if (popular != null) {
    getClassifiedDetailData.popular = popular;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    getClassifiedDetailData.website = website;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    getClassifiedDetailData.city = city;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    getClassifiedDetailData.state = state;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    getClassifiedDetailData.country = country;
  }
  final dynamic lat = json['lat'];
  if (lat != null) {
    getClassifiedDetailData.lat = lat;
  }
  final dynamic lng = json['lng'];
  if (lng != null) {
    getClassifiedDetailData.lng = lng;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    getClassifiedDetailData.urlcomponent = urlcomponent;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    getClassifiedDetailData.totallike = totallike;
  }
  final int? totalbookmark = jsonConvert.convert<int>(json['totalbookmark']);
  if (totalbookmark != null) {
    getClassifiedDetailData.totalbookmark = totalbookmark;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    getClassifiedDetailData.totalcomment = totalcomment;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    getClassifiedDetailData.likedByUser = likedByUser;
  }
  final bool? bookmarkedByUser = jsonConvert.convert<bool>(
      json['bookmarked_by_user']);
  if (bookmarkedByUser != null) {
    getClassifiedDetailData.bookmarkedByUser = bookmarkedByUser;
  }
  final GetClassifiedDetailDataUserData? userData = jsonConvert.convert<
      GetClassifiedDetailDataUserData>(json['user_data']);
  if (userData != null) {
    getClassifiedDetailData.userData = userData;
  }
  final String? fullUrl = jsonConvert.convert<String>(json['full_url']);
  if (fullUrl != null) {
    getClassifiedDetailData.fullUrl = fullUrl;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    getClassifiedDetailData.imageUrl = imageUrl;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getClassifiedDetailData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getClassifiedDetailData.imageThumPath = imageThumPath;
  }
  return getClassifiedDetailData;
}

Map<String, dynamic> $GetClassifiedDetailDataToJson(
    GetClassifiedDetailData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['image'] = entity.image;
  data['description'] = entity.description;
  data['pgcnt'] = entity.pgcnt;
  data['company'] = entity.company;
  data['premiumsdate'] = entity.premiumsdate;
  data['premiumedate'] = entity.premiumedate;
  data['datemodified'] = entity.datemodified;
  data['createdate'] = entity.createdate;
  data['category'] = entity.category;
  data['creatby'] = entity.creatby;
  data['subcategory'] = entity.subcategory;
  data['popular'] = entity.popular;
  data['website'] = entity.website;
  data['city'] = entity.city;
  data['state'] = entity.state;
  data['country'] = entity.country;
  data['lat'] = entity.lat;
  data['lng'] = entity.lng;
  data['urlcomponent'] = entity.urlcomponent;
  data['totallike'] = entity.totallike;
  data['totalbookmark'] = entity.totalbookmark;
  data['totalcomment'] = entity.totalcomment;
  data['liked_by_user'] = entity.likedByUser;
  data['bookmarked_by_user'] = entity.bookmarkedByUser;
  data['user_data'] = entity.userData?.toJson();
  data['full_url'] = entity.fullUrl;
  data['image_url'] = entity.imageUrl;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension GetClassifiedDetailDataExtension on GetClassifiedDetailData {
  GetClassifiedDetailData copyWith({
    int? id,
    String? title,
    String? image,
    String? description,
    int? pgcnt,
    String? company,
    String? premiumsdate,
    String? premiumedate,
    String? datemodified,
    String? createdate,
    String? category,
    String? creatby,
    String? subcategory,
    String? popular,
    String? website,
    String? city,
    String? state,
    String? country,
    dynamic lat,
    dynamic lng,
    String? urlcomponent,
    int? totallike,
    int? totalbookmark,
    int? totalcomment,
    bool? likedByUser,
    bool? bookmarkedByUser,
    GetClassifiedDetailDataUserData? userData,
    String? fullUrl,
    String? imageUrl,
    String? imagePath,
    String? imageThumPath,
  }) {
    return GetClassifiedDetailData()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..image = image ?? this.image
      ..description = description ?? this.description
      ..pgcnt = pgcnt ?? this.pgcnt
      ..company = company ?? this.company
      ..premiumsdate = premiumsdate ?? this.premiumsdate
      ..premiumedate = premiumedate ?? this.premiumedate
      ..datemodified = datemodified ?? this.datemodified
      ..createdate = createdate ?? this.createdate
      ..category = category ?? this.category
      ..creatby = creatby ?? this.creatby
      ..subcategory = subcategory ?? this.subcategory
      ..popular = popular ?? this.popular
      ..website = website ?? this.website
      ..city = city ?? this.city
      ..state = state ?? this.state
      ..country = country ?? this.country
      ..lat = lat ?? this.lat
      ..lng = lng ?? this.lng
      ..urlcomponent = urlcomponent ?? this.urlcomponent
      ..totallike = totallike ?? this.totallike
      ..totalbookmark = totalbookmark ?? this.totalbookmark
      ..totalcomment = totalcomment ?? this.totalcomment
      ..likedByUser = likedByUser ?? this.likedByUser
      ..bookmarkedByUser = bookmarkedByUser ?? this.bookmarkedByUser
      ..userData = userData ?? this.userData
      ..fullUrl = fullUrl ?? this.fullUrl
      ..imageUrl = imageUrl ?? this.imageUrl
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}

GetClassifiedDetailDataUserData $GetClassifiedDetailDataUserDataFromJson(
    Map<String, dynamic> json) {
  final GetClassifiedDetailDataUserData getClassifiedDetailDataUserData = GetClassifiedDetailDataUserData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getClassifiedDetailDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getClassifiedDetailDataUserData.userimage = userimage;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    getClassifiedDetailDataUserData.email = email;
  }
  final dynamic mobile = json['mobile'];
  if (mobile != null) {
    getClassifiedDetailDataUserData.mobile = mobile;
  }
  final dynamic countrycode1 = json['countrycode1'];
  if (countrycode1 != null) {
    getClassifiedDetailDataUserData.countrycode1 = countrycode1;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getClassifiedDetailDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getClassifiedDetailDataUserData.imageThumPath = imageThumPath;
  }
  return getClassifiedDetailDataUserData;
}

Map<String, dynamic> $GetClassifiedDetailDataUserDataToJson(
    GetClassifiedDetailDataUserData entity) {
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

extension GetClassifiedDetailDataUserDataExtension on GetClassifiedDetailDataUserData {
  GetClassifiedDetailDataUserData copyWith({
    String? name,
    String? userimage,
    String? email,
    dynamic mobile,
    dynamic countrycode1,
    String? imagePath,
    String? imageThumPath,
  }) {
    return GetClassifiedDetailDataUserData()
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..email = email ?? this.email
      ..mobile = mobile ?? this.mobile
      ..countrycode1 = countrycode1 ?? this.countrycode1
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}