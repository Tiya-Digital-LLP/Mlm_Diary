import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_video_list_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_video_list_entity.g.dart';

@JsonSerializable()
class GetVideoListEntity {
	int? status = 0;
	String? message = '';
	List<GetVideoListVideos>? videos = [];

	GetVideoListEntity();

	factory GetVideoListEntity.fromJson(Map<String, dynamic> json) => $GetVideoListEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetVideoListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetVideoListVideos {
	int? id = 0;
	String? title = '';
	String? category = '';
	String? subcategory = '';
	String? userid = '';
	String? image = '';
	String? caption = '';
	String? description = '';
	String? createdate = '';
	int? pgcnt = 0;
	dynamic datemodified;
	@JSONField(name: "is_bookmark")
	bool? isBookmark = false;

	GetVideoListVideos();

	factory GetVideoListVideos.fromJson(Map<String, dynamic> json) => $GetVideoListVideosFromJson(json);

	Map<String, dynamic> toJson() => $GetVideoListVideosToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}