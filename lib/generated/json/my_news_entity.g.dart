import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/my_news_entity.dart';

MyNewsEntity $MyNewsEntityFromJson(Map<String, dynamic> json) {
  final MyNewsEntity myNewsEntity = MyNewsEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    myNewsEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    myNewsEntity.message = message;
  }
  final List<MyNewsData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<MyNewsData>(e) as MyNewsData).toList();
  if (data != null) {
    myNewsEntity.data = data;
  }
  return myNewsEntity;
}

Map<String, dynamic> $MyNewsEntityToJson(MyNewsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension MyNewsEntityExtension on MyNewsEntity {
  MyNewsEntity copyWith({
    int? status,
    String? message,
    List<MyNewsData>? data,
  }) {
    return MyNewsEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

MyNewsData $MyNewsDataFromJson(Map<String, dynamic> json) {
  final MyNewsData myNewsData = MyNewsData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    myNewsData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    myNewsData.title = title;
  }
  final String? photo = jsonConvert.convert<String>(json['photo']);
  if (photo != null) {
    myNewsData.photo = photo;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    myNewsData.description = description;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    myNewsData.pgcnt = pgcnt;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    myNewsData.createdate = createdate;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    myNewsData.category = category;
  }
  final String? creatby = jsonConvert.convert<String>(json['creatby']);
  if (creatby != null) {
    myNewsData.creatby = creatby;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    myNewsData.subcategory = subcategory;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    myNewsData.website = website;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    myNewsData.urlcomponent = urlcomponent;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    myNewsData.totallike = totallike;
  }
  final int? totalbookmark = jsonConvert.convert<int>(json['totalbookmark']);
  if (totalbookmark != null) {
    myNewsData.totalbookmark = totalbookmark;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    myNewsData.totalcomment = totalcomment;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    myNewsData.likedByUser = likedByUser;
  }
  final bool? bookmarkedByUser = jsonConvert.convert<bool>(
      json['bookmarked_by_user']);
  if (bookmarkedByUser != null) {
    myNewsData.bookmarkedByUser = bookmarkedByUser;
  }
  final MyNewsDataUserData? userData = jsonConvert.convert<MyNewsDataUserData>(
      json['user_data']);
  if (userData != null) {
    myNewsData.userData = userData;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    myNewsData.imagePath = imagePath;
  }
  return myNewsData;
}

Map<String, dynamic> $MyNewsDataToJson(MyNewsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['photo'] = entity.photo;
  data['description'] = entity.description;
  data['pgcnt'] = entity.pgcnt;
  data['createdate'] = entity.createdate;
  data['category'] = entity.category;
  data['creatby'] = entity.creatby;
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

extension MyNewsDataExtension on MyNewsData {
  MyNewsData copyWith({
    int? id,
    String? title,
    String? photo,
    String? description,
    int? pgcnt,
    String? createdate,
    String? category,
    String? creatby,
    String? subcategory,
    String? website,
    String? urlcomponent,
    int? totallike,
    int? totalbookmark,
    int? totalcomment,
    bool? likedByUser,
    bool? bookmarkedByUser,
    MyNewsDataUserData? userData,
    String? imagePath,
  }) {
    return MyNewsData()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..photo = photo ?? this.photo
      ..description = description ?? this.description
      ..pgcnt = pgcnt ?? this.pgcnt
      ..createdate = createdate ?? this.createdate
      ..category = category ?? this.category
      ..creatby = creatby ?? this.creatby
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

MyNewsDataUserData $MyNewsDataUserDataFromJson(Map<String, dynamic> json) {
  final MyNewsDataUserData myNewsDataUserData = MyNewsDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    myNewsDataUserData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    myNewsDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    myNewsDataUserData.userimage = userimage;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    myNewsDataUserData.email = email;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    myNewsDataUserData.mobile = mobile;
  }
  final String? countrycode1 = jsonConvert.convert<String>(
      json['countrycode1']);
  if (countrycode1 != null) {
    myNewsDataUserData.countrycode1 = countrycode1;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    myNewsDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    myNewsDataUserData.imageThumPath = imageThumPath;
  }
  return myNewsDataUserData;
}

Map<String, dynamic> $MyNewsDataUserDataToJson(MyNewsDataUserData entity) {
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

extension MyNewsDataUserDataExtension on MyNewsDataUserData {
  MyNewsDataUserData copyWith({
    int? id,
    String? name,
    String? userimage,
    String? email,
    String? mobile,
    String? countrycode1,
    String? imagePath,
    String? imageThumPath,
  }) {
    return MyNewsDataUserData()
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