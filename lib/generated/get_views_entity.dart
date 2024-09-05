import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_views_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_views_entity.g.dart';

@JsonSerializable()
class GetViewsEntity {
	late int status;
	late String message;
	late List<GetViewsData> data;

	GetViewsEntity();

	factory GetViewsEntity.fromJson(Map<String, dynamic> json) => $GetViewsEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetViewsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetViewsData {
	late int id;
	late String immlm;
	late String username;
	late String password;
	late String sex;
	late String name;
	late String email;
	late String mobile;
	dynamic birthdate;
	late String address;
	late String country;
	late String state;
	late String city;
	late String pincode;
	dynamic employment;
	late String userimage;
	late String joindate;
	late String ip;
	late String lastip;
	late String lastlogin;
	dynamic aboutyou;
	dynamic website;
	@JSONField(name: "comp_website")
	dynamic compWebsite;
	late String company;
	late String newregi;
	late int status;
	late int points;
	late int views;
	late String emailvarify;
	late String vemailcode;
	late String vphonecode;
	dynamic stepno;
	late String token;
	dynamic approve;
	@JSONField(name: "verify_email")
	dynamic verifyEmail;
	late String blockeduser;
	late String showindirctry;
	dynamic blockdate;
	late String plan;
	late String blocktype;
	late int paidno;
	late String isapprove;
	late String passtoken;
	dynamic tokendate;
	late String urlcomponent;
	dynamic aboutcompany;
	dynamic fblink;
	dynamic instalink;
	dynamic twiterlink;
	dynamic lilink;
	dynamic youlink;
	dynamic wplink;
	dynamic telink;
	late String proceedstatus;
	late String device;
	late String platform;
	dynamic proceeddate;
	@JSONField(name: "is_approved")
	late int isApproved;
	late String countrycode1;
	dynamic lat;
	dynamic lng;
	@JSONField(name: "userimage_url")
	late String userimageUrl;

	GetViewsData();

	factory GetViewsData.fromJson(Map<String, dynamic> json) => $GetViewsDataFromJson(json);

	Map<String, dynamic> toJson() => $GetViewsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}