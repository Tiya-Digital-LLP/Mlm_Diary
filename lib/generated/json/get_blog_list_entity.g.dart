import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_blog_list_entity.dart';

GetBlogListEntity $GetBlogListEntityFromJson(Map<String, dynamic> json) {
  final GetBlogListEntity getBlogListEntity = GetBlogListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getBlogListEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getBlogListEntity.message = message;
  }
  final List<GetBlogListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<GetBlogListData>(e) as GetBlogListData)
      .toList();
  if (data != null) {
    getBlogListEntity.data = data;
  }
  return getBlogListEntity;
}

Map<String, dynamic> $GetBlogListEntityToJson(GetBlogListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetBlogListEntityExtension on GetBlogListEntity {
  GetBlogListEntity copyWith({
    int? status,
    String? message,
    List<GetBlogListData>? data,
  }) {
    return GetBlogListEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

GetBlogListData $GetBlogListDataFromJson(Map<String, dynamic> json) {
  final GetBlogListData getBlogListData = GetBlogListData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getBlogListData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getBlogListData.title = title;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    getBlogListData.image = image;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    getBlogListData.description = description;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    getBlogListData.pgcnt = pgcnt;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getBlogListData.createdate = createdate;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    getBlogListData.datemodified = datemodified;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    getBlogListData.category = category;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    getBlogListData.userId = userId;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    getBlogListData.subcategory = subcategory;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    getBlogListData.website = website;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    getBlogListData.urlcomponent = urlcomponent;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    getBlogListData.totallike = totallike;
  }
  final int? totalbookmark = jsonConvert.convert<int>(json['totalbookmark']);
  if (totalbookmark != null) {
    getBlogListData.totalbookmark = totalbookmark;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    getBlogListData.totalcomment = totalcomment;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    getBlogListData.likedByUser = likedByUser;
  }
  final bool? bookmarkedByUser = jsonConvert.convert<bool>(
      json['bookmarked_by_user']);
  if (bookmarkedByUser != null) {
    getBlogListData.bookmarkedByUser = bookmarkedByUser;
  }
  final GetBlogListDataUserData? userData = jsonConvert.convert<
      GetBlogListDataUserData>(json['user_data']);
  if (userData != null) {
    getBlogListData.userData = userData;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    getBlogListData.imageUrl = imageUrl;
  }
  final String? fullUrl = jsonConvert.convert<String>(json['full_url']);
  if (fullUrl != null) {
    getBlogListData.fullUrl = fullUrl;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getBlogListData.imagePath = imagePath;
  }
  return getBlogListData;
}

Map<String, dynamic> $GetBlogListDataToJson(GetBlogListData entity) {
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
  data['full_url'] = entity.fullUrl;
  data['image_path'] = entity.imagePath;
  return data;
}

extension GetBlogListDataExtension on GetBlogListData {
  GetBlogListData copyWith({
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
    GetBlogListDataUserData? userData,
    String? imageUrl,
    String? fullUrl,
    String? imagePath,
  }) {
    return GetBlogListData()
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
      ..fullUrl = fullUrl ?? this.fullUrl
      ..imagePath = imagePath ?? this.imagePath;
  }
}

GetBlogListDataUserData $GetBlogListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final GetBlogListDataUserData getBlogListDataUserData = GetBlogListDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getBlogListDataUserData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getBlogListDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getBlogListDataUserData.userimage = userimage;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    getBlogListDataUserData.email = email;
  }
  final dynamic mobile = json['mobile'];
  if (mobile != null) {
    getBlogListDataUserData.mobile = mobile;
  }
  final dynamic countrycode1 = json['countrycode1'];
  if (countrycode1 != null) {
    getBlogListDataUserData.countrycode1 = countrycode1;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    getBlogListDataUserData.company = company;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    getBlogListDataUserData.country = country;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    getBlogListDataUserData.city = city;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getBlogListDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getBlogListDataUserData.imageThumPath = imageThumPath;
  }
  return getBlogListDataUserData;
}

Map<String, dynamic> $GetBlogListDataUserDataToJson(
    GetBlogListDataUserData entity) {
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

extension GetBlogListDataUserDataExtension on GetBlogListDataUserData {
  GetBlogListDataUserData copyWith({
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
    return GetBlogListDataUserData()
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