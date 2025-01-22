import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/views_news_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/views_news_list_entity.g.dart';

@JsonSerializable()
class ViewsNewsListEntity {
	int? status = 0;
	List<ViewsNewsListData>? data = [];

	ViewsNewsListEntity();

	factory ViewsNewsListEntity.fromJson(Map<String, dynamic> json) => $ViewsNewsListEntityFromJson(json);

	Map<String, dynamic> toJson() => $ViewsNewsListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ViewsNewsListData {
	int? id = 0;
	int? nid = 0;
	@JSONField(name: "user_id")
	int? userId = 0;
	@JSONField(name: "created_at")
	String? createdAt = '';
	@JSONField(name: "user_data")
	ViewsNewsListDataUserData? userData;

	ViewsNewsListData();

	factory ViewsNewsListData.fromJson(Map<String, dynamic> json) => $ViewsNewsListDataFromJson(json);

	Map<String, dynamic> toJson() => $ViewsNewsListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ViewsNewsListDataUserData {
	String? name = '';
	String? userimage = '';
	int? id = 0;
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	ViewsNewsListDataUserData();

	factory ViewsNewsListDataUserData.fromJson(Map<String, dynamic> json) => $ViewsNewsListDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $ViewsNewsListDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}