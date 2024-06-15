import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_comment_classified_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_comment_classified_entity.g.dart';

@JsonSerializable()
class GetCommentClassifiedEntity {
	int? status = 0;
	List<GetCommentClassifiedData>? data = [];

	GetCommentClassifiedEntity();

	factory GetCommentClassifiedEntity.fromJson(Map<String, dynamic> json) => $GetCommentClassifiedEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetCommentClassifiedEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetCommentClassifiedData {
	int? id = 0;
	String? comment = '';
	String? createdate = '';
	int? userid = 0;
	String? name = '';
	String? userimage = '';
	@JSONField(name: "comments_replays")
	List<GetCommentClassifiedDataCommentsReplays>? commentsReplays = [];

	GetCommentClassifiedData();

	factory GetCommentClassifiedData.fromJson(Map<String, dynamic> json) => $GetCommentClassifiedDataFromJson(json);

	Map<String, dynamic> toJson() => $GetCommentClassifiedDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetCommentClassifiedDataCommentsReplays {
	int? id = 0;
	String? comment = '';
	String? createdate = '';
	int? userid = 0;
	String? name = '';
	String? userimage = '';

	GetCommentClassifiedDataCommentsReplays();

	factory GetCommentClassifiedDataCommentsReplays.fromJson(Map<String, dynamic> json) => $GetCommentClassifiedDataCommentsReplaysFromJson(json);

	Map<String, dynamic> toJson() => $GetCommentClassifiedDataCommentsReplaysToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}