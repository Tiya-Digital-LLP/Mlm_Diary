import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_my_chat_detail_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_my_chat_detail_entity.g.dart';

@JsonSerializable()
class GetMyChatDetailEntity {
	GetMyChatDetailMychatoverview? mychatoverview;
	int? status = 0;
	String? message = '';
	@JSONField(name: "profile_pic")
	dynamic profilePic;

	GetMyChatDetailEntity();

	factory GetMyChatDetailEntity.fromJson(Map<String, dynamic> json) => $GetMyChatDetailEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetMyChatDetailEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMyChatDetailMychatoverview {
	@JSONField(name: "current_page")
	int? currentPage = 0;
	List<GetMyChatDetailMychatoverviewData>? data = [];
	@JSONField(name: "first_page_url")
	String? firstPageUrl = '';
	int? from = 0;
	@JSONField(name: "last_page")
	int? lastPage = 0;
	@JSONField(name: "last_page_url")
	String? lastPageUrl = '';
	List<GetMyChatDetailMychatoverviewLinks>? links = [];
	@JSONField(name: "next_page_url")
	dynamic nextPageUrl;
	String? path = '';
	@JSONField(name: "per_page")
	int? perPage = 0;
	@JSONField(name: "prev_page_url")
	dynamic prevPageUrl;
	int? to = 0;
	int? total = 0;

	GetMyChatDetailMychatoverview();

	factory GetMyChatDetailMychatoverview.fromJson(Map<String, dynamic> json) => $GetMyChatDetailMychatoverviewFromJson(json);

	Map<String, dynamic> toJson() => $GetMyChatDetailMychatoverviewToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMyChatDetailMychatoverviewData {
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

	GetMyChatDetailMychatoverviewData();

	factory GetMyChatDetailMychatoverviewData.fromJson(Map<String, dynamic> json) => $GetMyChatDetailMychatoverviewDataFromJson(json);

	Map<String, dynamic> toJson() => $GetMyChatDetailMychatoverviewDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMyChatDetailMychatoverviewLinks {
	String? url = '';
	String? label = '';
	bool? active = false;

	GetMyChatDetailMychatoverviewLinks();

	factory GetMyChatDetailMychatoverviewLinks.fromJson(Map<String, dynamic> json) => $GetMyChatDetailMychatoverviewLinksFromJson(json);

	Map<String, dynamic> toJson() => $GetMyChatDetailMychatoverviewLinksToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}