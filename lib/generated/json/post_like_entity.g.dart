import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/post_like_entity.dart';

PostLikeEntity $PostLikeEntityFromJson(Map<String, dynamic> json) {
  final PostLikeEntity postLikeEntity = PostLikeEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    postLikeEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    postLikeEntity.message = message;
  }
  return postLikeEntity;
}

Map<String, dynamic> $PostLikeEntityToJson(PostLikeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension PostLikeEntityExtension on PostLikeEntity {
  PostLikeEntity copyWith({
    int? status,
    String? message,
  }) {
    return PostLikeEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}