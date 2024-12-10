import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/update_blog_entity.dart';

UpdateBlogEntity $UpdateBlogEntityFromJson(Map<String, dynamic> json) {
  final UpdateBlogEntity updateBlogEntity = UpdateBlogEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    updateBlogEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    updateBlogEntity.message = message;
  }
  final UpdateBlogData? data = jsonConvert.convert<UpdateBlogData>(
      json['data']);
  if (data != null) {
    updateBlogEntity.data = data;
  }
  return updateBlogEntity;
}

Map<String, dynamic> $UpdateBlogEntityToJson(UpdateBlogEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension UpdateBlogEntityExtension on UpdateBlogEntity {
  UpdateBlogEntity copyWith({
    int? status,
    String? message,
    UpdateBlogData? data,
  }) {
    return UpdateBlogEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

UpdateBlogData $UpdateBlogDataFromJson(Map<String, dynamic> json) {
  final UpdateBlogData updateBlogData = UpdateBlogData();
  final int? articleId = jsonConvert.convert<int>(json['article_id']);
  if (articleId != null) {
    updateBlogData.articleId = articleId;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    updateBlogData.title = title;
  }
  final String? titleUrl = jsonConvert.convert<String>(json['title_url']);
  if (titleUrl != null) {
    updateBlogData.titleUrl = titleUrl;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    updateBlogData.description = description;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    updateBlogData.image = image;
  }
  final dynamic metaKeywords = json['meta_keywords'];
  if (metaKeywords != null) {
    updateBlogData.metaKeywords = metaKeywords;
  }
  final dynamic metaDescription = json['meta_description'];
  if (metaDescription != null) {
    updateBlogData.metaDescription = metaDescription;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    updateBlogData.userId = userId;
  }
  final String? ipp = jsonConvert.convert<String>(json['ipp']);
  if (ipp != null) {
    updateBlogData.ipp = ipp;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    updateBlogData.pgcnt = pgcnt;
  }
  final dynamic lastviewDate = json['lastview_date'];
  if (lastviewDate != null) {
    updateBlogData.lastviewDate = lastviewDate;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    updateBlogData.status = status;
  }
  final String? createdDate = jsonConvert.convert<String>(json['created_date']);
  if (createdDate != null) {
    updateBlogData.createdDate = createdDate;
  }
  final String? modifiedDate = jsonConvert.convert<String>(
      json['modified_date']);
  if (modifiedDate != null) {
    updateBlogData.modifiedDate = modifiedDate;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    updateBlogData.category = category;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    updateBlogData.subcategory = subcategory;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    updateBlogData.website = website;
  }
  final dynamic appdate = json['appdate'];
  if (appdate != null) {
    updateBlogData.appdate = appdate;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    updateBlogData.urlcomponent = urlcomponent;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    updateBlogData.imagePath = imagePath;
  }
  return updateBlogData;
}

Map<String, dynamic> $UpdateBlogDataToJson(UpdateBlogData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['article_id'] = entity.articleId;
  data['title'] = entity.title;
  data['title_url'] = entity.titleUrl;
  data['description'] = entity.description;
  data['image'] = entity.image;
  data['meta_keywords'] = entity.metaKeywords;
  data['meta_description'] = entity.metaDescription;
  data['user_id'] = entity.userId;
  data['ipp'] = entity.ipp;
  data['pgcnt'] = entity.pgcnt;
  data['lastview_date'] = entity.lastviewDate;
  data['status'] = entity.status;
  data['created_date'] = entity.createdDate;
  data['modified_date'] = entity.modifiedDate;
  data['category'] = entity.category;
  data['subcategory'] = entity.subcategory;
  data['website'] = entity.website;
  data['appdate'] = entity.appdate;
  data['urlcomponent'] = entity.urlcomponent;
  data['image_path'] = entity.imagePath;
  return data;
}

extension UpdateBlogDataExtension on UpdateBlogData {
  UpdateBlogData copyWith({
    int? articleId,
    String? title,
    String? titleUrl,
    String? description,
    String? image,
    dynamic metaKeywords,
    dynamic metaDescription,
    int? userId,
    String? ipp,
    int? pgcnt,
    dynamic lastviewDate,
    int? status,
    String? createdDate,
    String? modifiedDate,
    String? category,
    String? subcategory,
    String? website,
    dynamic appdate,
    String? urlcomponent,
    String? imagePath,
  }) {
    return UpdateBlogData()
      ..articleId = articleId ?? this.articleId
      ..title = title ?? this.title
      ..titleUrl = titleUrl ?? this.titleUrl
      ..description = description ?? this.description
      ..image = image ?? this.image
      ..metaKeywords = metaKeywords ?? this.metaKeywords
      ..metaDescription = metaDescription ?? this.metaDescription
      ..userId = userId ?? this.userId
      ..ipp = ipp ?? this.ipp
      ..pgcnt = pgcnt ?? this.pgcnt
      ..lastviewDate = lastviewDate ?? this.lastviewDate
      ..status = status ?? this.status
      ..createdDate = createdDate ?? this.createdDate
      ..modifiedDate = modifiedDate ?? this.modifiedDate
      ..category = category ?? this.category
      ..subcategory = subcategory ?? this.subcategory
      ..website = website ?? this.website
      ..appdate = appdate ?? this.appdate
      ..urlcomponent = urlcomponent ?? this.urlcomponent
      ..imagePath = imagePath ?? this.imagePath;
  }
}