import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_admin_company_entity.dart';

GetAdminCompanyEntity $GetAdminCompanyEntityFromJson(
    Map<String, dynamic> json) {
  final GetAdminCompanyEntity getAdminCompanyEntity = GetAdminCompanyEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getAdminCompanyEntity.status = status;
  }
  final List<GetAdminCompanyData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetAdminCompanyData>(e) as GetAdminCompanyData)
      .toList();
  if (data != null) {
    getAdminCompanyEntity.data = data;
  }
  return getAdminCompanyEntity;
}

Map<String, dynamic> $GetAdminCompanyEntityToJson(
    GetAdminCompanyEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetAdminCompanyEntityExtension on GetAdminCompanyEntity {
  GetAdminCompanyEntity copyWith({
    int? status,
    List<GetAdminCompanyData>? data,
  }) {
    return GetAdminCompanyEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

GetAdminCompanyData $GetAdminCompanyDataFromJson(Map<String, dynamic> json) {
  final GetAdminCompanyData getAdminCompanyData = GetAdminCompanyData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getAdminCompanyData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getAdminCompanyData.name = name;
  }
  final String? sname = jsonConvert.convert<String>(json['sname']);
  if (sname != null) {
    getAdminCompanyData.sname = sname;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    getAdminCompanyData.location = location;
  }
  final String? plan = jsonConvert.convert<String>(json['plan']);
  if (plan != null) {
    getAdminCompanyData.plan = plan;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    getAdminCompanyData.email = email;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    getAdminCompanyData.phone = phone;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    getAdminCompanyData.website = website;
  }
  final String? fblink = jsonConvert.convert<String>(json['fblink']);
  if (fblink != null) {
    getAdminCompanyData.fblink = fblink;
  }
  final String? inlink = jsonConvert.convert<String>(json['inlink']);
  if (inlink != null) {
    getAdminCompanyData.inlink = inlink;
  }
  final String? twlink = jsonConvert.convert<String>(json['twlink']);
  if (twlink != null) {
    getAdminCompanyData.twlink = twlink;
  }
  final String? liklink = jsonConvert.convert<String>(json['liklink']);
  if (liklink != null) {
    getAdminCompanyData.liklink = liklink;
  }
  final String? youlink = jsonConvert.convert<String>(json['youlink']);
  if (youlink != null) {
    getAdminCompanyData.youlink = youlink;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    getAdminCompanyData.image = image;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    getAdminCompanyData.description = description;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    getAdminCompanyData.urlcomponent = urlcomponent;
  }
  final String? active = jsonConvert.convert<String>(json['active']);
  if (active != null) {
    getAdminCompanyData.active = active;
  }
  final String? adddate = jsonConvert.convert<String>(json['adddate']);
  if (adddate != null) {
    getAdminCompanyData.adddate = adddate;
  }
  final String? addby = jsonConvert.convert<String>(json['addby']);
  if (addby != null) {
    getAdminCompanyData.addby = addby;
  }
  final String? savedraft = jsonConvert.convert<String>(json['savedraft']);
  if (savedraft != null) {
    getAdminCompanyData.savedraft = savedraft;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    getAdminCompanyData.city = city;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    getAdminCompanyData.state = state;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    getAdminCompanyData.country = country;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    getAdminCompanyData.pgcnt = pgcnt;
  }
  final String? lastviewDate = jsonConvert.convert<String>(
      json['lastview_date']);
  if (lastviewDate != null) {
    getAdminCompanyData.lastviewDate = lastviewDate;
  }
  final String? metaTitle = jsonConvert.convert<String>(json['meta_title']);
  if (metaTitle != null) {
    getAdminCompanyData.metaTitle = metaTitle;
  }
  final String? metaDes = jsonConvert.convert<String>(json['meta_des']);
  if (metaDes != null) {
    getAdminCompanyData.metaDes = metaDes;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    getAdminCompanyData.totallike = totallike;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    getAdminCompanyData.totalcomment = totalcomment;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    getAdminCompanyData.likedByUser = likedByUser;
  }
  final bool? bookmarkedByUser = jsonConvert.convert<bool>(
      json['bookmarked_by_user']);
  if (bookmarkedByUser != null) {
    getAdminCompanyData.bookmarkedByUser = bookmarkedByUser;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    getAdminCompanyData.imageUrl = imageUrl;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getAdminCompanyData.title = title;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getAdminCompanyData.createdate = createdate;
  }
  final String? fullUrl = jsonConvert.convert<String>(json['full_url']);
  if (fullUrl != null) {
    getAdminCompanyData.fullUrl = fullUrl;
  }
  return getAdminCompanyData;
}

Map<String, dynamic> $GetAdminCompanyDataToJson(GetAdminCompanyData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['sname'] = entity.sname;
  data['location'] = entity.location;
  data['plan'] = entity.plan;
  data['email'] = entity.email;
  data['phone'] = entity.phone;
  data['website'] = entity.website;
  data['fblink'] = entity.fblink;
  data['inlink'] = entity.inlink;
  data['twlink'] = entity.twlink;
  data['liklink'] = entity.liklink;
  data['youlink'] = entity.youlink;
  data['image'] = entity.image;
  data['description'] = entity.description;
  data['urlcomponent'] = entity.urlcomponent;
  data['active'] = entity.active;
  data['adddate'] = entity.adddate;
  data['addby'] = entity.addby;
  data['savedraft'] = entity.savedraft;
  data['city'] = entity.city;
  data['state'] = entity.state;
  data['country'] = entity.country;
  data['pgcnt'] = entity.pgcnt;
  data['lastview_date'] = entity.lastviewDate;
  data['meta_title'] = entity.metaTitle;
  data['meta_des'] = entity.metaDes;
  data['totallike'] = entity.totallike;
  data['totalcomment'] = entity.totalcomment;
  data['liked_by_user'] = entity.likedByUser;
  data['bookmarked_by_user'] = entity.bookmarkedByUser;
  data['image_url'] = entity.imageUrl;
  data['title'] = entity.title;
  data['createdate'] = entity.createdate;
  data['full_url'] = entity.fullUrl;
  return data;
}

extension GetAdminCompanyDataExtension on GetAdminCompanyData {
  GetAdminCompanyData copyWith({
    int? id,
    String? name,
    String? sname,
    String? location,
    String? plan,
    String? email,
    String? phone,
    String? website,
    String? fblink,
    String? inlink,
    String? twlink,
    String? liklink,
    String? youlink,
    String? image,
    String? description,
    String? urlcomponent,
    String? active,
    String? adddate,
    String? addby,
    String? savedraft,
    String? city,
    String? state,
    String? country,
    int? pgcnt,
    String? lastviewDate,
    String? metaTitle,
    String? metaDes,
    int? totallike,
    int? totalcomment,
    bool? likedByUser,
    bool? bookmarkedByUser,
    String? imageUrl,
    String? title,
    String? createdate,
    String? fullUrl,
  }) {
    return GetAdminCompanyData()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..sname = sname ?? this.sname
      ..location = location ?? this.location
      ..plan = plan ?? this.plan
      ..email = email ?? this.email
      ..phone = phone ?? this.phone
      ..website = website ?? this.website
      ..fblink = fblink ?? this.fblink
      ..inlink = inlink ?? this.inlink
      ..twlink = twlink ?? this.twlink
      ..liklink = liklink ?? this.liklink
      ..youlink = youlink ?? this.youlink
      ..image = image ?? this.image
      ..description = description ?? this.description
      ..urlcomponent = urlcomponent ?? this.urlcomponent
      ..active = active ?? this.active
      ..adddate = adddate ?? this.adddate
      ..addby = addby ?? this.addby
      ..savedraft = savedraft ?? this.savedraft
      ..city = city ?? this.city
      ..state = state ?? this.state
      ..country = country ?? this.country
      ..pgcnt = pgcnt ?? this.pgcnt
      ..lastviewDate = lastviewDate ?? this.lastviewDate
      ..metaTitle = metaTitle ?? this.metaTitle
      ..metaDes = metaDes ?? this.metaDes
      ..totallike = totallike ?? this.totallike
      ..totalcomment = totalcomment ?? this.totalcomment
      ..likedByUser = likedByUser ?? this.likedByUser
      ..bookmarkedByUser = bookmarkedByUser ?? this.bookmarkedByUser
      ..imageUrl = imageUrl ?? this.imageUrl
      ..title = title ?? this.title
      ..createdate = createdate ?? this.createdate
      ..fullUrl = fullUrl ?? this.fullUrl;
  }
}