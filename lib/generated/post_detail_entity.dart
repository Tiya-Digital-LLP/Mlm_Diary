import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/post_detail_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/post_detail_entity.g.dart';

@JsonSerializable()
class PostDetailEntity {
	int? status = 0;
	PostDetailData? data;

	PostDetailEntity();

	factory PostDetailEntity.fromJson(Map<String, dynamic> json) => $PostDetailEntityFromJson(json);

	Map<String, dynamic> toJson() => $PostDetailEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class PostDetailData {
	int? id = 0;
	String? comments = '';
	String? attachment = '';
	int? pgcnt = 0;
	String? createdate = '';
	String? comtype = '';
	String? userid = '';
	int? totallike = 0;
	int? totalcomment = 0;
	@JSONField(name: "liked_by_user")
	bool? likedByUser = false;
	@JSONField(name: "bookmarked_by_user")
	bool? bookmarkedByUser = false;
	@JSONField(name: "user_data")
	PostDetailDataUserData? userData;
	@JSONField(name: "attachment_path")
	String? attachmentPath = '';

	PostDetailData();

	factory PostDetailData.fromJson(Map<String, dynamic> json) => $PostDetailDataFromJson(json);

	Map<String, dynamic> toJson() => $PostDetailDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class PostDetailDataUserData {
	int? id = 0;
	String? immlm = '';
	String? username = '';
	String? password = '';
	String? sex = '';
	String? name = '';
	String? email = '';
	String? mobile = '';
	String? birthdate = '';
	String? address = '';
	String? country = '';
	String? state = '';
	String? city = '';
	String? pincode = '';
	dynamic employment;
	String? userimage = '';
	String? joindate = '';
	String? ip = '';
	String? lastip = '';
	String? lastlogin = '';
	String? aboutyou = '';
	String? website = '';
	@JSONField(name: "comp_website")
	String? compWebsite = '';
	String? company = '';
	String? newregi = '';
	int? status = 0;
	int? points = 0;
	int? views = 0;
	String? emailvarify = '';
	String? vemailcode = '';
	String? vphonecode = '';
	dynamic stepno;
	String? token = '';
	dynamic approve;
	@JSONField(name: "verify_email")
	dynamic verifyEmail;
	String? blockeduser = '';
	String? showindirctry = '';
	dynamic blockdate;
	String? plan = '';
	String? blocktype = '';
	int? paidno = 0;
	String? isapprove = '';
	String? passtoken = '';
	dynamic tokendate;
	String? urlcomponent = '';
	String? aboutcompany = '';
	dynamic fblink;
	dynamic instalink;
	dynamic twiterlink;
	dynamic lilink;
	dynamic youlink;
	dynamic wplink;
	dynamic telink;
	String? proceedstatus = '';
	String? device = '';
	String? platform = '';
	dynamic proceeddate;
	@JSONField(name: "is_approved")
	int? isApproved = 0;
	String? countrycode1 = '';
	dynamic lat;
	dynamic lng;
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	PostDetailDataUserData();

	factory PostDetailDataUserData.fromJson(Map<String, dynamic> json) => $PostDetailDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $PostDetailDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}