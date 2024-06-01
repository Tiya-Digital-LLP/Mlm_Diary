import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/update_classified_entity.dart';

UpdateClassifiedEntity $UpdateClassifiedEntityFromJson(
    Map<String, dynamic> json) {
  final UpdateClassifiedEntity updateClassifiedEntity = UpdateClassifiedEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    updateClassifiedEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    updateClassifiedEntity.message = message;
  }
  final UpdateClassifiedData? data = jsonConvert.convert<UpdateClassifiedData>(
      json['data']);
  if (data != null) {
    updateClassifiedEntity.data = data;
  }
  return updateClassifiedEntity;
}

Map<String, dynamic> $UpdateClassifiedEntityToJson(
    UpdateClassifiedEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension UpdateClassifiedEntityExtension on UpdateClassifiedEntity {
  UpdateClassifiedEntity copyWith({
    int? status,
    String? message,
    UpdateClassifiedData? data,
  }) {
    return UpdateClassifiedEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

UpdateClassifiedData $UpdateClassifiedDataFromJson(Map<String, dynamic> json) {
  final UpdateClassifiedData updateClassifiedData = UpdateClassifiedData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    updateClassifiedData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    updateClassifiedData.title = title;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    updateClassifiedData.description = description;
  }
  final String? creatby = jsonConvert.convert<String>(json['creatby']);
  if (creatby != null) {
    updateClassifiedData.creatby = creatby;
  }
  final String? datecreated = jsonConvert.convert<String>(json['datecreated']);
  if (datecreated != null) {
    updateClassifiedData.datecreated = datecreated;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    updateClassifiedData.datemodified = datemodified;
  }
  final String? dateviewed = jsonConvert.convert<String>(json['dateviewed']);
  if (dateviewed != null) {
    updateClassifiedData.dateviewed = dateviewed;
  }
  final String? completee = jsonConvert.convert<String>(json['completee']);
  if (completee != null) {
    updateClassifiedData.completee = completee;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    updateClassifiedData.pgcnt = pgcnt;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    updateClassifiedData.status = status;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    updateClassifiedData.category = category;
  }
  final String? ipp = jsonConvert.convert<String>(json['ipp']);
  if (ipp != null) {
    updateClassifiedData.ipp = ipp;
  }
  final dynamic tags = json['tags'];
  if (tags != null) {
    updateClassifiedData.tags = tags;
  }
  final int? facebook = jsonConvert.convert<int>(json['facebook']);
  if (facebook != null) {
    updateClassifiedData.facebook = facebook;
  }
  final int? twitter = jsonConvert.convert<int>(json['twitter']);
  if (twitter != null) {
    updateClassifiedData.twitter = twitter;
  }
  final int? googleplus = jsonConvert.convert<int>(json['googleplus']);
  if (googleplus != null) {
    updateClassifiedData.googleplus = googleplus;
  }
  final int? logit = jsonConvert.convert<int>(json['logit']);
  if (logit != null) {
    updateClassifiedData.logit = logit;
  }
  final int? updatee = jsonConvert.convert<int>(json['updatee']);
  if (updatee != null) {
    updateClassifiedData.updatee = updatee;
  }
  final String? popular = jsonConvert.convert<String>(json['popular']);
  if (popular != null) {
    updateClassifiedData.popular = popular;
  }
  final int? premium = jsonConvert.convert<int>(json['premium']);
  if (premium != null) {
    updateClassifiedData.premium = premium;
  }
  final dynamic premiumDate = json['premium_date'];
  if (premiumDate != null) {
    updateClassifiedData.premiumDate = premiumDate;
  }
  final dynamic premiumsdate = json['premiumsdate'];
  if (premiumsdate != null) {
    updateClassifiedData.premiumsdate = premiumsdate;
  }
  final dynamic premiumedate = json['premiumedate'];
  if (premiumedate != null) {
    updateClassifiedData.premiumedate = premiumedate;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    updateClassifiedData.subcategory = subcategory;
  }
  final dynamic ctype = json['ctype'];
  if (ctype != null) {
    updateClassifiedData.ctype = ctype;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    updateClassifiedData.location = location;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    updateClassifiedData.image = image;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    updateClassifiedData.company = company;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    updateClassifiedData.website = website;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    updateClassifiedData.city = city;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    updateClassifiedData.state = state;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    updateClassifiedData.country = country;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    updateClassifiedData.urlcomponent = urlcomponent;
  }
  final String? paidtype = jsonConvert.convert<String>(json['paidtype']);
  if (paidtype != null) {
    updateClassifiedData.paidtype = paidtype;
  }
  final String? classicheck = jsonConvert.convert<String>(json['classicheck']);
  if (classicheck != null) {
    updateClassifiedData.classicheck = classicheck;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    updateClassifiedData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    updateClassifiedData.imageThumPath = imageThumPath;
  }
  return updateClassifiedData;
}

Map<String, dynamic> $UpdateClassifiedDataToJson(UpdateClassifiedData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['description'] = entity.description;
  data['creatby'] = entity.creatby;
  data['datecreated'] = entity.datecreated;
  data['datemodified'] = entity.datemodified;
  data['dateviewed'] = entity.dateviewed;
  data['completee'] = entity.completee;
  data['pgcnt'] = entity.pgcnt;
  data['status'] = entity.status;
  data['category'] = entity.category;
  data['ipp'] = entity.ipp;
  data['tags'] = entity.tags;
  data['facebook'] = entity.facebook;
  data['twitter'] = entity.twitter;
  data['googleplus'] = entity.googleplus;
  data['logit'] = entity.logit;
  data['updatee'] = entity.updatee;
  data['popular'] = entity.popular;
  data['premium'] = entity.premium;
  data['premium_date'] = entity.premiumDate;
  data['premiumsdate'] = entity.premiumsdate;
  data['premiumedate'] = entity.premiumedate;
  data['subcategory'] = entity.subcategory;
  data['ctype'] = entity.ctype;
  data['location'] = entity.location;
  data['image'] = entity.image;
  data['company'] = entity.company;
  data['website'] = entity.website;
  data['city'] = entity.city;
  data['state'] = entity.state;
  data['country'] = entity.country;
  data['urlcomponent'] = entity.urlcomponent;
  data['paidtype'] = entity.paidtype;
  data['classicheck'] = entity.classicheck;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension UpdateClassifiedDataExtension on UpdateClassifiedData {
  UpdateClassifiedData copyWith({
    int? id,
    String? title,
    String? description,
    String? creatby,
    String? datecreated,
    String? datemodified,
    String? dateviewed,
    String? completee,
    int? pgcnt,
    String? status,
    String? category,
    String? ipp,
    dynamic tags,
    int? facebook,
    int? twitter,
    int? googleplus,
    int? logit,
    int? updatee,
    String? popular,
    int? premium,
    dynamic premiumDate,
    dynamic premiumsdate,
    dynamic premiumedate,
    String? subcategory,
    dynamic ctype,
    String? location,
    String? image,
    String? company,
    String? website,
    String? city,
    String? state,
    String? country,
    String? urlcomponent,
    String? paidtype,
    String? classicheck,
    String? imagePath,
    String? imageThumPath,
  }) {
    return UpdateClassifiedData()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..description = description ?? this.description
      ..creatby = creatby ?? this.creatby
      ..datecreated = datecreated ?? this.datecreated
      ..datemodified = datemodified ?? this.datemodified
      ..dateviewed = dateviewed ?? this.dateviewed
      ..completee = completee ?? this.completee
      ..pgcnt = pgcnt ?? this.pgcnt
      ..status = status ?? this.status
      ..category = category ?? this.category
      ..ipp = ipp ?? this.ipp
      ..tags = tags ?? this.tags
      ..facebook = facebook ?? this.facebook
      ..twitter = twitter ?? this.twitter
      ..googleplus = googleplus ?? this.googleplus
      ..logit = logit ?? this.logit
      ..updatee = updatee ?? this.updatee
      ..popular = popular ?? this.popular
      ..premium = premium ?? this.premium
      ..premiumDate = premiumDate ?? this.premiumDate
      ..premiumsdate = premiumsdate ?? this.premiumsdate
      ..premiumedate = premiumedate ?? this.premiumedate
      ..subcategory = subcategory ?? this.subcategory
      ..ctype = ctype ?? this.ctype
      ..location = location ?? this.location
      ..image = image ?? this.image
      ..company = company ?? this.company
      ..website = website ?? this.website
      ..city = city ?? this.city
      ..state = state ?? this.state
      ..country = country ?? this.country
      ..urlcomponent = urlcomponent ?? this.urlcomponent
      ..paidtype = paidtype ?? this.paidtype
      ..classicheck = classicheck ?? this.classicheck
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}