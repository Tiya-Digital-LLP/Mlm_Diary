import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/save_company_entity.dart';

SaveCompanyEntity $SaveCompanyEntityFromJson(Map<String, dynamic> json) {
  final SaveCompanyEntity saveCompanyEntity = SaveCompanyEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    saveCompanyEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    saveCompanyEntity.message = message;
  }
  final String? apiToken = jsonConvert.convert<String>(json['api_token']);
  if (apiToken != null) {
    saveCompanyEntity.apiToken = apiToken;
  }
  final SaveCompanyUserData? userData = jsonConvert.convert<
      SaveCompanyUserData>(json['user_data']);
  if (userData != null) {
    saveCompanyEntity.userData = userData;
  }
  return saveCompanyEntity;
}

Map<String, dynamic> $SaveCompanyEntityToJson(SaveCompanyEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['api_token'] = entity.apiToken;
  data['user_data'] = entity.userData?.toJson();
  return data;
}

extension SaveCompanyEntityExtension on SaveCompanyEntity {
  SaveCompanyEntity copyWith({
    int? status,
    String? message,
    String? apiToken,
    SaveCompanyUserData? userData,
  }) {
    return SaveCompanyEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..apiToken = apiToken ?? this.apiToken
      ..userData = userData ?? this.userData;
  }
}

SaveCompanyUserData $SaveCompanyUserDataFromJson(Map<String, dynamic> json) {
  final SaveCompanyUserData saveCompanyUserData = SaveCompanyUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    saveCompanyUserData.id = id;
  }
  final String? sex = jsonConvert.convert<String>(json['sex']);
  if (sex != null) {
    saveCompanyUserData.sex = sex;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    saveCompanyUserData.company = company;
  }
  final String? plan = jsonConvert.convert<String>(json['plan']);
  if (plan != null) {
    saveCompanyUserData.plan = plan;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    saveCompanyUserData.address = address;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    saveCompanyUserData.city = city;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    saveCompanyUserData.state = state;
  }
  final String? pincode = jsonConvert.convert<String>(json['pincode']);
  if (pincode != null) {
    saveCompanyUserData.pincode = pincode;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    saveCompanyUserData.country = country;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    saveCompanyUserData.userimage = userimage;
  }
  return saveCompanyUserData;
}

Map<String, dynamic> $SaveCompanyUserDataToJson(SaveCompanyUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['sex'] = entity.sex;
  data['company'] = entity.company;
  data['plan'] = entity.plan;
  data['address'] = entity.address;
  data['city'] = entity.city;
  data['state'] = entity.state;
  data['pincode'] = entity.pincode;
  data['country'] = entity.country;
  data['userimage'] = entity.userimage;
  return data;
}

extension SaveCompanyUserDataExtension on SaveCompanyUserData {
  SaveCompanyUserData copyWith({
    int? id,
    String? sex,
    String? company,
    String? plan,
    String? address,
    String? city,
    String? state,
    String? pincode,
    String? country,
    String? userimage,
  }) {
    return SaveCompanyUserData()
      ..id = id ?? this.id
      ..sex = sex ?? this.sex
      ..company = company ?? this.company
      ..plan = plan ?? this.plan
      ..address = address ?? this.address
      ..city = city ?? this.city
      ..state = state ?? this.state
      ..pincode = pincode ?? this.pincode
      ..country = country ?? this.country
      ..userimage = userimage ?? this.userimage;
  }
}