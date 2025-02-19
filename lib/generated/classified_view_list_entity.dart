import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/classified_view_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/classified_view_list_entity.g.dart';

@JsonSerializable()
class ClassifiedViewListEntity {
	int? status = 0;
	List<ClassifiedViewListData>? data = [];

	ClassifiedViewListEntity();

	factory ClassifiedViewListEntity.fromJson(Map<String, dynamic> json) => $ClassifiedViewListEntityFromJson(json);

	Map<String, dynamic> toJson() => $ClassifiedViewListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ClassifiedViewListData {
	int? id = 0;
	int? cid = 0;
	@JSONField(name: 'user_id')
	int? userId = 0;
	@JSONField(name: 'created_at')
	String? createdAt = '';
	@JSONField(name: 'user_data')
	ClassifiedViewListDataUserData? userData;

	ClassifiedViewListData();

	factory ClassifiedViewListData.fromJson(Map<String, dynamic> json) => $ClassifiedViewListDataFromJson(json);

	Map<String, dynamic> toJson() => $ClassifiedViewListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ClassifiedViewListDataUserData {
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

	ClassifiedViewListDataUserData();

	factory ClassifiedViewListDataUserData.fromJson(Map<String, dynamic> json) => $ClassifiedViewListDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $ClassifiedViewListDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}