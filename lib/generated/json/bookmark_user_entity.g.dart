import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/bookmark_user_entity.dart';

BookmarkUserEntity $BookmarkUserEntityFromJson(Map<String, dynamic> json) {
  final BookmarkUserEntity bookmarkUserEntity = BookmarkUserEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    bookmarkUserEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    bookmarkUserEntity.message = message;
  }
  return bookmarkUserEntity;
}

Map<String, dynamic> $BookmarkUserEntityToJson(BookmarkUserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension BookmarkUserEntityExtension on BookmarkUserEntity {
  BookmarkUserEntity copyWith({
    int? status,
    String? message,
  }) {
    return BookmarkUserEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}