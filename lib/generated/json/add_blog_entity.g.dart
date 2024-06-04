import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/add_blog_entity.dart';

AddBlogEntity $AddBlogEntityFromJson(Map<String, dynamic> json) {
  final AddBlogEntity addBlogEntity = AddBlogEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    addBlogEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    addBlogEntity.message = message;
  }
  final AddBlogData? data = jsonConvert.convert<AddBlogData>(json['data']);
  if (data != null) {
    addBlogEntity.data = data;
  }
  return addBlogEntity;
}

Map<String, dynamic> $AddBlogEntityToJson(AddBlogEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension AddBlogEntityExtension on AddBlogEntity {
  AddBlogEntity copyWith({
    int? status,
    String? message,
    AddBlogData? data,
  }) {
    return AddBlogEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

AddBlogData $AddBlogDataFromJson(Map<String, dynamic> json) {
  final AddBlogData addBlogData = AddBlogData();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    addBlogData.title = title;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    addBlogData.description = description;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    addBlogData.subcategory = subcategory;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    addBlogData.category = category;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    addBlogData.userId = userId;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    addBlogData.image = image;
  }
  final String? ipp = jsonConvert.convert<String>(json['ipp']);
  if (ipp != null) {
    addBlogData.ipp = ipp;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    addBlogData.website = website;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    addBlogData.urlcomponent = urlcomponent;
  }
  final String? createdDate = jsonConvert.convert<String>(json['created_date']);
  if (createdDate != null) {
    addBlogData.createdDate = createdDate;
  }
  final String? modifiedDate = jsonConvert.convert<String>(
      json['modified_date']);
  if (modifiedDate != null) {
    addBlogData.modifiedDate = modifiedDate;
  }
  final int? articleId = jsonConvert.convert<int>(json['article_id']);
  if (articleId != null) {
    addBlogData.articleId = articleId;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    addBlogData.imagePath = imagePath;
  }
  return addBlogData;
}

Map<String, dynamic> $AddBlogDataToJson(AddBlogData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['description'] = entity.description;
  data['subcategory'] = entity.subcategory;
  data['category'] = entity.category;
  data['user_id'] = entity.userId;
  data['image'] = entity.image;
  data['ipp'] = entity.ipp;
  data['website'] = entity.website;
  data['urlcomponent'] = entity.urlcomponent;
  data['created_date'] = entity.createdDate;
  data['modified_date'] = entity.modifiedDate;
  data['article_id'] = entity.articleId;
  data['image_path'] = entity.imagePath;
  return data;
}

extension AddBlogDataExtension on AddBlogData {
  AddBlogData copyWith({
    String? title,
    String? description,
    String? subcategory,
    String? category,
    int? userId,
    String? image,
    String? ipp,
    String? website,
    String? urlcomponent,
    String? createdDate,
    String? modifiedDate,
    int? articleId,
    String? imagePath,
  }) {
    return AddBlogData()
      ..title = title ?? this.title
      ..description = description ?? this.description
      ..subcategory = subcategory ?? this.subcategory
      ..category = category ?? this.category
      ..userId = userId ?? this.userId
      ..image = image ?? this.image
      ..ipp = ipp ?? this.ipp
      ..website = website ?? this.website
      ..urlcomponent = urlcomponent ?? this.urlcomponent
      ..createdDate = createdDate ?? this.createdDate
      ..modifiedDate = modifiedDate ?? this.modifiedDate
      ..articleId = articleId ?? this.articleId
      ..imagePath = imagePath ?? this.imagePath;
  }
}