import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/blog_count_view_entity.dart';

BlogCountViewEntity $BlogCountViewEntityFromJson(Map<String, dynamic> json) {
  final BlogCountViewEntity blogCountViewEntity = BlogCountViewEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    blogCountViewEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    blogCountViewEntity.message = message;
  }
  return blogCountViewEntity;
}

Map<String, dynamic> $BlogCountViewEntityToJson(BlogCountViewEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension BlogCountViewEntityExtension on BlogCountViewEntity {
  BlogCountViewEntity copyWith({
    int? status,
    String? message,
  }) {
    return BlogCountViewEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}