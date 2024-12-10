import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/bookmark_company_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/bookmark_company_entity.g.dart';

@JsonSerializable()
class BookmarkCompanyEntity {
	int? status = 0;
	String? message = '';

	BookmarkCompanyEntity();

	factory BookmarkCompanyEntity.fromJson(Map<String, dynamic> json) => $BookmarkCompanyEntityFromJson(json);

	Map<String, dynamic> toJson() => $BookmarkCompanyEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}