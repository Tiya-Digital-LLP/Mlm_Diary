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
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    allBookmarkData.company = company;
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
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    allBookmarkData.website = website;
  }
  final dynamic email = json['email'];
  if (email != null) {
    allBookmarkData.email = email;
  }
  final dynamic phone = json['phone'];
  if (phone != null) {
    allBookmarkData.phone = phone;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    allBookmarkData.createdate = createdate;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    allBookmarkData.updatedAt = updatedAt;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    allBookmarkData.pgcnt = pgcnt;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    allBookmarkData.location = location;
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
  final String? immlm = jsonConvert.convert<String>(json['immlm']);
  if (immlm != null) {
    allBookmarkData.immlm = immlm;
  }
  final String? plan = jsonConvert.convert<String>(json['plan']);
  if (plan != null) {
    allBookmarkData.plan = plan;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    allBookmarkData.city = city;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    allBookmarkData.state = state;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    allBookmarkData.country = country;
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
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    allBookmarkData.totalcomment = totalcomment;
  }
  final int? totalquestionAnswer = jsonConvert.convert<int>(
      json['totalquestion_answer']);
  if (totalquestionAnswer != null) {
    allBookmarkData.totalquestionAnswer = totalquestionAnswer;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    allBookmarkData.likedByUser = likedByUser;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    allBookmarkData.imageUrl = imageUrl;
  }
  final AllBookmarkDataUserData? userData = jsonConvert.convert<
      AllBookmarkDataUserData>(json['user_data']);
  if (userData != null) {
    allBookmarkData.userData = userData;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    allBookmarkData.datemodified = datemodified;
  }
  return allBookmarkData;
}

Map<String, dynamic> $AllBookmarkDataToJson(AllBookmarkData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['urlcomponent'] = entity.urlcomponent;
  data['company'] = entity.company;
  data['category'] = entity.category;
  data['subcategory'] = entity.subcategory;
  data['description'] = entity.description;
  data['website'] = entity.website;
  data['email'] = entity.email;
  data['phone'] = entity.phone;
  data['createdate'] = entity.createdate;
  data['updated_at'] = entity.updatedAt;
  data['pgcnt'] = entity.pgcnt;
  data['location'] = entity.location;
  data['image'] = entity.image;
  data['user_id'] = entity.userId;
  data['type'] = entity.type;
  data['immlm'] = entity.immlm;
  data['plan'] = entity.plan;
  data['city'] = entity.city;
  data['state'] = entity.state;
  data['country'] = entity.country;
  data['bookmark_date'] = entity.bookmarkDate;
  data['totallike'] = entity.totallike;
  data['totalcomment'] = entity.totalcomment;
  data['totalquestion_answer'] = entity.totalquestionAnswer;
  data['liked_by_user'] = entity.likedByUser;
  data['image_url'] = entity.imageUrl;
  data['user_data'] = entity.userData?.toJson();
  data['datemodified'] = entity.datemodified;
  return data;
}

extension AllBookmarkDataExtension on AllBookmarkData {
  AllBookmarkData copyWith({
    int? id,
    String? title,
    String? urlcomponent,
    String? company,
    String? category,
    String? subcategory,
    String? description,
    String? website,
    dynamic email,
    dynamic phone,
    String? createdate,
    String? updatedAt,
    int? pgcnt,
    String? location,
    String? image,
    int? userId,
    String? type,
    String? immlm,
    String? plan,
    String? city,
    String? state,
    String? country,
    String? bookmarkDate,
    int? totallike,
    int? totalcomment,
    int? totalquestionAnswer,
    bool? likedByUser,
    String? imageUrl,
    AllBookmarkDataUserData? userData,
    String? datemodified,
  }) {
    return AllBookmarkData()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..urlcomponent = urlcomponent ?? this.urlcomponent
      ..company = company ?? this.company
      ..category = category ?? this.category
      ..subcategory = subcategory ?? this.subcategory
      ..description = description ?? this.description
      ..website = website ?? this.website
      ..email = email ?? this.email
      ..phone = phone ?? this.phone
      ..createdate = createdate ?? this.createdate
      ..updatedAt = updatedAt ?? this.updatedAt
      ..pgcnt = pgcnt ?? this.pgcnt
      ..location = location ?? this.location
      ..image = image ?? this.image
      ..userId = userId ?? this.userId
      ..type = type ?? this.type
      ..immlm = immlm ?? this.immlm
      ..plan = plan ?? this.plan
      ..city = city ?? this.city
      ..state = state ?? this.state
      ..country = country ?? this.country
      ..bookmarkDate = bookmarkDate ?? this.bookmarkDate
      ..totallike = totallike ?? this.totallike
      ..totalcomment = totalcomment ?? this.totalcomment
      ..totalquestionAnswer = totalquestionAnswer ?? this.totalquestionAnswer
      ..likedByUser = likedByUser ?? this.likedByUser
      ..imageUrl = imageUrl ?? this.imageUrl
      ..userData = userData ?? this.userData
      ..datemodified = datemodified ?? this.datemodified;
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