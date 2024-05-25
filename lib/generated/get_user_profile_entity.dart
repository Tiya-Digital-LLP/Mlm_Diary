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
	String? refrelid = '';
	dynamic treedirection;
	String? username = '';
	String? password = '';
	String? sex = '';
	String? name = '';
	String? email = '';
	dynamic phonecode;
	String? countrycode1 = '';
	String? mobile = '';
	dynamic birthdate;
	dynamic secondmail;
	dynamic secondphone;
	dynamic homemobile;
	dynamic address;
	String? country = '';
	String? state = '';
	String? city = '';
	dynamic dist;
	dynamic pincode;
	dynamic language;
	dynamic education;
	dynamic employment;
	dynamic userimage;
	String? joindate = '';
	String? ip = '';
	String? lastip = '';
	String? lastlogin = '';
	@JSONField(name: "login_location")
	String? loginLocation = '';
	String? completee = '';
	dynamic aboutyou;
	dynamic website;
	String? company = '';
	dynamic aboutbusi;
	dynamic pastwebsite;
	dynamic pastcompany;
	dynamic pastwebsite2;
	dynamic pastwebsite3;
	dynamic pastcompany2;
	dynamic pastcompany3;
	String? newregi = '';
	dynamic hearabout;
	dynamic keywordd;
	dynamic proupdate;
	dynamic aboutmlm;
	@JSONField(name: "inr_other")
	String? inrOther = '';
	@JSONField(name: "inr_adver")
	dynamic inrAdver;
	@JSONField(name: "inr_db")
	dynamic inrDb;
	@JSONField(name: "inr_soft")
	dynamic inrSoft;
	@JSONField(name: "send_art")
	dynamic sendArt;
	@JSONField(name: "send_news")
	dynamic sendNews;
	dynamic comments;
	dynamic callafter;
	dynamic yourref;
	@JSONField(name: "ref_name")
	dynamic refName;
	@JSONField(name: "ref_phone1")
	dynamic refPhone1;
	@JSONField(name: "ref_phone2")
	dynamic refPhone2;
	@JSONField(name: "ref_city")
	dynamic refCity;
	@JSONField(name: "ref_email")
	dynamic refEmail;
	@JSONField(name: "ref_company")
	dynamic refCompany;
	@JSONField(name: "ref_exx")
	dynamic refExx;
	dynamic lastcalldate;
	@JSONField(name: "callafter_recall")
	dynamic callafterRecall;
	dynamic staffid;
	dynamic staffdate;
	@JSONField(name: "newuser_fin")
	String? newuserFin = '';
	@JSONField(name: "olduse_fin")
	String? olduseFin = '';
	@JSONField(name: "recall_fin")
	String? recallFin = '';
	@JSONField(name: "inacive_fin")
	String? inaciveFin = '';
	@JSONField(name: "recallinac_fin")
	String? recallinacFin = '';
	@JSONField(name: "refreg_fin")
	String? refregFin = '';
	@JSONField(name: "recallref_fin")
	String? recallrefFin = '';
	@JSONField(name: "advert_fin")
	String? advertFin = '';
	@JSONField(name: "soft_fin")
	String? softFin = '';
	@JSONField(name: "db_fin")
	String? dbFin = '';
	@JSONField(name: "sndart_fin")
	String? sndartFin = '';
	@JSONField(name: "sndnews_fin")
	String? sndnewsFin = '';
	@JSONField(name: "other_fin")
	String? otherFin = '';
	@JSONField(name: "advert_mail_status")
	int? advertMailStatus = 0;
	@JSONField(name: "rss_urls")
	String? rssUrls = '';
	int? status = 0;
	int? points = 0;
	int? views = 0;
	String? terms = '';
	String? nlss = '';
	String? emailvarify = '';
	String? vemailcode = '';
	dynamic phonevarify;
	String? vphonecode = '';
	dynamic stepno;
	String? token = '';
	dynamic emailvarifycode;
	dynamic countrycode2;
	dynamic countrycode3;
	dynamic countrycode4;
	dynamic cemail;
	dynamic cphone;
	dynamic approve;
	@JSONField(name: "verify_email")
	dynamic verifyEmail;
	String? isphone = '';
	String? isemail = '';
	@JSONField(name: "verify_phone")
	dynamic verifyPhone;
	@JSONField(name: "anniversary_date")
	dynamic anniversaryDate;
	String? blockeduser = '';
	String? showindirctry = '';
	String? blockdate = '';
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
	String? proceeddate = '';
	@JSONField(name: "is_approved")
	int? isApproved = 0;

	GetUserProfileUserProfile();

	factory GetUserProfileUserProfile.fromJson(Map<String, dynamic> json) => $GetUserProfileUserProfileFromJson(json);

	Map<String, dynamic> toJson() => $GetUserProfileUserProfileToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}