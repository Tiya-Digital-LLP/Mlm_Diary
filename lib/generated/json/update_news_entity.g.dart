import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/update_news_entity.dart';

UpdateNewsEntity $UpdateNewsEntityFromJson(Map<String, dynamic> json) {
  final UpdateNewsEntity updateNewsEntity = UpdateNewsEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    updateNewsEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    updateNewsEntity.message = message;
  }
  final UpdateNewsData? data = jsonConvert.convert<UpdateNewsData>(
      json['data']);
  if (data != null) {
    updateNewsEntity.data = data;
  }
  return updateNewsEntity;
}

Map<String, dynamic> $UpdateNewsEntityToJson(UpdateNewsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension UpdateNewsEntityExtension on UpdateNewsEntity {
  UpdateNewsEntity copyWith({
    int? status,
    String? message,
    UpdateNewsData? data,
  }) {
    return UpdateNewsEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

UpdateNewsData $UpdateNewsDataFromJson(Map<String, dynamic> json) {
  final UpdateNewsData updateNewsData = UpdateNewsData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    updateNewsData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    updateNewsData.title = title;
  }
  final dynamic titleHindi = json['title_hindi'];
  if (titleHindi != null) {
    updateNewsData.titleHindi = titleHindi;
  }
  final dynamic descriptionMeta = json['description_meta'];
  if (descriptionMeta != null) {
    updateNewsData.descriptionMeta = descriptionMeta;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    updateNewsData.description = description;
  }
  final String? creatby = jsonConvert.convert<String>(json['creatby']);
  if (creatby != null) {
    updateNewsData.creatby = creatby;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    updateNewsData.datemodified = datemodified;
  }
  final String? featured = jsonConvert.convert<String>(json['featured']);
  if (featured != null) {
    updateNewsData.featured = featured;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    updateNewsData.pgcnt = pgcnt;
  }
  final String? ipp = jsonConvert.convert<String>(json['ipp']);
  if (ipp != null) {
    updateNewsData.ipp = ipp;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    updateNewsData.category = category;
  }
  final dynamic city = json['city'];
  if (city != null) {
    updateNewsData.city = city;
  }
  final dynamic state = json['state'];
  if (state != null) {
    updateNewsData.state = state;
  }
  final dynamic country = json['country'];
  if (country != null) {
    updateNewsData.country = country;
  }
  final dynamic source = json['source'];
  if (source != null) {
    updateNewsData.source = source;
  }
  final String? photo = jsonConvert.convert<String>(json['photo']);
  if (photo != null) {
    updateNewsData.photo = photo;
  }
  final dynamic video = json['video'];
  if (video != null) {
    updateNewsData.video = video;
  }
  final dynamic tags = json['tags'];
  if (tags != null) {
    updateNewsData.tags = tags;
  }
  final dynamic extra1 = json['extra1'];
  if (extra1 != null) {
    updateNewsData.extra1 = extra1;
  }
  final dynamic shortContent = json['short_content'];
  if (shortContent != null) {
    updateNewsData.shortContent = shortContent;
  }
  final dynamic vtitle = json['vtitle'];
  if (vtitle != null) {
    updateNewsData.vtitle = vtitle;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    updateNewsData.status = status;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    updateNewsData.subcategory = subcategory;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    updateNewsData.website = website;
  }
  final dynamic appdate = json['appdate'];
  if (appdate != null) {
    updateNewsData.appdate = appdate;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    updateNewsData.createdate = createdate;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    updateNewsData.urlcomponent = urlcomponent;
  }
  final String? classicheck = jsonConvert.convert<String>(json['classicheck']);
  if (classicheck != null) {
    updateNewsData.classicheck = classicheck;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    updateNewsData.imagePath = imagePath;
  }
  return updateNewsData;
}

Map<String, dynamic> $UpdateNewsDataToJson(UpdateNewsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['title_hindi'] = entity.titleHindi;
  data['description_meta'] = entity.descriptionMeta;
  data['description'] = entity.description;
  data['creatby'] = entity.creatby;
  data['datemodified'] = entity.datemodified;
  data['featured'] = entity.featured;
  data['pgcnt'] = entity.pgcnt;
  data['ipp'] = entity.ipp;
  data['category'] = entity.category;
  data['city'] = entity.city;
  data['state'] = entity.state;
  data['country'] = entity.country;
  data['source'] = entity.source;
  data['photo'] = entity.photo;
  data['video'] = entity.video;
  data['tags'] = entity.tags;
  data['extra1'] = entity.extra1;
  data['short_content'] = entity.shortContent;
  data['vtitle'] = entity.vtitle;
  data['status'] = entity.status;
  data['subcategory'] = entity.subcategory;
  data['website'] = entity.website;
  data['appdate'] = entity.appdate;
  data['createdate'] = entity.createdate;
  data['urlcomponent'] = entity.urlcomponent;
  data['classicheck'] = entity.classicheck;
  data['image_path'] = entity.imagePath;
  return data;
}

extension UpdateNewsDataExtension on UpdateNewsData {
  UpdateNewsData copyWith({
    int? id,
    String? title,
    dynamic titleHindi,
    dynamic descriptionMeta,
    String? description,
    String? creatby,
    String? datemodified,
    String? featured,
    int? pgcnt,
    String? ipp,
    String? category,
    dynamic city,
    dynamic state,
    dynamic country,
    dynamic source,
    String? photo,
    dynamic video,
    dynamic tags,
    dynamic extra1,
    dynamic shortContent,
    dynamic vtitle,
    int? status,
    String? subcategory,
    String? website,
    dynamic appdate,
    String? createdate,
    String? urlcomponent,
    String? classicheck,
    String? imagePath,
  }) {
    return UpdateNewsData()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..titleHindi = titleHindi ?? this.titleHindi
      ..descriptionMeta = descriptionMeta ?? this.descriptionMeta
      ..description = description ?? this.description
      ..creatby = creatby ?? this.creatby
      ..datemodified = datemodified ?? this.datemodified
      ..featured = featured ?? this.featured
      ..pgcnt = pgcnt ?? this.pgcnt
      ..ipp = ipp ?? this.ipp
      ..category = category ?? this.category
      ..city = city ?? this.city
      ..state = state ?? this.state
      ..country = country ?? this.country
      ..source = source ?? this.source
      ..photo = photo ?? this.photo
      ..video = video ?? this.video
      ..tags = tags ?? this.tags
      ..extra1 = extra1 ?? this.extra1
      ..shortContent = shortContent ?? this.shortContent
      ..vtitle = vtitle ?? this.vtitle
      ..status = status ?? this.status
      ..subcategory = subcategory ?? this.subcategory
      ..website = website ?? this.website
      ..appdate = appdate ?? this.appdate
      ..createdate = createdate ?? this.createdate
      ..urlcomponent = urlcomponent ?? this.urlcomponent
      ..classicheck = classicheck ?? this.classicheck
      ..imagePath = imagePath ?? this.imagePath;
  }
}