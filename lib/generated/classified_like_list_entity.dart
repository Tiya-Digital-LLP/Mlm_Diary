import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/classified_like_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/classified_like_list_entity.g.dart';

@JsonSerializable()
class ClassifiedLikeListEntity {
	int? status = 0;
	List<ClassifiedLikeListData>? data = [];

	ClassifiedLikeListEntity();

	factory ClassifiedLikeListEntity.fromJson(Map<String, dynamic> json) => $ClassifiedLikeListEntityFromJson(json);

	Map<String, dynamic> toJson() => $ClassifiedLikeListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ClassifiedLikeListData {
	int? id = 0;
	int? cid = 0;
	int? userid = 0;
	String? addeddate = '';
	dynamic ipaddress;
	String? type = '';
	String? ntype = '';
	dynamic distype;
	@JSONField(name: 'user_data')
	ClassifiedLikeListDataUserData? userData;

	ClassifiedLikeListData();

	factory ClassifiedLikeListData.fromJson(Map<String, dynamic> json) => $ClassifiedLikeListDataFromJson(json);

	Map<String, dynamic> toJson() => $ClassifiedLikeListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ClassifiedLikeListDataUserData {
	int? id = 0;
	String? name = '';
	dynamic userimage;
	String? immlm = '';
	dynamic city;
	dynamic state;
	dynamic country;
	@JSONField(name: 'image_path')
	dynamic imagePath;
	@JSONField(name: 'image_thum_path')
	dynamic imageThumPath;

	ClassifiedLikeListDataUserData();

	factory ClassifiedLikeListDataUserData.fromJson(Map<String, dynamic> json) => $ClassifiedLikeListDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $ClassifiedLikeListDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}