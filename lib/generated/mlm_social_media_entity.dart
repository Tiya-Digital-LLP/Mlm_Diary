import 'package:mlmdiary/generated/json/base/json_field.dart';
import 'package:mlmdiary/generated/json/mlm_social_media_entity.g.dart';
import 'dart:convert';
export 'package:mlmdiary/generated/json/mlm_social_media_entity.g.dart';

@JsonSerializable()
class MlmSocialMediaEntity {
	int? status = 0;
	MlmSocialMediaSitesetting? sitesetting;

	MlmSocialMediaEntity();

	factory MlmSocialMediaEntity.fromJson(Map<String, dynamic> json) => $MlmSocialMediaEntityFromJson(json);

	Map<String, dynamic> toJson() => $MlmSocialMediaEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MlmSocialMediaSitesetting {
	int? id = 0;
	@JSONField(name: "facebook_link")
	String? facebookLink = '';
	String? whatsapp = '';
	@JSONField(name: "intagram_link")
	String? intagramLink = '';
	@JSONField(name: "linkedin_link")
	String? linkedinLink = '';
	@JSONField(name: "youtube_link")
	String? youtubeLink = '';
	@JSONField(name: "telegram_link")
	String? telegramLink = '';
	@JSONField(name: "twitter_link")
	String? twitterLink = '';

	MlmSocialMediaSitesetting();

	factory MlmSocialMediaSitesetting.fromJson(Map<String, dynamic> json) => $MlmSocialMediaSitesettingFromJson(json);

	Map<String, dynamic> toJson() => $MlmSocialMediaSitesettingToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}