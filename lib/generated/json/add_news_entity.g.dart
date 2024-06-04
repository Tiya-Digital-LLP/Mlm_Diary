import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/add_news_entity.dart';

AddNewsEntity $AddNewsEntityFromJson(Map<String, dynamic> json) {
  final AddNewsEntity addNewsEntity = AddNewsEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    addNewsEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    addNewsEntity.message = message;
  }
  final AddNewsData? data = jsonConvert.convert<AddNewsData>(json['data']);
  if (data != null) {
    addNewsEntity.data = data;
  }
  return addNewsEntity;
}

Map<String, dynamic> $AddNewsEntityToJson(AddNewsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension AddNewsEntityExtension on AddNewsEntity {
  AddNewsEntity copyWith({
    int? status,
    String? message,
    AddNewsData? data,
  }) {
    return AddNewsEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

AddNewsData $AddNewsDataFromJson(Map<String, dynamic> json) {
  final AddNewsData addNewsData = AddNewsData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    addNewsData.title = title;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    addNewsData.description = description;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    addNewsData.subcategory = subcategory;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    addNewsData.category = category;
  }
  final int? creatby = jsonConvert.convert<int>(json['creatby']);
  if (creatby != null) {
    addNewsData.creatby = creatby;
  }
  final String? photo = jsonConvert.convert<String>(json['photo']);
  if (photo != null) {
    addNewsData.photo = photo;
  }
  final String? ipp = jsonConvert.convert<String>(json['ipp']);
  if (ipp != null) {
    addNewsData.ipp = ipp;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    addNewsData.website = website;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    addNewsData.urlcomponent = urlcomponent;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    addNewsData.createdate = createdate;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    addNewsData.datemodified = datemodified;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    addNewsData.id = id;
  }
  return addNewsData;
}

Map<String, dynamic> $AddNewsDataToJson(AddNewsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['description'] = entity.description;
  data['subcategory'] = entity.subcategory;
  data['category'] = entity.category;
  data['creatby'] = entity.creatby;
  data['photo'] = entity.photo;
  data['ipp'] = entity.ipp;
  data['website'] = entity.website;
  data['urlcomponent'] = entity.urlcomponent;
  data['createdate'] = entity.createdate;
  data['datemodified'] = entity.datemodified;
  data['id'] = entity.id;
  return data;
}

extension AddNewsDataExtension on AddNewsData {
  AddNewsData copyWith({
    String? title,
    String? description,
    String? subcategory,
    String? category,
    int? creatby,
    String? photo,
    String? ipp,
    String? website,
    String? urlcomponent,
    String? createdate,
    String? datemodified,
    int? id,
  }) {
    return AddNewsData()
      ..title = title ?? this.title
      ..description = description ?? this.description
      ..subcategory = subcategory ?? this.subcategory
      ..category = category ?? this.category
      ..creatby = creatby ?? this.creatby
      ..photo = photo ?? this.photo
      ..ipp = ipp ?? this.ipp
      ..website = website ?? this.website
      ..urlcomponent = urlcomponent ?? this.urlcomponent
      ..createdate = createdate ?? this.createdate
      ..datemodified = datemodified ?? this.datemodified
      ..id = id ?? this.id;
  }
}