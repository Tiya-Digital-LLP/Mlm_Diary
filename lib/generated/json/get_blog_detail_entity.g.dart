import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_blog_detail_entity.dart';

GetBlogDetailEntity $GetBlogDetailEntityFromJson(Map<String, dynamic> json) {
  final GetBlogDetailEntity getBlogDetailEntity = GetBlogDetailEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getBlogDetailEntity.status = status;
  }
  final GetBlogDetailData? data = jsonConvert.convert<GetBlogDetailData>(
      json['data']);
  if (data != null) {
    getBlogDetailEntity.data = data;
  }
  return getBlogDetailEntity;
}

Map<String, dynamic> $GetBlogDetailEntityToJson(GetBlogDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.toJson();
  return data;
}

extension GetBlogDetailEntityExtension on GetBlogDetailEntity {
  GetBlogDetailEntity copyWith({
    int? status,
    GetBlogDetailData? data,
  }) {
    return GetBlogDetailEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

GetBlogDetailData $GetBlogDetailDataFromJson(Map<String, dynamic> json) {
  final GetBlogDetailData getBlogDetailData = GetBlogDetailData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getBlogDetailData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getBlogDetailData.title = title;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    getBlogDetailData.image = image;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    getBlogDetailData.description = description;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    getBlogDetailData.pgcnt = pgcnt;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getBlogDetailData.createdate = createdate;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    getBlogDetailData.datemodified = datemodified;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    getBlogDetailData.category = category;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    getBlogDetailData.userId = userId;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    getBlogDetailData.subcategory = subcategory;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getBlogDetailData.status = status;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    getBlogDetailData.website = website;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    getBlogDetailData.urlcomponent = urlcomponent;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    getBlogDetailData.totallike = totallike;
  }
  final int? totalbookmark = jsonConvert.convert<int>(json['totalbookmark']);
  if (totalbookmark != null) {
    getBlogDetailData.totalbookmark = totalbookmark;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    getBlogDetailData.totalcomment = totalcomment;
  }
  final String? fullUrl = jsonConvert.convert<String>(json['full_url']);
  if (fullUrl != null) {
    getBlogDetailData.fullUrl = fullUrl;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    getBlogDetailData.imageUrl = imageUrl;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    getBlogDetailData.likedByUser = likedByUser;
  }
  final bool? bookmarkedByUser = jsonConvert.convert<bool>(
      json['bookmarked_by_user']);
  if (bookmarkedByUser != null) {
    getBlogDetailData.bookmarkedByUser = bookmarkedByUser;
  }
  final String? categoryName = jsonConvert.convert<String>(
      json['category_name']);
  if (categoryName != null) {
    getBlogDetailData.categoryName = categoryName;
  }
  final String? subcategoryName = jsonConvert.convert<String>(
      json['subcategory_name']);
  if (subcategoryName != null) {
    getBlogDetailData.subcategoryName = subcategoryName;
  }
  final GetBlogDetailDataUserData? userData = jsonConvert.convert<
      GetBlogDetailDataUserData>(json['user_data']);
  if (userData != null) {
    getBlogDetailData.userData = userData;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getBlogDetailData.imagePath = imagePath;
  }
  return getBlogDetailData;
}

Map<String, dynamic> $GetBlogDetailDataToJson(GetBlogDetailData entity) {
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
  data['status'] = entity.status;
  data['website'] = entity.website;
  data['urlcomponent'] = entity.urlcomponent;
  data['totallike'] = entity.totallike;
  data['totalbookmark'] = entity.totalbookmark;
  data['totalcomment'] = entity.totalcomment;
  data['full_url'] = entity.fullUrl;
  data['image_url'] = entity.imageUrl;
  data['liked_by_user'] = entity.likedByUser;
  data['bookmarked_by_user'] = entity.bookmarkedByUser;
  data['category_name'] = entity.categoryName;
  data['subcategory_name'] = entity.subcategoryName;
  data['user_data'] = entity.userData?.toJson();
  data['image_path'] = entity.imagePath;
  return data;
}

extension GetBlogDetailDataExtension on GetBlogDetailData {
  GetBlogDetailData copyWith({
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
    int? status,
    String? website,
    String? urlcomponent,
    int? totallike,
    int? totalbookmark,
    int? totalcomment,
    String? fullUrl,
    String? imageUrl,
    bool? likedByUser,
    bool? bookmarkedByUser,
    String? categoryName,
    String? subcategoryName,
    GetBlogDetailDataUserData? userData,
    String? imagePath,
  }) {
    return GetBlogDetailData()
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
      ..status = status ?? this.status
      ..website = website ?? this.website
      ..urlcomponent = urlcomponent ?? this.urlcomponent
      ..totallike = totallike ?? this.totallike
      ..totalbookmark = totalbookmark ?? this.totalbookmark
      ..totalcomment = totalcomment ?? this.totalcomment
      ..fullUrl = fullUrl ?? this.fullUrl
      ..imageUrl = imageUrl ?? this.imageUrl
      ..likedByUser = likedByUser ?? this.likedByUser
      ..bookmarkedByUser = bookmarkedByUser ?? this.bookmarkedByUser
      ..categoryName = categoryName ?? this.categoryName
      ..subcategoryName = subcategoryName ?? this.subcategoryName
      ..userData = userData ?? this.userData
      ..imagePath = imagePath ?? this.imagePath;
  }
}

GetBlogDetailDataUserData $GetBlogDetailDataUserDataFromJson(
    Map<String, dynamic> json) {
  final GetBlogDetailDataUserData getBlogDetailDataUserData = GetBlogDetailDataUserData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getBlogDetailDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getBlogDetailDataUserData.userimage = userimage;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    getBlogDetailDataUserData.email = email;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    getBlogDetailDataUserData.mobile = mobile;
  }
  final String? countrycode1 = jsonConvert.convert<String>(
      json['countrycode1']);
  if (countrycode1 != null) {
    getBlogDetailDataUserData.countrycode1 = countrycode1;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getBlogDetailDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getBlogDetailDataUserData.imageThumPath = imageThumPath;
  }
  return getBlogDetailDataUserData;
}

Map<String, dynamic> $GetBlogDetailDataUserDataToJson(
    GetBlogDetailDataUserData entity) {
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

extension GetBlogDetailDataUserDataExtension on GetBlogDetailDataUserData {
  GetBlogDetailDataUserData copyWith({
    String? name,
    String? userimage,
    String? email,
    String? mobile,
    String? countrycode1,
    String? imagePath,
    String? imageThumPath,
  }) {
    return GetBlogDetailDataUserData()
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..email = email ?? this.email
      ..mobile = mobile ?? this.mobile
      ..countrycode1 = countrycode1 ?? this.countrycode1
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}