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
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    manageClassifiedData.description = description;
  }
  final String? creatby = jsonConvert.convert<String>(json['creatby']);
  if (creatby != null) {
    manageClassifiedData.creatby = creatby;
  }
  final String? datecreated = jsonConvert.convert<String>(json['datecreated']);
  if (datecreated != null) {
    manageClassifiedData.datecreated = datecreated;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    manageClassifiedData.datemodified = datemodified;
  }
  final String? dateviewed = jsonConvert.convert<String>(json['dateviewed']);
  if (dateviewed != null) {
    manageClassifiedData.dateviewed = dateviewed;
  }
  final String? completee = jsonConvert.convert<String>(json['completee']);
  if (completee != null) {
    manageClassifiedData.completee = completee;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    manageClassifiedData.pgcnt = pgcnt;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    manageClassifiedData.status = status;
  }
  final dynamic category = json['category'];
  if (category != null) {
    manageClassifiedData.category = category;
  }
  final String? ipp = jsonConvert.convert<String>(json['ipp']);
  if (ipp != null) {
    manageClassifiedData.ipp = ipp;
  }
  final dynamic tags = json['tags'];
  if (tags != null) {
    manageClassifiedData.tags = tags;
  }
  final int? facebook = jsonConvert.convert<int>(json['facebook']);
  if (facebook != null) {
    manageClassifiedData.facebook = facebook;
  }
  final int? twitter = jsonConvert.convert<int>(json['twitter']);
  if (twitter != null) {
    manageClassifiedData.twitter = twitter;
  }
  final int? googleplus = jsonConvert.convert<int>(json['googleplus']);
  if (googleplus != null) {
    manageClassifiedData.googleplus = googleplus;
  }
  final int? logit = jsonConvert.convert<int>(json['logit']);
  if (logit != null) {
    manageClassifiedData.logit = logit;
  }
  final int? updatee = jsonConvert.convert<int>(json['updatee']);
  if (updatee != null) {
    manageClassifiedData.updatee = updatee;
  }
  final String? popular = jsonConvert.convert<String>(json['popular']);
  if (popular != null) {
    manageClassifiedData.popular = popular;
  }
  final int? premium = jsonConvert.convert<int>(json['premium']);
  if (premium != null) {
    manageClassifiedData.premium = premium;
  }
  final dynamic premiumDate = json['premium_date'];
  if (premiumDate != null) {
    manageClassifiedData.premiumDate = premiumDate;
  }
  final dynamic premiumsdate = json['premiumsdate'];
  if (premiumsdate != null) {
    manageClassifiedData.premiumsdate = premiumsdate;
  }
  final dynamic premiumedate = json['premiumedate'];
  if (premiumedate != null) {
    manageClassifiedData.premiumedate = premiumedate;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    manageClassifiedData.subcategory = subcategory;
  }
  final dynamic ctype = json['ctype'];
  if (ctype != null) {
    manageClassifiedData.ctype = ctype;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    manageClassifiedData.location = location;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    manageClassifiedData.image = image;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    manageClassifiedData.company = company;
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
  final dynamic urlcomponent = json['urlcomponent'];
  if (urlcomponent != null) {
    manageClassifiedData.urlcomponent = urlcomponent;
  }
  final String? paidtype = jsonConvert.convert<String>(json['paidtype']);
  if (paidtype != null) {
    manageClassifiedData.paidtype = paidtype;
  }
  final String? classicheck = jsonConvert.convert<String>(json['classicheck']);
  if (classicheck != null) {
    manageClassifiedData.classicheck = classicheck;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    manageClassifiedData.totallike = totallike;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    manageClassifiedData.totalcomment = totalcomment;
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
  data['totallike'] = entity.totallike;
  data['totalcomment'] = entity.totalcomment;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension ManageClassifiedDataExtension on ManageClassifiedData {
  ManageClassifiedData copyWith({
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
    dynamic category,
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
    dynamic urlcomponent,
    String? paidtype,
    String? classicheck,
    int? totallike,
    int? totalcomment,
    String? imagePath,
    String? imageThumPath,
  }) {
    return ManageClassifiedData()
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
      ..totallike = totallike ?? this.totallike
      ..totalcomment = totalcomment ?? this.totalcomment
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}