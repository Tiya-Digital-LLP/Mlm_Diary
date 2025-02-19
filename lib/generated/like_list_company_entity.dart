import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/like_list_company_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/like_list_company_entity.g.dart';

@JsonSerializable()
class LikeListCompanyEntity {
	int? status = 0;
	List<LikeListCompanyData>? data = [];

	LikeListCompanyEntity();

	factory LikeListCompanyEntity.fromJson(Map<String, dynamic> json) => $LikeListCompanyEntityFromJson(json);

	Map<String, dynamic> toJson() => $LikeListCompanyEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class LikeListCompanyData {
	int? id = 0;
	int? oid = 0;
	int? userid = 0;
	String? addeddate = '';
	String? ipaddress = '';
	String? type = '';
	String? ntype = '';
	String? distype = '';
	@JSONField(name: 'user_data')
	LikeListCompanyDataUserData? userData;

	LikeListCompanyData();

	factory LikeListCompanyData.fromJson(Map<String, dynamic> json) => $LikeListCompanyDataFromJson(json);

	Map<String, dynamic> toJson() => $LikeListCompanyDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class LikeListCompanyDataUserData {
	int? id = 0;
	String? name = '';
	String? userimage = '';
	String? immlm = '';
	String? city = '';
	String? state = '';
	String? country = '';
	@JSONField(name: 'image_path')
	String? imagePath = '';
	@JSONField(name: 'image_thum_path')
	String? imageThumPath = '';

	LikeListCompanyDataUserData();

	factory LikeListCompanyDataUserData.fromJson(Map<String, dynamic> json) => $LikeListCompanyDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $LikeListCompanyDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}