import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/l_iked_blog_entity.dart';

LIkedBlogEntity $LIkedBlogEntityFromJson(Map<String, dynamic> json) {
  final LIkedBlogEntity lIkedBlogEntity = LIkedBlogEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    lIkedBlogEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    lIkedBlogEntity.message = message;
  }
  return lIkedBlogEntity;
}

Map<String, dynamic> $LIkedBlogEntityToJson(LIkedBlogEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension LIkedBlogEntityExtension on LIkedBlogEntity {
  LIkedBlogEntity copyWith({
    int? status,
    String? message,
  }) {
    return LIkedBlogEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}