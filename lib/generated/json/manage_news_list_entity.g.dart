import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/manage_news_list_entity.dart';

ManageNewsListEntity $ManageNewsListEntityFromJson(Map<String, dynamic> json) {
  final ManageNewsListEntity manageNewsListEntity = ManageNewsListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    manageNewsListEntity.status = status;
  }
  final ManageNewsListData? data = jsonConvert.convert<ManageNewsListData>(
      json['data']);
  if (data != null) {
    manageNewsListEntity.data = data;
  }
  return manageNewsListEntity;
}

Map<String, dynamic> $ManageNewsListEntityToJson(ManageNewsListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.toJson();
  return data;
}

extension ManageNewsListEntityExtension on ManageNewsListEntity {
  ManageNewsListEntity copyWith({
    int? status,
    ManageNewsListData? data,
  }) {
    return ManageNewsListEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

ManageNewsListData $ManageNewsListDataFromJson(Map<String, dynamic> json) {
  final ManageNewsListData manageNewsListData = ManageNewsListData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    manageNewsListData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    manageNewsListData.title = title;
  }
  final String? photo = jsonConvert.convert<String>(json['photo']);
  if (photo != null) {
    manageNewsListData.photo = photo;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    manageNewsListData.description = description;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    manageNewsListData.pgcnt = pgcnt;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    manageNewsListData.createdate = createdate;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    manageNewsListData.datemodified = datemodified;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    manageNewsListData.category = category;
  }
  final int? creatby = jsonConvert.convert<int>(json['creatby']);
  if (creatby != null) {
    manageNewsListData.creatby = creatby;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    manageNewsListData.status = status;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    manageNewsListData.subcategory = subcategory;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    manageNewsListData.website = website;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    manageNewsListData.urlcomponent = urlcomponent;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    manageNewsListData.totallike = totallike;
  }
  final int? totalbookmark = jsonConvert.convert<int>(json['totalbookmark']);
  if (totalbookmark != null) {
    manageNewsListData.totalbookmark = totalbookmark;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    manageNewsListData.totalcomment = totalcomment;
  }
  final String? fullUrl = jsonConvert.convert<String>(json['full_url']);
  if (fullUrl != null) {
    manageNewsListData.fullUrl = fullUrl;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    manageNewsListData.imageUrl = imageUrl;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    manageNewsListData.likedByUser = likedByUser;
  }
  final bool? bookmarkedByUser = jsonConvert.convert<bool>(
      json['bookmarked_by_user']);
  if (bookmarkedByUser != null) {
    manageNewsListData.bookmarkedByUser = bookmarkedByUser;
  }
  final ManageNewsListDataUserData? userData = jsonConvert.convert<
      ManageNewsListDataUserData>(json['user_data']);
  if (userData != null) {
    manageNewsListData.userData = userData;
  }
  final String? categoryName = jsonConvert.convert<String>(
      json['category_name']);
  if (categoryName != null) {
    manageNewsListData.categoryName = categoryName;
  }
  final String? subcategoryName = jsonConvert.convert<String>(
      json['subcategory_name']);
  if (subcategoryName != null) {
    manageNewsListData.subcategoryName = subcategoryName;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    manageNewsListData.imagePath = imagePath;
  }
  return manageNewsListData;
}

Map<String, dynamic> $ManageNewsListDataToJson(ManageNewsListData entity) {
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
  data['category_name'] = entity.categoryName;
  data['subcategory_name'] = entity.subcategoryName;
  data['image_path'] = entity.imagePath;
  return data;
}

extension ManageNewsListDataExtension on ManageNewsListData {
  ManageNewsListData copyWith({
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
    ManageNewsListDataUserData? userData,
    String? categoryName,
    String? subcategoryName,
    String? imagePath,
  }) {
    return ManageNewsListData()
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
      ..categoryName = categoryName ?? this.categoryName
      ..subcategoryName = subcategoryName ?? this.subcategoryName
      ..imagePath = imagePath ?? this.imagePath;
  }
}

ManageNewsListDataUserData $ManageNewsListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final ManageNewsListDataUserData manageNewsListDataUserData = ManageNewsListDataUserData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    manageNewsListDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    manageNewsListDataUserData.userimage = userimage;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    manageNewsListDataUserData.email = email;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    manageNewsListDataUserData.mobile = mobile;
  }
  final String? countrycode1 = jsonConvert.convert<String>(
      json['countrycode1']);
  if (countrycode1 != null) {
    manageNewsListDataUserData.countrycode1 = countrycode1;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    manageNewsListDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    manageNewsListDataUserData.imageThumPath = imageThumPath;
  }
  return manageNewsListDataUserData;
}

Map<String, dynamic> $ManageNewsListDataUserDataToJson(
    ManageNewsListDataUserData entity) {
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

extension ManageNewsListDataUserDataExtension on ManageNewsListDataUserData {
  ManageNewsListDataUserData copyWith({
    String? name,
    String? userimage,
    String? email,
    String? mobile,
    String? countrycode1,
    String? imagePath,
    String? imageThumPath,
  }) {
    return ManageNewsListDataUserData()
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..email = email ?? this.email
      ..mobile = mobile ?? this.mobile
      ..countrycode1 = countrycode1 ?? this.countrycode1
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}