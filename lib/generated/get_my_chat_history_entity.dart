import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_my_chat_history_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_my_chat_history_entity.g.dart';

@JsonSerializable()
class GetMyChatHistoryEntity {
	GetMyChatHistoryMychatoverview? mychatoverview;
	int? status = 0;
	String? message = '';

	GetMyChatHistoryEntity();

	factory GetMyChatHistoryEntity.fromJson(Map<String, dynamic> json) => $GetMyChatHistoryEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetMyChatHistoryEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMyChatHistoryMychatoverview {
	@JSONField(name: "current_page")
	int? currentPage = 0;
	List<GetMyChatHistoryMychatoverviewData>? data = [];
	@JSONField(name: "first_page_url")
	String? firstPageUrl = '';
	int? from = 0;
	@JSONField(name: "last_page")
	int? lastPage = 0;
	@JSONField(name: "last_page_url")
	String? lastPageUrl = '';
	List<GetMyChatHistoryMychatoverviewLinks>? links = [];
	@JSONField(name: "next_page_url")
	dynamic nextPageUrl;
	String? path = '';
	@JSONField(name: "per_page")
	int? perPage = 0;
	@JSONField(name: "prev_page_url")
	dynamic prevPageUrl;
	int? to = 0;
	int? total = 0;

	GetMyChatHistoryMychatoverview();

	factory GetMyChatHistoryMychatoverview.fromJson(Map<String, dynamic> json) => $GetMyChatHistoryMychatoverviewFromJson(json);

	Map<String, dynamic> toJson() => $GetMyChatHistoryMychatoverviewToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMyChatHistoryMychatoverviewData {
	int? id = 0;
	int? toid = 0;
	int? fromid = 0;
	String? msg = '';
	@JSONField(name: "chat_id")
	String? chatId = '';
	@JSONField(name: "read_status")
	int? readStatus = 0;
	@JSONField(name: "deleted_by_user_id")
	dynamic deletedByUserId;
	@JSONField(name: "created_at")
	String? createdAt = '';
	@JSONField(name: "updated_at")
	String? updatedAt = '';
	@JSONField(name: "deleted_at")
	dynamic deletedAt;
	@JSONField(name: "count_of_enread")
	int? countOfEnread = 0;
	@JSONField(name: "other_user_id")
	int? otherUserId = 0;
	String? username = '';
	dynamic userImage;

	GetMyChatHistoryMychatoverviewData();

	factory GetMyChatHistoryMychatoverviewData.fromJson(Map<String, dynamic> json) => $GetMyChatHistoryMychatoverviewDataFromJson(json);

	Map<String, dynamic> toJson() => $GetMyChatHistoryMychatoverviewDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMyChatHistoryMychatoverviewLinks {
	String? url = '';
	String? label = '';
	bool? active = false;

	GetMyChatHistoryMychatoverviewLinks();

	factory GetMyChatHistoryMychatoverviewLinks.fromJson(Map<String, dynamic> json) => $GetMyChatHistoryMychatoverviewLinksFromJson(json);

	Map<String, dynamic> toJson() => $GetMyChatHistoryMychatoverviewLinksToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}