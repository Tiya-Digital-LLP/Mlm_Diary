import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_views_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_views_entity.g.dart';

@JsonSerializable()
class GetViewsEntity {
	int? status = 0;
	String? message = '';
	List<GetViewsData>? data = [];

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
	dynamic website;
	@JSONField(name: 'comp_website')
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
	@JSONField(name: 'verify_email')
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
	String? twiterlink = '';
	String? lilink = '';
	String? youlink = '';
	String? wplink = '';
	String? telink = '';
	String? proceedstatus = '';
	String? device = '';
	String? platform = '';
	String? proceeddate = '';
	@JSONField(name: 'is_approved')
	int? isApproved = 0;
	String? countrycode1 = '';
	String? lat = '';
	String? lng = '';
	@JSONField(name: 'userimage_url')
	String? userimageUrl = '';

	GetViewsData();

	factory GetViewsData.fromJson(Map<String, dynamic> json) => $GetViewsDataFromJson(json);

	Map<String, dynamic> toJson() => $GetViewsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}