import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/my_blog_list_entity.dart';

MyBlogListEntity $MyBlogListEntityFromJson(Map<String, dynamic> json) {
  final MyBlogListEntity myBlogListEntity = MyBlogListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    myBlogListEntity.status = status;
  }
  final MyBlogListData? data = jsonConvert.convert<MyBlogListData>(
      json['data']);
  if (data != null) {
    myBlogListEntity.data = data;
  }
  return myBlogListEntity;
}

Map<String, dynamic> $MyBlogListEntityToJson(MyBlogListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.toJson();
  return data;
}

extension MyBlogListEntityExtension on MyBlogListEntity {
  MyBlogListEntity copyWith({
    int? status,
    MyBlogListData? data,
  }) {
    return MyBlogListEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

MyBlogListData $MyBlogListDataFromJson(Map<String, dynamic> json) {
  final MyBlogListData myBlogListData = MyBlogListData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    myBlogListData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    myBlogListData.title = title;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    myBlogListData.image = image;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    myBlogListData.description = description;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    myBlogListData.pgcnt = pgcnt;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    myBlogListData.createdate = createdate;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    myBlogListData.datemodified = datemodified;
  }
  final dynamic category = json['category'];
  if (category != null) {
    myBlogListData.category = category;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    myBlogListData.userId = userId;
  }
  final dynamic subcategory = json['subcategory'];
  if (subcategory != null) {
    myBlogListData.subcategory = subcategory;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    myBlogListData.status = status;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    myBlogListData.website = website;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    myBlogListData.urlcomponent = urlcomponent;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    myBlogListData.totallike = totallike;
  }
  final int? totalbookmark = jsonConvert.convert<int>(json['totalbookmark']);
  if (totalbookmark != null) {
    myBlogListData.totalbookmark = totalbookmark;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    myBlogListData.totalcomment = totalcomment;
  }
  final String? fullUrl = jsonConvert.convert<String>(json['full_url']);
  if (fullUrl != null) {
    myBlogListData.fullUrl = fullUrl;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    myBlogListData.imageUrl = imageUrl;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    myBlogListData.likedByUser = likedByUser;
  }
  final bool? bookmarkedByUser = jsonConvert.convert<bool>(
      json['bookmarked_by_user']);
  if (bookmarkedByUser != null) {
    myBlogListData.bookmarkedByUser = bookmarkedByUser;
  }
  final MyBlogListDataUserData? userData = jsonConvert.convert<
      MyBlogListDataUserData>(json['user_data']);
  if (userData != null) {
    myBlogListData.userData = userData;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    myBlogListData.imagePath = imagePath;
  }
  return myBlogListData;
}

Map<String, dynamic> $MyBlogListDataToJson(MyBlogListData entity) {
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
  data['user_data'] = entity.userData?.toJson();
  data['image_path'] = entity.imagePath;
  return data;
}

extension MyBlogListDataExtension on MyBlogListData {
  MyBlogListData copyWith({
    int? id,
    String? title,
    String? image,
    String? description,
    int? pgcnt,
    String? createdate,
    String? datemodified,
    dynamic category,
    int? userId,
    dynamic subcategory,
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
    MyBlogListDataUserData? userData,
    String? imagePath,
  }) {
    return MyBlogListData()
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
      ..userData = userData ?? this.userData
      ..imagePath = imagePath ?? this.imagePath;
  }
}

MyBlogListDataUserData $MyBlogListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final MyBlogListDataUserData myBlogListDataUserData = MyBlogListDataUserData();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    myBlogListDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    myBlogListDataUserData.userimage = userimage;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    myBlogListDataUserData.email = email;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    myBlogListDataUserData.mobile = mobile;
  }
  final String? countrycode1 = jsonConvert.convert<String>(
      json['countrycode1']);
  if (countrycode1 != null) {
    myBlogListDataUserData.countrycode1 = countrycode1;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    myBlogListDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    myBlogListDataUserData.imageThumPath = imageThumPath;
  }
  return myBlogListDataUserData;
}

Map<String, dynamic> $MyBlogListDataUserDataToJson(
    MyBlogListDataUserData entity) {
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

extension MyBlogListDataUserDataExtension on MyBlogListDataUserData {
  MyBlogListDataUserData copyWith({
    String? name,
    String? userimage,
    String? email,
    String? mobile,
    String? countrycode1,
    String? imagePath,
    String? imageThumPath,
  }) {
    return MyBlogListDataUserData()
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..email = email ?? this.email
      ..mobile = mobile ?? this.mobile
      ..countrycode1 = countrycode1 ?? this.countrycode1
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}