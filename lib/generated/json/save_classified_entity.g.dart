import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/save_classified_entity.dart';

SaveClassifiedEntity $SaveClassifiedEntityFromJson(Map<String, dynamic> json) {
  final SaveClassifiedEntity saveClassifiedEntity = SaveClassifiedEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    saveClassifiedEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    saveClassifiedEntity.message = message;
  }
  final SaveClassifiedData? data = jsonConvert.convert<SaveClassifiedData>(
      json['data']);
  if (data != null) {
    saveClassifiedEntity.data = data;
  }
  return saveClassifiedEntity;
}

Map<String, dynamic> $SaveClassifiedEntityToJson(SaveClassifiedEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension SaveClassifiedEntityExtension on SaveClassifiedEntity {
  SaveClassifiedEntity copyWith({
    int? status,
    String? message,
    SaveClassifiedData? data,
  }) {
    return SaveClassifiedEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

SaveClassifiedData $SaveClassifiedDataFromJson(Map<String, dynamic> json) {
  final SaveClassifiedData saveClassifiedData = SaveClassifiedData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    saveClassifiedData.title = title;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    saveClassifiedData.description = description;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    saveClassifiedData.subcategory = subcategory;
  }
  final int? creatby = jsonConvert.convert<int>(json['creatby']);
  if (creatby != null) {
    saveClassifiedData.creatby = creatby;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    saveClassifiedData.location = location;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    saveClassifiedData.city = city;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    saveClassifiedData.state = state;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    saveClassifiedData.image = image;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    saveClassifiedData.country = country;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    saveClassifiedData.company = company;
  }
  final String? ipp = jsonConvert.convert<String>(json['ipp']);
  if (ipp != null) {
    saveClassifiedData.ipp = ipp;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    saveClassifiedData.website = website;
  }
  final String? datecreated = jsonConvert.convert<String>(json['datecreated']);
  if (datecreated != null) {
    saveClassifiedData.datecreated = datecreated;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    saveClassifiedData.datemodified = datemodified;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    saveClassifiedData.id = id;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    saveClassifiedData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    saveClassifiedData.imageThumPath = imageThumPath;
  }
  return saveClassifiedData;
}

Map<String, dynamic> $SaveClassifiedDataToJson(SaveClassifiedData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['description'] = entity.description;
  data['subcategory'] = entity.subcategory;
  data['creatby'] = entity.creatby;
  data['location'] = entity.location;
  data['city'] = entity.city;
  data['state'] = entity.state;
  data['image'] = entity.image;
  data['country'] = entity.country;
  data['company'] = entity.company;
  data['ipp'] = entity.ipp;
  data['website'] = entity.website;
  data['datecreated'] = entity.datecreated;
  data['datemodified'] = entity.datemodified;
  data['id'] = entity.id;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension SaveClassifiedDataExtension on SaveClassifiedData {
  SaveClassifiedData copyWith({
    String? title,
    String? description,
    String? subcategory,
    int? creatby,
    String? location,
    String? city,
    String? state,
    String? image,
    String? country,
    String? company,
    String? ipp,
    String? website,
    String? datecreated,
    String? datemodified,
    int? id,
    String? imagePath,
    String? imageThumPath,
  }) {
    return SaveClassifiedData()
      ..title = title ?? this.title
      ..description = description ?? this.description
      ..subcategory = subcategory ?? this.subcategory
      ..creatby = creatby ?? this.creatby
      ..location = location ?? this.location
      ..city = city ?? this.city
      ..state = state ?? this.state
      ..image = image ?? this.image
      ..country = country ?? this.country
      ..company = company ?? this.company
      ..ipp = ipp ?? this.ipp
      ..website = website ?? this.website
      ..datecreated = datecreated ?? this.datecreated
      ..datemodified = datemodified ?? this.datemodified
      ..id = id ?? this.id
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}