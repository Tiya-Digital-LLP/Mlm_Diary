import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_blog_comment_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_blog_comment_entity.g.dart';

@JsonSerializable()
class GetBlogCommentEntity {
	int? status = 0;
	List<GetBlogCommentData>? data = [];

	GetBlogCommentEntity();

	factory GetBlogCommentEntity.fromJson(Map<String, dynamic> json) => $GetBlogCommentEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetBlogCommentEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetBlogCommentData {
	int? id = 0;
	String? comment = '';
	String? createdate = '';
	int? userid = 0;
	String? name = '';
	String? userimage = '';
	@JSONField(name: "comments_replays")
	List<GetBlogCommentDataCommentsReplays>? commentsReplays = [];

	GetBlogCommentData();

	factory GetBlogCommentData.fromJson(Map<String, dynamic> json) => $GetBlogCommentDataFromJson(json);

	Map<String, dynamic> toJson() => $GetBlogCommentDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetBlogCommentDataCommentsReplays {
	int? id = 0;
	String? comment = '';
	String? createdate = '';
	int? userid = 0;
	String? name = '';
	String? userimage = '';

	GetBlogCommentDataCommentsReplays();

	factory GetBlogCommentDataCommentsReplays.fromJson(Map<String, dynamic> json) => $GetBlogCommentDataCommentsReplaysFromJson(json);

	Map<String, dynamic> toJson() => $GetBlogCommentDataCommentsReplaysToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}