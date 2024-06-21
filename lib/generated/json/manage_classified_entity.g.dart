import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/manage_classified_entity.dart';

ManageClassifiedEntity $ManageClassifiedEntityFromJson(
    Map<String, dynamic> json) {
  final ManageClassifiedEntity manageClassifiedEntity = ManageClassifiedEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    manageClassifiedEntity.status = status;
  }
  final List<ManageClassifiedData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ManageClassifiedData>(e) as ManageClassifiedData)
      .toList();
  if (data != null) {
    manageClassifiedEntity.data = data;
  }
  return manageClassifiedEntity;
}

Map<String, dynamic> $ManageClassifiedEntityToJson(
    ManageClassifiedEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension ManageClassifiedEntityExtension on ManageClassifiedEntity {
  ManageClassifiedEntity copyWith({
    int? status,
    List<ManageClassifiedData>? data,
  }) {
    return ManageClassifiedEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

ManageClassifiedData $ManageClassifiedDataFromJson(Map<String, dynamic> json) {
  final ManageClassifiedData manageClassifiedData = ManageClassifiedData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    manageClassifiedData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    manageClassifiedData.title = title;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    manageClassifiedData.image = image;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    manageClassifiedData.description = description;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    manageClassifiedData.pgcnt = pgcnt;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    manageClassifiedData.company = company;
  }
  final dynamic premiumsdate = json['premiumsdate'];
  if (premiumsdate != null) {
    manageClassifiedData.premiumsdate = premiumsdate;
  }
  final dynamic premiumedate = json['premiumedate'];
  if (premiumedate != null) {
    manageClassifiedData.premiumedate = premiumedate;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    manageClassifiedData.datemodified = datemodified;
  }
  final String? datecreated = jsonConvert.convert<String>(json['datecreated']);
  if (datecreated != null) {
    manageClassifiedData.datecreated = datecreated;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    manageClassifiedData.category = category;
  }
  final String? creatby = jsonConvert.convert<String>(json['creatby']);
  if (creatby != null) {
    manageClassifiedData.creatby = creatby;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    manageClassifiedData.subcategory = subcategory;
  }
  final String? popular = jsonConvert.convert<String>(json['popular']);
  if (popular != null) {
    manageClassifiedData.popular = popular;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    manageClassifiedData.website = website;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    manageClassifiedData.city = city;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    manageClassifiedData.state = state;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    manageClassifiedData.country = country;
  }
  final dynamic lat = json['lat'];
  if (lat != null) {
    manageClassifiedData.lat = lat;
  }
  final dynamic lng = json['lng'];
  if (lng != null) {
    manageClassifiedData.lng = lng;
  }
  final int? userRequestedForPaid = jsonConvert.convert<int>(
      json['user_requested_for_paid']);
  if (userRequestedForPaid != null) {
    manageClassifiedData.userRequestedForPaid = userRequestedForPaid;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    manageClassifiedData.urlcomponent = urlcomponent;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    manageClassifiedData.totallike = totallike;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    manageClassifiedData.totalcomment = totalcomment;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    manageClassifiedData.likedByUser = likedByUser;
  }
  final bool? bookmarkedByUser = jsonConvert.convert<bool>(
      json['bookmarked_by_user']);
  if (bookmarkedByUser != null) {
    manageClassifiedData.bookmarkedByUser = bookmarkedByUser;
  }
  final ManageClassifiedDataUserData? userData = jsonConvert.convert<
      ManageClassifiedDataUserData>(json['user_data']);
  if (userData != null) {
    manageClassifiedData.userData = userData;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    manageClassifiedData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    manageClassifiedData.imageThumPath = imageThumPath;
  }
  return manageClassifiedData;
}

Map<String, dynamic> $ManageClassifiedDataToJson(ManageClassifiedData entity) {
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
  data['datecreated'] = entity.datecreated;
  data['category'] = entity.category;
  data['creatby'] = entity.creatby;
  data['subcategory'] = entity.subcategory;
  data['popular'] = entity.popular;
  data['website'] = entity.website;
  data['city'] = entity.city;
  data['state'] = entity.state;
  data['country'] = entity.country;
  data['lat'] = entity.lat;
  data['lng'] = entity.lng;
  data['user_requested_for_paid'] = entity.userRequestedForPaid;
  data['urlcomponent'] = entity.urlcomponent;
  data['totallike'] = entity.totallike;
  data['totalcomment'] = entity.totalcomment;
  data['liked_by_user'] = entity.likedByUser;
  data['bookmarked_by_user'] = entity.bookmarkedByUser;
  data['user_data'] = entity.userData?.toJson();
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension ManageClassifiedDataExtension on ManageClassifiedData {
  ManageClassifiedData copyWith({
    int? id,
    String? title,
    String? image,
    String? description,
    int? pgcnt,
    String? company,
    dynamic premiumsdate,
    dynamic premiumedate,
    String? datemodified,
    String? datecreated,
    String? category,
    String? creatby,
    String? subcategory,
    String? popular,
    String? website,
    String? city,
    String? state,
    String? country,
    dynamic lat,
    dynamic lng,
    int? userRequestedForPaid,
    String? urlcomponent,
    int? totallike,
    int? totalcomment,
    bool? likedByUser,
    bool? bookmarkedByUser,
    ManageClassifiedDataUserData? userData,
    String? imagePath,
    String? imageThumPath,
  }) {
    return ManageClassifiedData()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..image = image ?? this.image
      ..description = description ?? this.description
      ..pgcnt = pgcnt ?? this.pgcnt
      ..company = company ?? this.company
      ..premiumsdate = premiumsdate ?? this.premiumsdate
      ..premiumedate = premiumedate ?? this.premiumedate
      ..datemodified = datemodified ?? this.datemodified
      ..datecreated = datecreated ?? this.datecreated
      ..category = category ?? this.category
      ..creatby = creatby ?? this.creatby
      ..subcategory = subcategory ?? this.subcategory
      ..popular = popular ?? this.popular
      ..website = website ?? this.website
      ..city = city ?? this.city
      ..state = state ?? this.state
      ..country = country ?? this.country
      ..lat = lat ?? this.lat
      ..lng = lng ?? this.lng
      ..userRequestedForPaid = userRequestedForPaid ?? this.userRequestedForPaid
      ..urlcomponent = urlcomponent ?? this.urlcomponent
      ..totallike = totallike ?? this.totallike
      ..totalcomment = totalcomment ?? this.totalcomment
      ..likedByUser = likedByUser ?? this.likedByUser
      ..bookmarkedByUser = bookmarkedByUser ?? this.bookmarkedByUser
      ..userData = userData ?? this.userData
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}

ManageClassifiedDataUserData $ManageClassifiedDataUserDataFromJson(
    Map<String, dynamic> json) {
  final ManageClassifiedDataUserData manageClassifiedDataUserData = ManageClassifiedDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    manageClassifiedDataUserData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    manageClassifiedDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    manageClassifiedDataUserData.userimage = userimage;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    manageClassifiedDataUserData.email = email;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    manageClassifiedDataUserData.mobile = mobile;
  }
  final String? countrycode1 = jsonConvert.convert<String>(
      json['countrycode1']);
  if (countrycode1 != null) {
    manageClassifiedDataUserData.countrycode1 = countrycode1;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    manageClassifiedDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    manageClassifiedDataUserData.imageThumPath = imageThumPath;
  }
  return manageClassifiedDataUserData;
}

Map<String, dynamic> $ManageClassifiedDataUserDataToJson(
    ManageClassifiedDataUserData entity) {
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

extension ManageClassifiedDataUserDataExtension on ManageClassifiedDataUserData {
  ManageClassifiedDataUserData copyWith({
    int? id,
    String? name,
    String? userimage,
    String? email,
    String? mobile,
    String? countrycode1,
    String? imagePath,
    String? imageThumPath,
  }) {
    return ManageClassifiedDataUserData()
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