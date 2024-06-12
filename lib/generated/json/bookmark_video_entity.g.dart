import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/bookmark_video_entity.dart';

BookmarkVideoEntity $BookmarkVideoEntityFromJson(Map<String, dynamic> json) {
  final BookmarkVideoEntity bookmarkVideoEntity = BookmarkVideoEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    bookmarkVideoEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    bookmarkVideoEntity.message = message;
  }
  return bookmarkVideoEntity;
}

Map<String, dynamic> $BookmarkVideoEntityToJson(BookmarkVideoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension BookmarkVideoEntityExtension on BookmarkVideoEntity {
  BookmarkVideoEntity copyWith({
    int? status,
    String? message,
  }) {
    return BookmarkVideoEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}