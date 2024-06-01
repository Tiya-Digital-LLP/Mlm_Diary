import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/bookmark_company_entity.dart';

BookmarkCompanyEntity $BookmarkCompanyEntityFromJson(
    Map<String, dynamic> json) {
  final BookmarkCompanyEntity bookmarkCompanyEntity = BookmarkCompanyEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    bookmarkCompanyEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    bookmarkCompanyEntity.message = message;
  }
  return bookmarkCompanyEntity;
}

Map<String, dynamic> $BookmarkCompanyEntityToJson(
    BookmarkCompanyEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  return data;
}

extension BookmarkCompanyEntityExtension on BookmarkCompanyEntity {
  BookmarkCompanyEntity copyWith({
    int? status,
    String? message,
  }) {
    return BookmarkCompanyEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message;
  }
}