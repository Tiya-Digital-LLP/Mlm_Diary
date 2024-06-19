import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_user_profile_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_user_profile_entity.g.dart';

@JsonSerializable()
class GetUserProfileEntity {
	int? result = 0;
	String? message = '';
	@JSONField(name: "user_profile")
	GetUserProfileUserProfile? userProfile;

	GetUserProfileEntity();

	factory GetUserProfileEntity.fromJson(Map<String, dynamic> json) => $GetUserProfileEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetUserProfileEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetUserProfileUserProfile {
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
	dynamic company;
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

	GetUserProfileUserProfile();

	factory GetUserProfileUserProfile.fromJson(Map<String, dynamic> json) => $GetUserProfileUserProfileFromJson(json);

	Map<String, dynamic> toJson() => $GetUserProfileUserProfileToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}