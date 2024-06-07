import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/post_bookmark_entity.dart';

PostBookmarkEntity $PostBookmarkEntityFromJson(Map<String, dynamic> json) {
  final PostBookmarkEntity postBookmarkEntity = PostBookmarkEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    postBookmarkEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    postBookmarkEntity.message = message;
  }
  return postBookmarkEntity;
}

Map<String, dynamic> $PostBookmarkEntityToJson(PostBookmarkEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension PostBookmarkEntityExtension on PostBookmarkEntity {
  PostBookmarkEntity copyWith({
    int? status,
    String? message,
  }) {
    return PostBookmarkEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}