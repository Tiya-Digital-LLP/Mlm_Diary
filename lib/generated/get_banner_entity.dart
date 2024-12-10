import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_banner_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_banner_entity.g.dart';

@JsonSerializable()
class GetBannerEntity {
	String? status = '';
	List<GetBannerData>? data = [];

	GetBannerEntity();

	factory GetBannerEntity.fromJson(Map<String, dynamic> json) => $GetBannerEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetBannerEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetBannerData {
	int? id = 0;
	String? title = '';
	String? weblink = '';
	String? sdate = '';
	String? edate = '';
	String? addby = '';
	@JSONField(name: "displayed_in")
	String? displayedIn = '';
	String? image = '';
	String? position = '';
	String? postpage = '';
	String? contact1 = '';
	String? contact2 = '';
	String? contact3 = '';
	String? content = '';
	dynamic createdate;
	int? view = 0;
	int? sequence = 0;
	int? clicks = 0;
	String? btype = '';

	GetBannerData();

	factory GetBannerData.fromJson(Map<String, dynamic> json) => $GetBannerDataFromJson(json);

	Map<String, dynamic> toJson() => $GetBannerDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}