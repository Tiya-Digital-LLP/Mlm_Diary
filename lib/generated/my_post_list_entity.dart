import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/my_post_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/my_post_list_entity.g.dart';

@JsonSerializable()
class MyPostListEntity {
	int? status = 0;
	String? message = '';
	List<MyPostListData>? data = [];

	MyPostListEntity();

	factory MyPostListEntity.fromJson(Map<String, dynamic> json) => $MyPostListEntityFromJson(json);

	Map<String, dynamic> toJson() => $MyPostListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MyPostListData {
	int? id = 0;
	String? comments = '';
	String? attachment = '';
	int? pgcnt = 0;
	String? datemodified = '';
	String? createdate = '';
	String? comtype = '';
	String? userid = '';
	int? totallike = 0;
	int? totalbookmark = 0;
	int? totalcomment = 0;
	@JSONField(name: "liked_by_user")
	bool? likedByUser = false;
	@JSONField(name: "bookmarked_by_user")
	bool? bookmarkedByUser = false;
	@JSONField(name: "user_data")
	MyPostListDataUserData? userData;
	@JSONField(name: "attachment_path")
	String? attachmentPath = '';

	MyPostListData();

	factory MyPostListData.fromJson(Map<String, dynamic> json) => $MyPostListDataFromJson(json);

	Map<String, dynamic> toJson() => $MyPostListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MyPostListDataUserData {
	int? id = 0;
	String? name = '';
	String? userimage = '';
	String? email = '';
	String? mobile = '';
	String? countrycode1 = '';
	String? company = '';
	String? state = '';
	String? country = '';
	String? city = '';
	@JSONField(name: "full_address")
	String? fullAddress = '';
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	MyPostListDataUserData();

	factory MyPostListDataUserData.fromJson(Map<String, dynamic> json) => $MyPostListDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $MyPostListDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}