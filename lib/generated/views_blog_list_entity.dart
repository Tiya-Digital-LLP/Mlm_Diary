import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/views_blog_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/views_blog_list_entity.g.dart';

@JsonSerializable()
class ViewsBlogListEntity {
	int? status = 0;
	List<ViewsBlogListData>? data = [];

	ViewsBlogListEntity();

	factory ViewsBlogListEntity.fromJson(Map<String, dynamic> json) => $ViewsBlogListEntityFromJson(json);

	Map<String, dynamic> toJson() => $ViewsBlogListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ViewsBlogListData {
	int? id = 0;
	int? bid = 0;
	@JSONField(name: 'user_id')
	int? userId = 0;
	@JSONField(name: 'created_at')
	String? createdAt = '';
	@JSONField(name: 'user_data')
	ViewsBlogListDataUserData? userData;

	ViewsBlogListData();

	factory ViewsBlogListData.fromJson(Map<String, dynamic> json) => $ViewsBlogListDataFromJson(json);

	Map<String, dynamic> toJson() => $ViewsBlogListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ViewsBlogListDataUserData {
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

	ViewsBlogListDataUserData();

	factory ViewsBlogListDataUserData.fromJson(Map<String, dynamic> json) => $ViewsBlogListDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $ViewsBlogListDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}