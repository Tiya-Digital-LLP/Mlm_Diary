import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/post_count_view_entity.dart';

PostCountViewEntity $PostCountViewEntityFromJson(Map<String, dynamic> json) {
  final PostCountViewEntity postCountViewEntity = PostCountViewEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    postCountViewEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    postCountViewEntity.message = message;
  }
  return postCountViewEntity;
}

Map<String, dynamic> $PostCountViewEntityToJson(PostCountViewEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension PostCountViewEntityExtension on PostCountViewEntity {
  PostCountViewEntity copyWith({
    int? status,
    String? message,
  }) {
    return PostCountViewEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}