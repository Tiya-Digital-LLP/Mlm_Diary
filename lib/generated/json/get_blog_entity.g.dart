import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_blog_entity.dart';

GetBlogEntity $GetBlogEntityFromJson(Map<String, dynamic> json) {
  final GetBlogEntity getBlogEntity = GetBlogEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getBlogEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getBlogEntity.message = message;
  }
  final List<GetBlogData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<GetBlogData>(e) as GetBlogData).toList();
  if (data != null) {
    getBlogEntity.data = data;
  }
  return getBlogEntity;
}

Map<String, dynamic> $GetBlogEntityToJson(GetBlogEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetBlogEntityExtension on GetBlogEntity {
  GetBlogEntity copyWith({
    int? status,
    String? message,
    List<GetBlogData>? data,
  }) {
    return GetBlogEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

GetBlogData $GetBlogDataFromJson(Map<String, dynamic> json) {
  final GetBlogData getBlogData = GetBlogData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getBlogData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getBlogData.title = title;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    getBlogData.image = image;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    getBlogData.description = description;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    getBlogData.pgcnt = pgcnt;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getBlogData.createdate = createdate;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    getBlogData.datemodified = datemodified;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    getBlogData.category = category;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    getBlogData.userId = userId;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    getBlogData.subcategory = subcategory;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    getBlogData.website = website;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    getBlogData.urlcomponent = urlcomponent;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    getBlogData.totallike = totallike;
  }
  final int? totalbookmark = jsonConvert.convert<int>(json['totalbookmark']);
  if (totalbookmark != null) {
    getBlogData.totalbookmark = totalbookmark;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    getBlogData.totalcomment = totalcomment;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    getBlogData.likedByUser = likedByUser;
  }
  final bool? bookmarkedByUser = jsonConvert.convert<bool>(
      json['bookmarked_by_user']);
  if (bookmarkedByUser != null) {
    getBlogData.bookmarkedByUser = bookmarkedByUser;
  }
  final GetBlogDataUserData? userData = jsonConvert.convert<
      GetBlogDataUserData>(json['user_data']);
  if (userData != null) {
    getBlogData.userData = userData;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    getBlogData.imageUrl = imageUrl;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getBlogData.imagePath = imagePath;
  }
  return getBlogData;
}

Map<String, dynamic> $GetBlogDataToJson(GetBlogData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['image'] = entity.image;
  data['description'] = entity.description;
  data['pgcnt'] = entity.pgcnt;
  data['createdate'] = entity.createdate;
  data['datemodified'] = entity.datemodified;
  data['category'] = entity.category;
  data['user_id'] = entity.userId;
  data['subcategory'] = entity.subcategory;
  data['website'] = entity.website;
  data['urlcomponent'] = entity.urlcomponent;
  data['totallike'] = entity.totallike;
  data['totalbookmark'] = entity.totalbookmark;
  data['totalcomment'] = entity.totalcomment;
  data['liked_by_user'] = entity.likedByUser;
  data['bookmarked_by_user'] = entity.bookmarkedByUser;
  data['user_data'] = entity.userData?.toJson();
  data['image_url'] = entity.imageUrl;
  data['image_path'] = entity.imagePath;
  return data;
}

extension GetBlogDataExtension on GetBlogData {
  GetBlogData copyWith({
    int? id,
    String? title,
    String? image,
    String? description,
    int? pgcnt,
    String? createdate,
    String? datemodified,
    String? category,
    int? userId,
    String? subcategory,
    String? website,
    String? urlcomponent,
    int? totallike,
    int? totalbookmark,
    int? totalcomment,
    bool? likedByUser,
    bool? bookmarkedByUser,
    GetBlogDataUserData? userData,
    String? imageUrl,
    String? imagePath,
  }) {
    return GetBlogData()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..image = image ?? this.image
      ..description = description ?? this.description
      ..pgcnt = pgcnt ?? this.pgcnt
      ..createdate = createdate ?? this.createdate
      ..datemodified = datemodified ?? this.datemodified
      ..category = category ?? this.category
      ..userId = userId ?? this.userId
      ..subcategory = subcategory ?? this.subcategory
      ..website = website ?? this.website
      ..urlcomponent = urlcomponent ?? this.urlcomponent
      ..totallike = totallike ?? this.totallike
      ..totalbookmark = totalbookmark ?? this.totalbookmark
      ..totalcomment = totalcomment ?? this.totalcomment
      ..likedByUser = likedByUser ?? this.likedByUser
      ..bookmarkedByUser = bookmarkedByUser ?? this.bookmarkedByUser
      ..userData = userData ?? this.userData
      ..imageUrl = imageUrl ?? this.imageUrl
      ..imagePath = imagePath ?? this.imagePath;
  }
}

GetBlogDataUserData $GetBlogDataUserDataFromJson(Map<String, dynamic> json) {
  final GetBlogDataUserData getBlogDataUserData = GetBlogDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getBlogDataUserData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getBlogDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getBlogDataUserData.userimage = userimage;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    getBlogDataUserData.email = email;
  }
  final dynamic mobile = json['mobile'];
  if (mobile != null) {
    getBlogDataUserData.mobile = mobile;
  }
  final dynamic countrycode1 = json['countrycode1'];
  if (countrycode1 != null) {
    getBlogDataUserData.countrycode1 = countrycode1;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    getBlogDataUserData.company = company;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    getBlogDataUserData.country = country;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    getBlogDataUserData.city = city;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getBlogDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getBlogDataUserData.imageThumPath = imageThumPath;
  }
  return getBlogDataUserData;
}

Map<String, dynamic> $GetBlogDataUserDataToJson(GetBlogDataUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['email'] = entity.email;
  data['mobile'] = entity.mobile;
  data['countrycode1'] = entity.countrycode1;
  data['company'] = entity.company;
  data['country'] = entity.country;
  data['city'] = entity.city;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension GetBlogDataUserDataExtension on GetBlogDataUserData {
  GetBlogDataUserData copyWith({
    int? id,
    String? name,
    String? userimage,
    String? email,
    dynamic mobile,
    dynamic countrycode1,
    String? company,
    String? country,
    String? city,
    String? imagePath,
    String? imageThumPath,
  }) {
    return GetBlogDataUserData()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..email = email ?? this.email
      ..mobile = mobile ?? this.mobile
      ..countrycode1 = countrycode1 ?? this.countrycode1
      ..company = company ?? this.company
      ..country = country ?? this.country
      ..city = city ?? this.city
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}