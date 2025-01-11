import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_blog_detail_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_blog_detail_entity.g.dart';

@JsonSerializable()
class GetBlogDetailEntity {
	int? status = 0;
	GetBlogDetailData? data;

	GetBlogDetailEntity();

	factory GetBlogDetailEntity.fromJson(Map<String, dynamic> json) => $GetBlogDetailEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetBlogDetailEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetBlogDetailData {
	int? id = 0;
	String? title = '';
	String? image = '';
	String? description = '';
	int? pgcnt = 0;
	String? createdate = '';
	String? datemodified = '';
	String? category = '';
	@JSONField(name: "user_id")
	int? userId = 0;
	String? subcategory = '';
	String? website = '';
	String? urlcomponent = '';
	int? totallike = 0;
	int? totalbookmark = 0;
	int? totalcomment = 0;
	@JSONField(name: "full_url")
	String? fullUrl = '';
	@JSONField(name: "image_url")
	String? imageUrl = '';
	@JSONField(name: "liked_by_user")
	bool? likedByUser = false;
	@JSONField(name: "bookmarked_by_user")
	bool? bookmarkedByUser = false;
	@JSONField(name: "user_data")
	GetBlogDetailDataUserData? userData;
	@JSONField(name: "image_path")
	String? imagePath = '';

	GetBlogDetailData();

	factory GetBlogDetailData.fromJson(Map<String, dynamic> json) => $GetBlogDetailDataFromJson(json);

	Map<String, dynamic> toJson() => $GetBlogDetailDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetBlogDetailDataUserData {
	int? id = 0;
	dynamic immlm;
	dynamic username;
	dynamic password;
	String? sex = '';
	String? name = '';
	String? email = '';
	dynamic mobile;
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
	dynamic lastlogin;
	dynamic aboutyou;
	dynamic website;
	@JSONField(name: "comp_website")
	String? compWebsite = '';
	String? company = '';
	String? newregi = '';
	int? status = 0;
	int? points = 0;
	int? views = 0;
	dynamic emailvarify;
	dynamic vemailcode;
	dynamic vphonecode;
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
	String? tokendate = '';
	String? urlcomponent = '';
	String? aboutcompany = '';
	String? fblink = '';
	String? instalink = '';
	dynamic twiterlink;
	dynamic lilink;
	dynamic youlink;
	dynamic wplink;
	dynamic telink;
	String? proceedstatus = '';
	dynamic device;
	dynamic platform;
	dynamic proceeddate;
	@JSONField(name: "is_approved")
	int? isApproved = 0;
	dynamic countrycode1;
	dynamic lat;
	dynamic lng;
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	GetBlogDetailDataUserData();

	factory GetBlogDetailDataUserData.fromJson(Map<String, dynamic> json) => $GetBlogDetailDataUserDataFromJson(json);

	Map<String, dynamic> toJson() => $GetBlogDetailDataUserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}