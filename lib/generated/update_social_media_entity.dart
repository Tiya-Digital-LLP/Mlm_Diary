import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/update_social_media_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/update_social_media_entity.g.dart';

@JsonSerializable()
class UpdateSocialMediaEntity {
	int? result = 0;
	String? message = '';
	@JSONField(name: "user_profile")
	UpdateSocialMediaUserProfile? userProfile;

	UpdateSocialMediaEntity();

	factory UpdateSocialMediaEntity.fromJson(Map<String, dynamic> json) => $UpdateSocialMediaEntityFromJson(json);

	Map<String, dynamic> toJson() => $UpdateSocialMediaEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class UpdateSocialMediaUserProfile {
	int? id = 0;
	dynamic website;
	@JSONField(name: "comp_website")
	String? compWebsite = '';
	String? fblink = '';
	String? instalink = '';
	dynamic twiterlink;
	dynamic lilink;
	dynamic youlink;
	dynamic wplink;
	dynamic telink;

	UpdateSocialMediaUserProfile();

	factory UpdateSocialMediaUserProfile.fromJson(Map<String, dynamic> json) => $UpdateSocialMediaUserProfileFromJson(json);

	Map<String, dynamic> toJson() => $UpdateSocialMediaUserProfileToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}