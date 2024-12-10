import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/blog_like_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/blog_like_list_entity.g.dart';

@JsonSerializable()
class BlogLikeListEntity {
	int? status = 0;
	List<BlogLikeListData>? data = [];

	BlogLikeListEntity();

	factory BlogLikeListEntity.fromJson(Map<String, dynamic> json) => $BlogLikeListEntityFromJson(json);

	Map<String, dynamic> toJson() => $BlogLikeListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BlogLikeListData {
	int? id = 0;
	int? bid = 0;
	int? userid = 0;
	String? addeddate = '';
	String? ipaddress = '';
	String? type = '';
	String? ntype = '';
	String? distype = '';
	@JSONField(name: "user_data")
	BlogLikeListDataUserData? userData;

	BlogLikeListData();

	factory BlogLikeListData.fromJson(Map<String, dynamic> json) => $BlogLikeListDataFromJson(json);

	Map<String, dynamic> toJson() => $BlogLikeListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BlogLikeListDataUserData {
	String? name = '';
	String? userimage = '';
	int? id = 0;
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	BlogLikeListDataUserData();

	factory BlogLikeListDataUserData.fromJson(Map<String, dynamic> json) => $BlogLikeListDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $BlogLikeListDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}