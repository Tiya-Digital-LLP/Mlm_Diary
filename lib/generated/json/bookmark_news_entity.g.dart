import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/bookmark_news_entity.dart';

BookmarkNewsEntity $BookmarkNewsEntityFromJson(Map<String, dynamic> json) {
  final BookmarkNewsEntity bookmarkNewsEntity = BookmarkNewsEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    bookmarkNewsEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    bookmarkNewsEntity.message = message;
  }
  return bookmarkNewsEntity;
}

Map<String, dynamic> $BookmarkNewsEntityToJson(BookmarkNewsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension BookmarkNewsEntityExtension on BookmarkNewsEntity {
  BookmarkNewsEntity copyWith({
    int? status,
    String? message,
  }) {
    return BookmarkNewsEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}