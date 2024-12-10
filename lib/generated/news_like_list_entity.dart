import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/news_like_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/news_like_list_entity.g.dart';

@JsonSerializable()
class NewsLikeListEntity {
	int? status = 0;
	List<NewsLikeListData>? data = [];

	NewsLikeListEntity();

	factory NewsLikeListEntity.fromJson(Map<String, dynamic> json) => $NewsLikeListEntityFromJson(json);

	Map<String, dynamic> toJson() => $NewsLikeListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NewsLikeListData {
	int? id = 0;
	int? nid = 0;
	int? userid = 0;
	String? addeddate = '';
	String? ipaddress = '';
	String? type = '';
	String? ntype = '';
	String? distype = '';
	@JSONField(name: "user_data")
	NewsLikeListDataUserData? userData;

	NewsLikeListData();

	factory NewsLikeListData.fromJson(Map<String, dynamic> json) => $NewsLikeListDataFromJson(json);

	Map<String, dynamic> toJson() => $NewsLikeListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NewsLikeListDataUserData {
	String? name = '';
	String? userimage = '';
	int? id = 0;
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	NewsLikeListDataUserData();

	factory NewsLikeListDataUserData.fromJson(Map<String, dynamic> json) => $NewsLikeListDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $NewsLikeListDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}