import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/my_post_list_entity.dart';

MyPostListEntity $MyPostListEntityFromJson(Map<String, dynamic> json) {
  final MyPostListEntity myPostListEntity = MyPostListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    myPostListEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    myPostListEntity.message = message;
  }
  final List<MyPostListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<MyPostListData>(e) as MyPostListData)
      .toList();
  if (data != null) {
    myPostListEntity.data = data;
  }
  return myPostListEntity;
}

Map<String, dynamic> $MyPostListEntityToJson(MyPostListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension MyPostListEntityExtension on MyPostListEntity {
  MyPostListEntity copyWith({
    int? status,
    String? message,
    List<MyPostListData>? data,
  }) {
    return MyPostListEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

MyPostListData $MyPostListDataFromJson(Map<String, dynamic> json) {
  final MyPostListData myPostListData = MyPostListData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    myPostListData.id = id;
  }
  final String? comments = jsonConvert.convert<String>(json['comments']);
  if (comments != null) {
    myPostListData.comments = comments;
  }
  final String? attachment = jsonConvert.convert<String>(json['attachment']);
  if (attachment != null) {
    myPostListData.attachment = attachment;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    myPostListData.pgcnt = pgcnt;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    myPostListData.datemodified = datemodified;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    myPostListData.createdate = createdate;
  }
  final String? comtype = jsonConvert.convert<String>(json['comtype']);
  if (comtype != null) {
    myPostListData.comtype = comtype;
  }
  final String? userid = jsonConvert.convert<String>(json['userid']);
  if (userid != null) {
    myPostListData.userid = userid;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    myPostListData.totallike = totallike;
  }
  final int? totalbookmark = jsonConvert.convert<int>(json['totalbookmark']);
  if (totalbookmark != null) {
    myPostListData.totalbookmark = totalbookmark;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    myPostListData.totalcomment = totalcomment;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    myPostListData.likedByUser = likedByUser;
  }
  final bool? bookmarkedByUser = jsonConvert.convert<bool>(
      json['bookmarked_by_user']);
  if (bookmarkedByUser != null) {
    myPostListData.bookmarkedByUser = bookmarkedByUser;
  }
  final MyPostListDataUserData? userData = jsonConvert.convert<
      MyPostListDataUserData>(json['user_data']);
  if (userData != null) {
    myPostListData.userData = userData;
  }
  final String? attachmentPath = jsonConvert.convert<String>(
      json['attachment_path']);
  if (attachmentPath != null) {
    myPostListData.attachmentPath = attachmentPath;
  }
  return myPostListData;
}

Map<String, dynamic> $MyPostListDataToJson(MyPostListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['comments'] = entity.comments;
  data['attachment'] = entity.attachment;
  data['pgcnt'] = entity.pgcnt;
  data['datemodified'] = entity.datemodified;
  data['createdate'] = entity.createdate;
  data['comtype'] = entity.comtype;
  data['userid'] = entity.userid;
  data['totallike'] = entity.totallike;
  data['totalbookmark'] = entity.totalbookmark;
  data['totalcomment'] = entity.totalcomment;
  data['liked_by_user'] = entity.likedByUser;
  data['bookmarked_by_user'] = entity.bookmarkedByUser;
  data['user_data'] = entity.userData?.toJson();
  data['attachment_path'] = entity.attachmentPath;
  return data;
}

extension MyPostListDataExtension on MyPostListData {
  MyPostListData copyWith({
    int? id,
    String? comments,
    String? attachment,
    int? pgcnt,
    String? datemodified,
    String? createdate,
    String? comtype,
    String? userid,
    int? totallike,
    int? totalbookmark,
    int? totalcomment,
    bool? likedByUser,
    bool? bookmarkedByUser,
    MyPostListDataUserData? userData,
    String? attachmentPath,
  }) {
    return MyPostListData()
      ..id = id ?? this.id
      ..comments = comments ?? this.comments
      ..attachment = attachment ?? this.attachment
      ..pgcnt = pgcnt ?? this.pgcnt
      ..datemodified = datemodified ?? this.datemodified
      ..createdate = createdate ?? this.createdate
      ..comtype = comtype ?? this.comtype
      ..userid = userid ?? this.userid
      ..totallike = totallike ?? this.totallike
      ..totalbookmark = totalbookmark ?? this.totalbookmark
      ..totalcomment = totalcomment ?? this.totalcomment
      ..likedByUser = likedByUser ?? this.likedByUser
      ..bookmarkedByUser = bookmarkedByUser ?? this.bookmarkedByUser
      ..userData = userData ?? this.userData
      ..attachmentPath = attachmentPath ?? this.attachmentPath;
  }
}

MyPostListDataUserData $MyPostListDataUserDataFromJson(
    Map<String, dynamic> json) {
  final MyPostListDataUserData myPostListDataUserData = MyPostListDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    myPostListDataUserData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    myPostListDataUserData.name = name;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    myPostListDataUserData.userimage = userimage;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    myPostListDataUserData.email = email;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    myPostListDataUserData.mobile = mobile;
  }
  final String? countrycode1 = jsonConvert.convert<String>(
      json['countrycode1']);
  if (countrycode1 != null) {
    myPostListDataUserData.countrycode1 = countrycode1;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    myPostListDataUserData.company = company;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    myPostListDataUserData.state = state;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    myPostListDataUserData.country = country;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    myPostListDataUserData.city = city;
  }
  final String? fullAddress = jsonConvert.convert<String>(json['full_address']);
  if (fullAddress != null) {
    myPostListDataUserData.fullAddress = fullAddress;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    myPostListDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    myPostListDataUserData.imageThumPath = imageThumPath;
  }
  return myPostListDataUserData;
}

Map<String, dynamic> $MyPostListDataUserDataToJson(
    MyPostListDataUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['userimage'] = entity.userimage;
  data['email'] = entity.email;
  data['mobile'] = entity.mobile;
  data['countrycode1'] = entity.countrycode1;
  data['company'] = entity.company;
  data['state'] = entity.state;
  data['country'] = entity.country;
  data['city'] = entity.city;
  data['full_address'] = entity.fullAddress;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension MyPostListDataUserDataExtension on MyPostListDataUserData {
  MyPostListDataUserData copyWith({
    int? id,
    String? name,
    String? userimage,
    String? email,
    String? mobile,
    String? countrycode1,
    String? company,
    String? state,
    String? country,
    String? city,
    String? fullAddress,
    String? imagePath,
    String? imageThumPath,
  }) {
    return MyPostListDataUserData()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..userimage = userimage ?? this.userimage
      ..email = email ?? this.email
      ..mobile = mobile ?? this.mobile
      ..countrycode1 = countrycode1 ?? this.countrycode1
      ..company = company ?? this.company
      ..state = state ?? this.state
      ..country = country ?? this.country
      ..city = city ?? this.city
      ..fullAddress = fullAddress ?? this.fullAddress
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}