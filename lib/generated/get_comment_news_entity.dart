import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_comment_news_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_comment_news_entity.g.dart';

@JsonSerializable()
class GetCommentNewsEntity {
	int? status = 0;
	List<GetCommentNewsData>? data = [];

	GetCommentNewsEntity();

	factory GetCommentNewsEntity.fromJson(Map<String, dynamic> json) => $GetCommentNewsEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetCommentNewsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetCommentNewsData {
	int? id = 0;
	String? comment = '';
	String? createdate = '';
	int? userid = 0;
	String? name = '';
	String? userimage = '';
	@JSONField(name: "comments_replays")
	List<GetCommentNewsDataCommentsReplays>? commentsReplays = [];

	GetCommentNewsData();

	factory GetCommentNewsData.fromJson(Map<String, dynamic> json) => $GetCommentNewsDataFromJson(json);

	Map<String, dynamic> toJson() => $GetCommentNewsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetCommentNewsDataCommentsReplays {
	int? id = 0;
	String? comment = '';
	String? createdate = '';
	int? userid = 0;
	String? name = '';
	String? userimage = '';
	@JSONField(name: "comments_replays")
	List<GetCommentNewsDataCommentsReplaysCommentsReplays>? commentsReplays = [];

	GetCommentNewsDataCommentsReplays();

	factory GetCommentNewsDataCommentsReplays.fromJson(Map<String, dynamic> json) => $GetCommentNewsDataCommentsReplaysFromJson(json);

	Map<String, dynamic> toJson() => $GetCommentNewsDataCommentsReplaysToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetCommentNewsDataCommentsReplaysCommentsReplays {
	int? id = 0;
	String? comment = '';
	String? createdate = '';
	int? userid = 0;
	String? name = '';
	String? userimage = '';
	@JSONField(name: "comments_replays")
	List<dynamic>? commentsReplays = [];

	GetCommentNewsDataCommentsReplaysCommentsReplays();

	factory GetCommentNewsDataCommentsReplaysCommentsReplays.fromJson(Map<String, dynamic> json) => $GetCommentNewsDataCommentsReplaysCommentsReplaysFromJson(json);

	Map<String, dynamic> toJson() => $GetCommentNewsDataCommentsReplaysCommentsReplaysToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}