import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_admin_company_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_admin_company_entity.g.dart';

@JsonSerializable()
class GetAdminCompanyEntity {
	int? status = 0;
	List<GetAdminCompanyData>? data = [];

	GetAdminCompanyEntity();

	factory GetAdminCompanyEntity.fromJson(Map<String, dynamic> json) => $GetAdminCompanyEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetAdminCompanyEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetAdminCompanyData {
	int? id = 0;
	String? name = '';
	String? sname = '';
	String? location = '';
	String? plan = '';
	String? email = '';
	String? phone = '';
	String? website = '';
	String? fblink = '';
	String? inlink = '';
	String? twlink = '';
	String? liklink = '';
	String? youlink = '';
	String? image = '';
	String? description = '';
	String? urlcomponent = '';
	String? active = '';
	String? adddate = '';
	String? addby = '';
	String? savedraft = '';
	String? city = '';
	String? state = '';
	String? country = '';
	int? pgcnt = 0;
	@JSONField(name: "lastview_date")
	String? lastviewDate = '';
	@JSONField(name: "meta_title")
	String? metaTitle = '';
	@JSONField(name: "meta_des")
	String? metaDes = '';
	int? totallike = 0;
	int? totalbookmark = 0;
	@JSONField(name: "liked_by_user")
	bool? likedByUser = false;
	@JSONField(name: "bookmarked_by_user")
	bool? bookmarkedByUser = false;

	GetAdminCompanyData();

	factory GetAdminCompanyData.fromJson(Map<String, dynamic> json) => $GetAdminCompanyDataFromJson(json);

	Map<String, dynamic> toJson() => $GetAdminCompanyDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}