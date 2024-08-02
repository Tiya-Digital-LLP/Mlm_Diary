import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_post_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_post_entity.g.dart';

@JsonSerializable()
class GetPostEntity {
	int? status = 0;
	String? message = '';
	List<GetPostData>? data = [];

	GetPostEntity();

	factory GetPostEntity.fromJson(Map<String, dynamic> json) => $GetPostEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetPostEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetPostData {
	int? id = 0;
	String? comments = '';
	String? attachment = '';
	int? pgcnt = 0;
	String? createdate = '';
	String? comtype = '';
	String? userid = '';
	int? totallike = 0;
	int? totalbookmark = 0;
	int? totalcomment = 0;
	@JSONField(name: "liked_by_user")
	bool? likedByUser = false;
	@JSONField(name: "bookmarked_by_user")
	bool? bookmarkedByUser = false;
	@JSONField(name: "full_url")
	dynamic fullUrl;
	@JSONField(name: "user_data")
	GetPostDataUserData? userData;
	@JSONField(name: "attachment_path")
	dynamic attachmentPath;

	GetPostData();

	factory GetPostData.fromJson(Map<String, dynamic> json) => $GetPostDataFromJson(json);

	Map<String, dynamic> toJson() => $GetPostDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetPostDataUserData {
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
	dynamic pincode;
	dynamic employment;
	String? userimage = '';
	String? joindate = '';
	String? ip = '';
	String? lastip = '';
	String? lastlogin = '';
	String? aboutyou = '';
	String? website = '';
	@JSONField(name: "comp_website")
	dynamic compWebsite;
	String? company = '';
	String? newregi = '';
	int? status = 0;
	int? points = 0;
	int? views = 0;
	dynamic emailvarify;
	dynamic vemailcode;
	String? vphonecode = '';
	dynamic stepno;
	dynamic token;
	dynamic approve;
	@JSONField(name: "verify_email")
	String? verifyEmail = '';
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
	String? fblink = '';
	String? instalink = '';
	String? twiterlink = '';
	String? lilink = '';
	String? youlink = '';
	String? wplink = '';
	String? telink = '';
	String? proceedstatus = '';
	dynamic device;
	dynamic platform;
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

	GetPostDataUserData();

	factory GetPostDataUserData.fromJson(Map<String, dynamic> json) => $GetPostDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $GetPostDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}