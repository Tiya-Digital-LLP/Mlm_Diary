import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/post_like_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/post_like_list_entity.g.dart';

@JsonSerializable()
class PostLikeListEntity {
	int? status = 0;
	List<PostLikeListData>? data = [];

	PostLikeListEntity();

	factory PostLikeListEntity.fromJson(Map<String, dynamic> json) => $PostLikeListEntityFromJson(json);

	Map<String, dynamic> toJson() => $PostLikeListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class PostLikeListData {
	int? id = 0;
	int? pid = 0;
	int? userid = 0;
	String? addeddate = '';
	String? ipaddress = '';
	String? type = '';
	String? ntype = '';
	String? distype = '';
	@JSONField(name: 'user_data')
	PostLikeListDataUserData? userData;

	PostLikeListData();

	factory PostLikeListData.fromJson(Map<String, dynamic> json) => $PostLikeListDataFromJson(json);

	Map<String, dynamic> toJson() => $PostLikeListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class PostLikeListDataUserData {
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

	PostLikeListDataUserData();

	factory PostLikeListDataUserData.fromJson(Map<String, dynamic> json) => $PostLikeListDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $PostLikeListDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}