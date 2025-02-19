import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/view_company_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/view_company_list_entity.g.dart';

@JsonSerializable()
class ViewCompanyListEntity {
	int? status = 0;
	List<ViewCompanyListData>? data = [];

	ViewCompanyListEntity();

	factory ViewCompanyListEntity.fromJson(Map<String, dynamic> json) => $ViewCompanyListEntityFromJson(json);

	Map<String, dynamic> toJson() => $ViewCompanyListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ViewCompanyListData {
	int? id = 0;
	int? cid = 0;
	@JSONField(name: 'user_id')
	int? userId = 0;
	@JSONField(name: 'created_at')
	String? createdAt = '';
	@JSONField(name: 'user_data')
	ViewCompanyListDataUserData? userData;

	ViewCompanyListData();

	factory ViewCompanyListData.fromJson(Map<String, dynamic> json) => $ViewCompanyListDataFromJson(json);

	Map<String, dynamic> toJson() => $ViewCompanyListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ViewCompanyListDataUserData {
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

	ViewCompanyListDataUserData();

	factory ViewCompanyListDataUserData.fromJson(Map<String, dynamic> json) => $ViewCompanyListDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $ViewCompanyListDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}