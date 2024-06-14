import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_followers_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_followers_entity.g.dart';

@JsonSerializable()
class GetFollowersEntity {
	int? status = 0;
	String? message = '';
	List<GetFollowersData>? data = [];

	GetFollowersEntity();

	factory GetFollowersEntity.fromJson(Map<String, dynamic> json) => $GetFollowersEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetFollowersEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFollowersData {
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
	dynamic aboutcompany;
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
	String? proceeddate = '';
	@JSONField(name: "is_approved")
	int? isApproved = 0;
	String? countrycode1 = '';
	String? date = '';
	@JSONField(name: "image_url")
	String? imageUrl = '';
	@JSONField(name: "is_following")
	bool? isFollowing = false;

	GetFollowersData();

	factory GetFollowersData.fromJson(Map<String, dynamic> json) => $GetFollowersDataFromJson(json);

	Map<String, dynamic> toJson() => $GetFollowersDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}