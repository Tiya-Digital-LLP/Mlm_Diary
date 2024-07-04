import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_home_entity.dart';

GetHomeEntity $GetHomeEntityFromJson(Map<String, dynamic> json) {
  final GetHomeEntity getHomeEntity = GetHomeEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getHomeEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getHomeEntity.message = message;
  }
  final List<GetHomeData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<GetHomeData>(e) as GetHomeData).toList();
  if (data != null) {
    getHomeEntity.data = data;
  }
  return getHomeEntity;
}

Map<String, dynamic> $GetHomeEntityToJson(GetHomeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetHomeEntityExtension on GetHomeEntity {
  GetHomeEntity copyWith({
    int? status,
    String? message,
    List<GetHomeData>? data,
  }) {
    return GetHomeEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

GetHomeData $GetHomeDataFromJson(Map<String, dynamic> json) {
  final GetHomeData getHomeData = GetHomeData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getHomeData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getHomeData.title = title;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    getHomeData.urlcomponent = urlcomponent;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    getHomeData.company = company;
  }
  final String? popular = jsonConvert.convert<String>(json['popular']);
  if (popular != null) {
    getHomeData.popular = popular;
  }
  final String? premiumsdate = jsonConvert.convert<String>(
      json['premiumsdate']);
  if (premiumsdate != null) {
    getHomeData.premiumsdate = premiumsdate;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    getHomeData.category = category;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    getHomeData.subcategory = subcategory;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    getHomeData.description = description;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    getHomeData.website = website;
  }
  final dynamic email = json['email'];
  if (email != null) {
    getHomeData.email = email;
  }
  final dynamic phone = json['phone'];
  if (phone != null) {
    getHomeData.phone = phone;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getHomeData.createdate = createdate;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    getHomeData.updatedAt = updatedAt;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    getHomeData.pgcnt = pgcnt;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    getHomeData.location = location;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    getHomeData.image = image;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    getHomeData.userId = userId;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    getHomeData.type = type;
  }
  final dynamic immlm = json['immlm'];
  if (immlm != null) {
    getHomeData.immlm = immlm;
  }
  final dynamic plan = json['plan'];
  if (plan != null) {
    getHomeData.plan = plan;
  }
  final dynamic city = json['city'];
  if (city != null) {
    getHomeData.city = city;
  }
  final dynamic state = json['state'];
  if (state != null) {
    getHomeData.state = state;
  }
  final dynamic country = json['country'];
  if (country != null) {
    getHomeData.country = country;
  }
  final dynamic posttype = json['posttype'];
  if (posttype != null) {
    getHomeData.posttype = posttype;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    getHomeData.totallike = totallike;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    getHomeData.totalcomment = totalcomment;
  }
  final int? isPopularClassified = jsonConvert.convert<int>(
      json['is_popular_classified']);
  if (isPopularClassified != null) {
    getHomeData.isPopularClassified = isPopularClassified;
  }
  final bool? bookmarkByUser = jsonConvert.convert<bool>(
      json['bookmark_by_user']);
  if (bookmarkByUser != null) {
    getHomeData.bookmarkByUser = bookmarkByUser;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    getHomeData.likedByUser = likedByUser;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    getHomeData.imageUrl = imageUrl;
  }
  final GetHomeDataUserData? userData = jsonConvert.convert<
      GetHomeDataUserData>(json['user_data']);
  if (userData != null) {
    getHomeData.userData = userData;
  }
  return getHomeData;
}

Map<String, dynamic> $GetHomeDataToJson(GetHomeData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['urlcomponent'] = entity.urlcomponent;
  data['company'] = entity.company;
  data['popular'] = entity.popular;
  data['premiumsdate'] = entity.premiumsdate;
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
  data['posttype'] = entity.posttype;
  data['totallike'] = entity.totallike;
  data['totalcomment'] = entity.totalcomment;
  data['is_popular_classified'] = entity.isPopularClassified;
  data['bookmark_by_user'] = entity.bookmarkByUser;
  data['liked_by_user'] = entity.likedByUser;
  data['image_url'] = entity.imageUrl;
  data['user_data'] = entity.userData?.toJson();
  return data;
}

extension GetHomeDataExtension on GetHomeData {
  GetHomeData copyWith({
    int? id,
    String? title,
    String? urlcomponent,
    String? company,
    String? popular,
    String? premiumsdate,
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
    String? userId,
    String? type,
    dynamic immlm,
    dynamic plan,
    dynamic city,
    dynamic state,
    dynamic country,
    dynamic posttype,
    int? totallike,
    int? totalcomment,
    int? isPopularClassified,
    bool? bookmarkByUser,
    bool? likedByUser,
    String? imageUrl,
    GetHomeDataUserData? userData,
  }) {
    return GetHomeData()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..urlcomponent = urlcomponent ?? this.urlcomponent
      ..company = company ?? this.company
      ..popular = popular ?? this.popular
      ..premiumsdate = premiumsdate ?? this.premiumsdate
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
      ..posttype = posttype ?? this.posttype
      ..totallike = totallike ?? this.totallike
      ..totalcomment = totalcomment ?? this.totalcomment
      ..isPopularClassified = isPopularClassified ?? this.isPopularClassified
      ..bookmarkByUser = bookmarkByUser ?? this.bookmarkByUser
      ..likedByUser = likedByUser ?? this.likedByUser
      ..imageUrl = imageUrl ?? this.imageUrl
      ..userData = userData ?? this.userData;
  }
}

GetHomeDataUserData $GetHomeDataUserDataFromJson(Map<String, dynamic> json) {
  final GetHomeDataUserData getHomeDataUserData = GetHomeDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getHomeDataUserData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getHomeDataUserData.name = name;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    getHomeDataUserData.email = email;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getHomeDataUserData.userimage = userimage;
  }
  final dynamic countrycode1 = json['countrycode1'];
  if (countrycode1 != null) {
    getHomeDataUserData.countrycode1 = countrycode1;
  }
  final dynamic mobile = json['mobile'];
  if (mobile != null) {
    getHomeDataUserData.mobile = mobile;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getHomeDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getHomeDataUserData.imageThumPath = imageThumPath;
  }
  return getHomeDataUserData;
}

Map<String, dynamic> $GetHomeDataUserDataToJson(GetHomeDataUserData entity) {
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

extension GetHomeDataUserDataExtension on GetHomeDataUserData {
  GetHomeDataUserData copyWith({
    int? id,
    String? name,
    String? email,
    String? userimage,
    dynamic countrycode1,
    dynamic mobile,
    String? imagePath,
    String? imageThumPath,
  }) {
    return GetHomeDataUserData()
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