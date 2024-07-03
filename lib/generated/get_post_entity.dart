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
	@JSONField(name: "user_data")
	GetPostDataUserData? userData;
	@JSONField(name: "attachment_path")
	String? attachmentPath = '';

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
	dynamic birthdate;
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
	dynamic website;
	@JSONField(name: "comp_website")
	dynamic compWebsite;
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
	String? instalink = '';
	dynamic twiterlink;
	dynamic lilink;
	dynamic youlink;
	dynamic wplink;
	dynamic telink;
	String? proceedstatus = '';
	String? device = '';
	String? platform = '';
	String? proceeddate = '';
	@JSONField(name: "is_approved")
	int? isApproved = 0;
	String? countrycode1 = '';
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