import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_user_all_post_entity.dart';

GetUserAllPostEntity $GetUserAllPostEntityFromJson(Map<String, dynamic> json) {
  final GetUserAllPostEntity getUserAllPostEntity = GetUserAllPostEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getUserAllPostEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getUserAllPostEntity.message = message;
  }
  final List<GetUserAllPostData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetUserAllPostData>(e) as GetUserAllPostData)
      .toList();
  if (data != null) {
    getUserAllPostEntity.data = data;
  }
  return getUserAllPostEntity;
}

Map<String, dynamic> $GetUserAllPostEntityToJson(GetUserAllPostEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetUserAllPostEntityExtension on GetUserAllPostEntity {
  GetUserAllPostEntity copyWith({
    int? status,
    String? message,
    List<GetUserAllPostData>? data,
  }) {
    return GetUserAllPostEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

GetUserAllPostData $GetUserAllPostDataFromJson(Map<String, dynamic> json) {
  final GetUserAllPostData getUserAllPostData = GetUserAllPostData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getUserAllPostData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getUserAllPostData.title = title;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    getUserAllPostData.urlcomponent = urlcomponent;
  }
  final dynamic company = json['company'];
  if (company != null) {
    getUserAllPostData.company = company;
  }
  final dynamic popular = json['popular'];
  if (popular != null) {
    getUserAllPostData.popular = popular;
  }
  final dynamic premiumsdate = json['premiumsdate'];
  if (premiumsdate != null) {
    getUserAllPostData.premiumsdate = premiumsdate;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    getUserAllPostData.category = category;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    getUserAllPostData.subcategory = subcategory;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    getUserAllPostData.description = description;
  }
  final dynamic website = json['website'];
  if (website != null) {
    getUserAllPostData.website = website;
  }
  final dynamic email = json['email'];
  if (email != null) {
    getUserAllPostData.email = email;
  }
  final dynamic phone = json['phone'];
  if (phone != null) {
    getUserAllPostData.phone = phone;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getUserAllPostData.createdate = createdate;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    getUserAllPostData.updatedAt = updatedAt;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    getUserAllPostData.pgcnt = pgcnt;
  }
  final dynamic location = json['location'];
  if (location != null) {
    getUserAllPostData.location = location;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    getUserAllPostData.image = image;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    getUserAllPostData.userId = userId;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    getUserAllPostData.type = type;
  }
  final dynamic immlm = json['immlm'];
  if (immlm != null) {
    getUserAllPostData.immlm = immlm;
  }
  final dynamic plan = json['plan'];
  if (plan != null) {
    getUserAllPostData.plan = plan;
  }
  final dynamic city = json['city'];
  if (city != null) {
    getUserAllPostData.city = city;
  }
  final dynamic state = json['state'];
  if (state != null) {
    getUserAllPostData.state = state;
  }
  final dynamic country = json['country'];
  if (country != null) {
    getUserAllPostData.country = country;
  }
  final dynamic posttype = json['posttype'];
  if (posttype != null) {
    getUserAllPostData.posttype = posttype;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    getUserAllPostData.totallike = totallike;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    getUserAllPostData.totalcomment = totalcomment;
  }
  final int? isPopularClassified = jsonConvert.convert<int>(
      json['is_popular_classified']);
  if (isPopularClassified != null) {
    getUserAllPostData.isPopularClassified = isPopularClassified;
  }
  final int? totalquestionAnswer = jsonConvert.convert<int>(
      json['totalquestion_answer']);
  if (totalquestionAnswer != null) {
    getUserAllPostData.totalquestionAnswer = totalquestionAnswer;
  }
  final bool? bookmarkByUser = jsonConvert.convert<bool>(
      json['bookmark_by_user']);
  if (bookmarkByUser != null) {
    getUserAllPostData.bookmarkByUser = bookmarkByUser;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    getUserAllPostData.likedByUser = likedByUser;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    getUserAllPostData.imageUrl = imageUrl;
  }
  final GetUserAllPostDataUserData? userData = jsonConvert.convert<
      GetUserAllPostDataUserData>(json['user_data']);
  if (userData != null) {
    getUserAllPostData.userData = userData;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    getUserAllPostData.datemodified = datemodified;
  }
  return getUserAllPostData;
}

Map<String, dynamic> $GetUserAllPostDataToJson(GetUserAllPostData entity) {
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
  data['totalquestion_answer'] = entity.totalquestionAnswer;
  data['bookmark_by_user'] = entity.bookmarkByUser;
  data['liked_by_user'] = entity.likedByUser;
  data['image_url'] = entity.imageUrl;
  data['user_data'] = entity.userData?.toJson();
  data['datemodified'] = entity.datemodified;
  return data;
}

extension GetUserAllPostDataExtension on GetUserAllPostData {
  GetUserAllPostData copyWith({
    int? id,
    String? title,
    String? urlcomponent,
    dynamic company,
    dynamic popular,
    dynamic premiumsdate,
    String? category,
    String? subcategory,
    String? description,
    dynamic website,
    dynamic email,
    dynamic phone,
    String? createdate,
    String? updatedAt,
    int? pgcnt,
    dynamic location,
    String? image,
    int? userId,
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
    int? totalquestionAnswer,
    bool? bookmarkByUser,
    bool? likedByUser,
    String? imageUrl,
    GetUserAllPostDataUserData? userData,
    String? datemodified,
  }) {
    return GetUserAllPostData()
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
      ..totalquestionAnswer = totalquestionAnswer ?? this.totalquestionAnswer
      ..bookmarkByUser = bookmarkByUser ?? this.bookmarkByUser
      ..likedByUser = likedByUser ?? this.likedByUser
      ..imageUrl = imageUrl ?? this.imageUrl
      ..userData = userData ?? this.userData
      ..datemodified = datemodified ?? this.datemodified;
  }
}

GetUserAllPostDataUserData $GetUserAllPostDataUserDataFromJson(
    Map<String, dynamic> json) {
  final GetUserAllPostDataUserData getUserAllPostDataUserData = GetUserAllPostDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getUserAllPostDataUserData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getUserAllPostDataUserData.name = name;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    getUserAllPostDataUserData.email = email;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getUserAllPostDataUserData.userimage = userimage;
  }
  final String? countrycode1 = jsonConvert.convert<String>(
      json['countrycode1']);
  if (countrycode1 != null) {
    getUserAllPostDataUserData.countrycode1 = countrycode1;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    getUserAllPostDataUserData.mobile = mobile;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getUserAllPostDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getUserAllPostDataUserData.imageThumPath = imageThumPath;
  }
  return getUserAllPostDataUserData;
}

Map<String, dynamic> $GetUserAllPostDataUserDataToJson(
    GetUserAllPostDataUserData entity) {
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

extension GetUserAllPostDataUserDataExtension on GetUserAllPostDataUserData {
  GetUserAllPostDataUserData copyWith({
    int? id,
    String? name,
    String? email,
    String? userimage,
    String? countrycode1,
    String? mobile,
    String? imagePath,
    String? imageThumPath,
  }) {
    return GetUserAllPostDataUserData()
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