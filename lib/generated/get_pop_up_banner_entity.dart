import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_pop_up_banner_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_pop_up_banner_entity.g.dart';

@JsonSerializable()
class GetPopUpBannerEntity {
	String? status = '';
	List<GetPopUpBannerData>? data = [];

	GetPopUpBannerEntity();

	factory GetPopUpBannerEntity.fromJson(Map<String, dynamic> json) => $GetPopUpBannerEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetPopUpBannerEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetPopUpBannerData {
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

	GetPopUpBannerData();

	factory GetPopUpBannerData.fromJson(Map<String, dynamic> json) => $GetPopUpBannerDataFromJson(json);

	Map<String, dynamic> toJson() => $GetPopUpBannerDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}