import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/mutual_friends_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/mutual_friends_entity.g.dart';

@JsonSerializable()
class MutualFriendsEntity {
	int? status = 0;
	String? message = '';
	List<MutualFriendsData>? data = [];
	int? total = 0;
	@JSONField(name: "current_page")
	int? currentPage = 0;
	@JSONField(name: "per_page")
	int? perPage = 0;

	MutualFriendsEntity();

	factory MutualFriendsEntity.fromJson(Map<String, dynamic> json) => $MutualFriendsEntityFromJson(json);

	Map<String, dynamic> toJson() => $MutualFriendsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MutualFriendsData {
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
	String? employment = '';
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
	String? tokendate = '';
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
	String? proceeddate = '';
	@JSONField(name: "is_approved")
	int? isApproved = 0;
	String? countrycode1 = '';
	String? lat = '';
	String? lng = '';
	@JSONField(name: "image_url")
	String? imageUrl = '';
	String? title = '';
	int? pgcnt = 0;
	@JSONField(name: "is_following")
	bool? isFollowing = false;
	@JSONField(name: "followers_count")
	int? followersCount = 0;
	@JSONField(name: "following_count")
	int? followingCount = 0;
	@JSONField(name: "total_post")
	int? totalPost = 0;
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	MutualFriendsData();

	factory MutualFriendsData.fromJson(Map<String, dynamic> json) => $MutualFriendsDataFromJson(json);

	Map<String, dynamic> toJson() => $MutualFriendsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}