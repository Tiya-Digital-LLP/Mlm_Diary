import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/view_post_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/view_post_list_entity.g.dart';

@JsonSerializable()
class ViewPostListEntity {
	int? status = 0;
	List<ViewPostListData>? data = [];

	ViewPostListEntity();

	factory ViewPostListEntity.fromJson(Map<String, dynamic> json) => $ViewPostListEntityFromJson(json);

	Map<String, dynamic> toJson() => $ViewPostListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ViewPostListData {
	int? id = 0;
	int? pid = 0;
	@JSONField(name: "user_id")
	int? userId = 0;
	@JSONField(name: "created_at")
	String? createdAt = '';
	@JSONField(name: "user_data")
	ViewPostListDataUserData? userData;

	ViewPostListData();

	factory ViewPostListData.fromJson(Map<String, dynamic> json) => $ViewPostListDataFromJson(json);

	Map<String, dynamic> toJson() => $ViewPostListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ViewPostListDataUserData {
	String? name = '';
	String? userimage = '';
	int? id = 0;
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	ViewPostListDataUserData();

	factory ViewPostListDataUserData.fromJson(Map<String, dynamic> json) => $ViewPostListDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $ViewPostListDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}