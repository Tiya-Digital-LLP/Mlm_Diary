import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/get_mlm_database_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/get_mlm_database_entity.g.dart';

@JsonSerializable()
class GetMlmDatabaseEntity {
	int? status = 0;
	String? message = '';
	List<GetMlmDatabaseData>? data = [];

	GetMlmDatabaseEntity();

	factory GetMlmDatabaseEntity.fromJson(Map<String, dynamic> json) => $GetMlmDatabaseEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetMlmDatabaseEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetMlmDatabaseData {
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
	dynamic aboutyou;
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
	dynamic token;
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
	@JSONField(name: "image_path")
	String? imagePath = '';
	@JSONField(name: "image_thum_path")
	String? imageThumPath = '';

	GetMlmDatabaseData();

	factory GetMlmDatabaseData.fromJson(Map<String, dynamic> json) => $GetMlmDatabaseDataFromJson(json);

	Map<String, dynamic> toJson() => $GetMlmDatabaseDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}