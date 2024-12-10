import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/update_user_profile_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/update_user_profile_entity.g.dart';

@JsonSerializable()
class UpdateUserProfileEntity {
	int? result = 0;
	String? message = '';
	@JSONField(name: "user_profile")
	UpdateUserProfileUserProfile? userProfile;

	UpdateUserProfileEntity();

	factory UpdateUserProfileEntity.fromJson(Map<String, dynamic> json) => $UpdateUserProfileEntityFromJson(json);

	Map<String, dynamic> toJson() => $UpdateUserProfileEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class UpdateUserProfileUserProfile {
	int? id = 0;
	String? sex = '';
	String? name = '';
	String? immlm = '';
	dynamic company;
	String? plan = '';
	String? address = '';
	String? city = '';
	String? state = '';
	String? pincode = '';
	String? country = '';
	String? userimage = '';

	UpdateUserProfileUserProfile();

	factory UpdateUserProfileUserProfile.fromJson(Map<String, dynamic> json) => $UpdateUserProfileUserProfileFromJson(json);

	Map<String, dynamic> toJson() => $UpdateUserProfileUserProfileToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}