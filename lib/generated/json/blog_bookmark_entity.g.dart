import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/blog_bookmark_entity.dart';

BlogBookmarkEntity $BlogBookmarkEntityFromJson(Map<String, dynamic> json) {
  final BlogBookmarkEntity blogBookmarkEntity = BlogBookmarkEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    blogBookmarkEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    blogBookmarkEntity.message = message;
  }
  return blogBookmarkEntity;
}

Map<String, dynamic> $BlogBookmarkEntityToJson(BlogBookmarkEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension BlogBookmarkEntityExtension on BlogBookmarkEntity {
  BlogBookmarkEntity copyWith({
    int? status,
    String? message,
  }) {
    return BlogBookmarkEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}