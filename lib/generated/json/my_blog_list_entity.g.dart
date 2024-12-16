import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/my_blog_list_entity.dart';

MyBlogListEntity $MyBlogListEntityFromJson(Map<String, dynamic> json) {
  final MyBlogListEntity myBlogListEntity = MyBlogListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    myBlogListEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    myBlogListEntity.message = message;
  }
  final List<MyBlogListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<MyBlogListData>(e) as MyBlogListData)
      .toList();
  if (data != null) {
    myBlogListEntity.data = data;
  }
  return myBlogListEntity;
}

Map<String, dynamic> $MyBlogListEntityToJson(MyBlogListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension MyBlogListEntityExtension on MyBlogListEntity {
  MyBlogListEntity copyWith({
    int? status,
    String? message,
    List<MyBlogListData>? data,
  }) {
    return MyBlogListEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

MyBlogListData $MyBlogListDataFromJson(Map<String, dynamic> json) {
  final MyBlogListData myBlogListData = MyBlogListData();
  final int? articleId = jsonConvert.convert<int>(json['article_id']);
  if (articleId != null) {
    myBlogListData.articleId = articleId;
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
  final String? createdDate = jsonConvert.convert<String>(json['created_date']);
  if (createdDate != null) {
    myBlogListData.createdDate = createdDate;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    myBlogListData.datemodified = datemodified;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    myBlogListData.category = category;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    myBlogListData.userId = userId;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    myBlogListData.subcategory = subcategory;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    myBlogListData.status = status;
  }
  final dynamic website = json['website'];
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
  final String? categoryName = jsonConvert.convert<String>(
      json['category_name']);
  if (categoryName != null) {
    myBlogListData.categoryName = categoryName;
  }
  final String? subcategoryName = jsonConvert.convert<String>(
      json['subcategory_name']);
  if (subcategoryName != null) {
    myBlogListData.subcategoryName = subcategoryName;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    myBlogListData.imagePath = imagePath;
  }
  return myBlogListData;
}

Map<String, dynamic> $MyBlogListDataToJson(MyBlogListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['article_id'] = entity.articleId;
  data['title'] = entity.title;
  data['image'] = entity.image;
  data['description'] = entity.description;
  data['pgcnt'] = entity.pgcnt;
  data['created_date'] = entity.createdDate;
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
  data['liked_by_user'] = entity.likedByUser;
  data['bookmarked_by_user'] = entity.bookmarkedByUser;
  data['user_data'] = entity.userData?.toJson();
  data['category_name'] = entity.categoryName;
  data['subcategory_name'] = entity.subcategoryName;
  data['image_path'] = entity.imagePath;
  return data;
}

extension MyBlogListDataExtension on MyBlogListData {
  MyBlogListData copyWith({
    int? articleId,
    String? title,
    String? image,
    String? description,
    int? pgcnt,
    String? createdDate,
    String? datemodified,
    String? category,
    int? userId,
    String? subcategory,
    int? status,
    dynamic website,
    String? urlcomponent,
    int? totallike,
    int? totalbookmark,
    int? totalcomment,
    bool? likedByUser,
    bool? bookmarkedByUser,
    MyBlogListDataUserData? userData,
    String? categoryName,
    String? subcategoryName,
    String? imagePath,
  }) {
    return MyBlogListData()
      ..articleId = articleId ?? this.articleId
      ..title = title ?? this.title
      ..image = image ?? this.image
      ..description = description ?? this.description
      ..pgcnt = pgcnt ?? this.pgcnt
      ..createdDate = createdDate ?? this.createdDate
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
      ..likedByUser = likedByUser ?? this.likedByUser
      ..bookmarkedByUser = bookmarkedByUser ?? this.bookmarkedByUser
      ..userData = userData ?? this.userData
      ..categoryName = categoryName ?? this.categoryName
      ..subcategoryName = subcategoryName ?? this.subcategoryName
      ..imagePath = imagePath ?? this.imagePath;
  }
}

MyBlogListDataUserData $MyBlogListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final MyBlogListDataUserData myBlogListDataUserData = MyBlogListDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    myBlogListDataUserData.id = id;
  }
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
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    myBlogListDataUserData.company = company;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    myBlogListDataUserData.state = state;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    myBlogListDataUserData.country = country;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    myBlogListDataUserData.city = city;
  }
  final String? fullAddress = jsonConvert.convert<String>(json['full_address']);
  if (fullAddress != null) {
    myBlogListDataUserData.fullAddress = fullAddress;
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
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['email'] = entity.email;
  data['mobile'] = entity.mobile;
  data['countrycode1'] = entity.countrycode1;
  data['company'] = entity.company;
  data['state'] = entity.state;
  data['country'] = entity.country;
  data['city'] = entity.city;
  data['full_address'] = entity.fullAddress;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension MyBlogListDataUserDataExtension on MyBlogListDataUserData {
  MyBlogListDataUserData copyWith({
    int? id,
    String? name,
    String? userimage,
    String? email,
    String? mobile,
    String? countrycode1,
    String? company,
    String? state,
    String? country,
    String? city,
    String? fullAddress,
    String? imagePath,
    String? imageThumPath,
  }) {
    return MyBlogListDataUserData()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..email = email ?? this.email
      ..mobile = mobile ?? this.mobile
      ..countrycode1 = countrycode1 ?? this.countrycode1
      ..company = company ?? this.company
      ..state = state ?? this.state
      ..country = country ?? this.country
      ..city = city ?? this.city
      ..fullAddress = fullAddress ?? this.fullAddress
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}