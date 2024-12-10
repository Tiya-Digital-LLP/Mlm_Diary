import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/liked_news_entity.dart';

LikedNewsEntity $LikedNewsEntityFromJson(Map<String, dynamic> json) {
  final LikedNewsEntity likedNewsEntity = LikedNewsEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    likedNewsEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    likedNewsEntity.message = message;
  }
  return likedNewsEntity;
}

Map<String, dynamic> $LikedNewsEntityToJson(LikedNewsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension LikedNewsEntityExtension on LikedNewsEntity {
  LikedNewsEntity copyWith({
    int? status,
    String? message,
  }) {
    return LikedNewsEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}