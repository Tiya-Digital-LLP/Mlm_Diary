import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_user_post_comment_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_user_post_comment_entity.g.dart';

@JsonSerializable()
class GetUserPostCommentEntity {
	int? status = 0;
	List<GetUserPostCommentData>? data = [];

	GetUserPostCommentEntity();

	factory GetUserPostCommentEntity.fromJson(Map<String, dynamic> json) => $GetUserPostCommentEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetUserPostCommentEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserPostCommentData {
	int? id = 0;
	String? comment = '';
	String? createdate = '';
	String? userid = '';
	String? name = '';
	String? userimage = '';
	@JSONField(name: "comments_replays")
	List<GetUserPostCommentDataCommentsReplays>? commentsReplays = [];

	GetUserPostCommentData();

	factory GetUserPostCommentData.fromJson(Map<String, dynamic> json) => $GetUserPostCommentDataFromJson(json);

	Map<String, dynamic> toJson() => $GetUserPostCommentDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserPostCommentDataCommentsReplays {
	int? id = 0;
	String? comment = '';
	String? createdate = '';
	String? userid = '';
	String? name = '';
	String? userimage = '';

	GetUserPostCommentDataCommentsReplays();

	factory GetUserPostCommentDataCommentsReplays.fromJson(Map<String, dynamic> json) => $GetUserPostCommentDataCommentsReplaysFromJson(json);

	Map<String, dynamic> toJson() => $GetUserPostCommentDataCommentsReplaysToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}