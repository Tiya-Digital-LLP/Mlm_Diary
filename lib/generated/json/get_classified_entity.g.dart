import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_classified_entity.dart';

GetClassifiedEntity $GetClassifiedEntityFromJson(Map<String, dynamic> json) {
  final GetClassifiedEntity getClassifiedEntity = GetClassifiedEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getClassifiedEntity.status = status;
  }
  final List<GetClassifiedData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<GetClassifiedData>(e) as GetClassifiedData)
      .toList();
  if (data != null) {
    getClassifiedEntity.data = data;
  }
  return getClassifiedEntity;
}

Map<String, dynamic> $GetClassifiedEntityToJson(GetClassifiedEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetClassifiedEntityExtension on GetClassifiedEntity {
  GetClassifiedEntity copyWith({
    int? status,
    List<GetClassifiedData>? data,
  }) {
    return GetClassifiedEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

GetClassifiedData $GetClassifiedDataFromJson(Map<String, dynamic> json) {
  final GetClassifiedData getClassifiedData = GetClassifiedData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getClassifiedData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getClassifiedData.title = title;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    getClassifiedData.image = image;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    getClassifiedData.description = description;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    getClassifiedData.pgcnt = pgcnt;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    getClassifiedData.company = company;
  }
  final String? premiumsdate = jsonConvert.convert<String>(
      json['premiumsdate']);
  if (premiumsdate != null) {
    getClassifiedData.premiumsdate = premiumsdate;
  }
  final String? premiumedate = jsonConvert.convert<String>(
      json['premiumedate']);
  if (premiumedate != null) {
    getClassifiedData.premiumedate = premiumedate;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    getClassifiedData.datemodified = datemodified;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getClassifiedData.createdate = createdate;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    getClassifiedData.category = category;
  }
  final String? creatby = jsonConvert.convert<String>(json['creatby']);
  if (creatby != null) {
    getClassifiedData.creatby = creatby;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    getClassifiedData.subcategory = subcategory;
  }
  final String? popular = jsonConvert.convert<String>(json['popular']);
  if (popular != null) {
    getClassifiedData.popular = popular;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    getClassifiedData.website = website;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    getClassifiedData.location = location;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    getClassifiedData.city = city;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    getClassifiedData.state = state;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    getClassifiedData.country = country;
  }
  final String? lat = jsonConvert.convert<String>(json['lat']);
  if (lat != null) {
    getClassifiedData.lat = lat;
  }
  final String? lng = jsonConvert.convert<String>(json['lng']);
  if (lng != null) {
    getClassifiedData.lng = lng;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    getClassifiedData.urlcomponent = urlcomponent;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    getClassifiedData.totallike = totallike;
  }
  final int? totalbookmark = jsonConvert.convert<int>(json['totalbookmark']);
  if (totalbookmark != null) {
    getClassifiedData.totalbookmark = totalbookmark;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    getClassifiedData.totalcomment = totalcomment;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    getClassifiedData.likedByUser = likedByUser;
  }
  final bool? bookmarkedByUser = jsonConvert.convert<bool>(
      json['bookmarked_by_user']);
  if (bookmarkedByUser != null) {
    getClassifiedData.bookmarkedByUser = bookmarkedByUser;
  }
  final GetClassifiedDataUserData? userData = jsonConvert.convert<
      GetClassifiedDataUserData>(json['user_data']);
  if (userData != null) {
    getClassifiedData.userData = userData;
  }
  final String? fullUrl = jsonConvert.convert<String>(json['full_url']);
  if (fullUrl != null) {
    getClassifiedData.fullUrl = fullUrl;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    getClassifiedData.imageUrl = imageUrl;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getClassifiedData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getClassifiedData.imageThumPath = imageThumPath;
  }
  return getClassifiedData;
}

Map<String, dynamic> $GetClassifiedDataToJson(GetClassifiedData entity) {
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
  data['location'] = entity.location;
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

extension GetClassifiedDataExtension on GetClassifiedData {
  GetClassifiedData copyWith({
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
    String? location,
    String? city,
    String? state,
    String? country,
    String? lat,
    String? lng,
    String? urlcomponent,
    int? totallike,
    int? totalbookmark,
    int? totalcomment,
    bool? likedByUser,
    bool? bookmarkedByUser,
    GetClassifiedDataUserData? userData,
    String? fullUrl,
    String? imageUrl,
    String? imagePath,
    String? imageThumPath,
  }) {
    return GetClassifiedData()
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
      ..location = location ?? this.location
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

GetClassifiedDataUserData $GetClassifiedDataUserDataFromJson(
    Map<String, dynamic> json) {
  final GetClassifiedDataUserData getClassifiedDataUserData = GetClassifiedDataUserData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getClassifiedDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getClassifiedDataUserData.userimage = userimage;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    getClassifiedDataUserData.email = email;
  }
  final dynamic mobile = json['mobile'];
  if (mobile != null) {
    getClassifiedDataUserData.mobile = mobile;
  }
  final dynamic countrycode1 = json['countrycode1'];
  if (countrycode1 != null) {
    getClassifiedDataUserData.countrycode1 = countrycode1;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getClassifiedDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getClassifiedDataUserData.imageThumPath = imageThumPath;
  }
  return getClassifiedDataUserData;
}

Map<String, dynamic> $GetClassifiedDataUserDataToJson(
    GetClassifiedDataUserData entity) {
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

extension GetClassifiedDataUserDataExtension on GetClassifiedDataUserData {
  GetClassifiedDataUserData copyWith({
    String? name,
    String? userimage,
    String? email,
    dynamic mobile,
    dynamic countrycode1,
    String? imagePath,
    String? imageThumPath,
  }) {
    return GetClassifiedDataUserData()
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..email = email ?? this.email
      ..mobile = mobile ?? this.mobile
      ..countrycode1 = countrycode1 ?? this.countrycode1
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}