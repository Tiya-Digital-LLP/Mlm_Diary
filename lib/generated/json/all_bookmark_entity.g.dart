import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/all_bookmark_entity.dart';

AllBookmarkEntity $AllBookmarkEntityFromJson(Map<String, dynamic> json) {
  final AllBookmarkEntity allBookmarkEntity = AllBookmarkEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    allBookmarkEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    allBookmarkEntity.message = message;
  }
  final List<AllBookmarkData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<AllBookmarkData>(e) as AllBookmarkData)
      .toList();
  if (data != null) {
    allBookmarkEntity.data = data;
  }
  return allBookmarkEntity;
}

Map<String, dynamic> $AllBookmarkEntityToJson(AllBookmarkEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension AllBookmarkEntityExtension on AllBookmarkEntity {
  AllBookmarkEntity copyWith({
    int? status,
    String? message,
    List<AllBookmarkData>? data,
  }) {
    return AllBookmarkEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

AllBookmarkData $AllBookmarkDataFromJson(Map<String, dynamic> json) {
  final AllBookmarkData allBookmarkData = AllBookmarkData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    allBookmarkData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    allBookmarkData.title = title;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    allBookmarkData.urlcomponent = urlcomponent;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    allBookmarkData.category = category;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    allBookmarkData.subcategory = subcategory;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    allBookmarkData.description = description;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    allBookmarkData.createdate = createdate;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    allBookmarkData.pgcnt = pgcnt;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    allBookmarkData.image = image;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    allBookmarkData.userId = userId;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    allBookmarkData.type = type;
  }
  final dynamic immlm = json['immlm'];
  if (immlm != null) {
    allBookmarkData.immlm = immlm;
  }
  final dynamic plan = json['plan'];
  if (plan != null) {
    allBookmarkData.plan = plan;
  }
  final String? bookmarkDate = jsonConvert.convert<String>(
      json['bookmark_date']);
  if (bookmarkDate != null) {
    allBookmarkData.bookmarkDate = bookmarkDate;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    allBookmarkData.totallike = totallike;
  }
  final int? totalbookmark = jsonConvert.convert<int>(json['totalbookmark']);
  if (totalbookmark != null) {
    allBookmarkData.totalbookmark = totalbookmark;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    allBookmarkData.totalcomment = totalcomment;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    allBookmarkData.likedByUser = likedByUser;
  }
  final AllBookmarkDataUserData? userData = jsonConvert.convert<
      AllBookmarkDataUserData>(json['user_data']);
  if (userData != null) {
    allBookmarkData.userData = userData;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    allBookmarkData.imagePath = imagePath;
  }
  return allBookmarkData;
}

Map<String, dynamic> $AllBookmarkDataToJson(AllBookmarkData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['urlcomponent'] = entity.urlcomponent;
  data['category'] = entity.category;
  data['subcategory'] = entity.subcategory;
  data['description'] = entity.description;
  data['createdate'] = entity.createdate;
  data['pgcnt'] = entity.pgcnt;
  data['image'] = entity.image;
  data['user_id'] = entity.userId;
  data['type'] = entity.type;
  data['immlm'] = entity.immlm;
  data['plan'] = entity.plan;
  data['bookmark_date'] = entity.bookmarkDate;
  data['totallike'] = entity.totallike;
  data['totalbookmark'] = entity.totalbookmark;
  data['totalcomment'] = entity.totalcomment;
  data['liked_by_user'] = entity.likedByUser;
  data['user_data'] = entity.userData?.toJson();
  data['image_path'] = entity.imagePath;
  return data;
}

extension AllBookmarkDataExtension on AllBookmarkData {
  AllBookmarkData copyWith({
    int? id,
    String? title,
    String? urlcomponent,
    String? category,
    String? subcategory,
    String? description,
    String? createdate,
    int? pgcnt,
    String? image,
    int? userId,
    String? type,
    dynamic immlm,
    dynamic plan,
    String? bookmarkDate,
    int? totallike,
    int? totalbookmark,
    int? totalcomment,
    bool? likedByUser,
    AllBookmarkDataUserData? userData,
    String? imagePath,
  }) {
    return AllBookmarkData()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..urlcomponent = urlcomponent ?? this.urlcomponent
      ..category = category ?? this.category
      ..subcategory = subcategory ?? this.subcategory
      ..description = description ?? this.description
      ..createdate = createdate ?? this.createdate
      ..pgcnt = pgcnt ?? this.pgcnt
      ..image = image ?? this.image
      ..userId = userId ?? this.userId
      ..type = type ?? this.type
      ..immlm = immlm ?? this.immlm
      ..plan = plan ?? this.plan
      ..bookmarkDate = bookmarkDate ?? this.bookmarkDate
      ..totallike = totallike ?? this.totallike
      ..totalbookmark = totalbookmark ?? this.totalbookmark
      ..totalcomment = totalcomment ?? this.totalcomment
      ..likedByUser = likedByUser ?? this.likedByUser
      ..userData = userData ?? this.userData
      ..imagePath = imagePath ?? this.imagePath;
  }
}

AllBookmarkDataUserData $AllBookmarkDataUserDataFromJson(
    Map<String, dynamic> json) {
  final AllBookmarkDataUserData allBookmarkDataUserData = AllBookmarkDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    allBookmarkDataUserData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    allBookmarkDataUserData.name = name;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    allBookmarkDataUserData.email = email;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    allBookmarkDataUserData.userimage = userimage;
  }
  final String? countrycode1 = jsonConvert.convert<String>(
      json['countrycode1']);
  if (countrycode1 != null) {
    allBookmarkDataUserData.countrycode1 = countrycode1;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    allBookmarkDataUserData.mobile = mobile;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    allBookmarkDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    allBookmarkDataUserData.imageThumPath = imageThumPath;
  }
  return allBookmarkDataUserData;
}

Map<String, dynamic> $AllBookmarkDataUserDataToJson(
    AllBookmarkDataUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['email'] = entity.email;
  data['userimage'] = entity.userimage;
  data['countrycode1'] = entity.countrycode1;
  data['mobile'] = entity.mobile;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension AllBookmarkDataUserDataExtension on AllBookmarkDataUserData {
  AllBookmarkDataUserData copyWith({
    int? id,
    String? name,
    String? email,
    String? userimage,
    String? countrycode1,
    String? mobile,
    String? imagePath,
    String? imageThumPath,
  }) {
    return AllBookmarkDataUserData()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..email = email ?? this.email
      ..userimage = userimage ?? this.userimage
      ..countrycode1 = countrycode1 ?? this.countrycode1
      ..mobile = mobile ?? this.mobile
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}