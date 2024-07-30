import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_user_profile_entity.dart';

GetUserProfileEntity $GetUserProfileEntityFromJson(Map<String, dynamic> json) {
  final GetUserProfileEntity getUserProfileEntity = GetUserProfileEntity();
  final int? result = jsonConvert.convert<int>(json['result']);
  if (result != null) {
    getUserProfileEntity.result = result;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getUserProfileEntity.message = message;
  }
  final GetUserProfileUserProfile? userProfile = jsonConvert.convert<
      GetUserProfileUserProfile>(json['user_profile']);
  if (userProfile != null) {
    getUserProfileEntity.userProfile = userProfile;
  }
  return getUserProfileEntity;
}

Map<String, dynamic> $GetUserProfileEntityToJson(GetUserProfileEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result;
  data['message'] = entity.message;
  data['user_profile'] = entity.userProfile?.toJson();
  return data;
}

extension GetUserProfileEntityExtension on GetUserProfileEntity {
  GetUserProfileEntity copyWith({
    int? result,
    String? message,
    GetUserProfileUserProfile? userProfile,
  }) {
    return GetUserProfileEntity()
      ..result = result ?? this.result
      ..message = message ?? this.message
      ..userProfile = userProfile ?? this.userProfile;
  }
}

GetUserProfileUserProfile $GetUserProfileUserProfileFromJson(
    Map<String, dynamic> json) {
  final GetUserProfileUserProfile getUserProfileUserProfile = GetUserProfileUserProfile();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getUserProfileUserProfile.id = id;
  }
  final String? immlm = jsonConvert.convert<String>(json['immlm']);
  if (immlm != null) {
    getUserProfileUserProfile.immlm = immlm;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    getUserProfileUserProfile.username = username;
  }
  final String? password = jsonConvert.convert<String>(json['password']);
  if (password != null) {
    getUserProfileUserProfile.password = password;
  }
  final String? sex = jsonConvert.convert<String>(json['sex']);
  if (sex != null) {
    getUserProfileUserProfile.sex = sex;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getUserProfileUserProfile.name = name;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    getUserProfileUserProfile.email = email;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    getUserProfileUserProfile.mobile = mobile;
  }
  final dynamic birthdate = json['birthdate'];
  if (birthdate != null) {
    getUserProfileUserProfile.birthdate = birthdate;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    getUserProfileUserProfile.address = address;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    getUserProfileUserProfile.country = country;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    getUserProfileUserProfile.state = state;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    getUserProfileUserProfile.city = city;
  }
  final String? pincode = jsonConvert.convert<String>(json['pincode']);
  if (pincode != null) {
    getUserProfileUserProfile.pincode = pincode;
  }
  final dynamic employment = json['employment'];
  if (employment != null) {
    getUserProfileUserProfile.employment = employment;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getUserProfileUserProfile.userimage = userimage;
  }
  final String? joindate = jsonConvert.convert<String>(json['joindate']);
  if (joindate != null) {
    getUserProfileUserProfile.joindate = joindate;
  }
  final String? ip = jsonConvert.convert<String>(json['ip']);
  if (ip != null) {
    getUserProfileUserProfile.ip = ip;
  }
  final String? lastip = jsonConvert.convert<String>(json['lastip']);
  if (lastip != null) {
    getUserProfileUserProfile.lastip = lastip;
  }
  final String? lastlogin = jsonConvert.convert<String>(json['lastlogin']);
  if (lastlogin != null) {
    getUserProfileUserProfile.lastlogin = lastlogin;
  }
  final dynamic aboutyou = json['aboutyou'];
  if (aboutyou != null) {
    getUserProfileUserProfile.aboutyou = aboutyou;
  }
  final dynamic website = json['website'];
  if (website != null) {
    getUserProfileUserProfile.website = website;
  }
  final dynamic compWebsite = json['comp_website'];
  if (compWebsite != null) {
    getUserProfileUserProfile.compWebsite = compWebsite;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    getUserProfileUserProfile.company = company;
  }
  final String? newregi = jsonConvert.convert<String>(json['newregi']);
  if (newregi != null) {
    getUserProfileUserProfile.newregi = newregi;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getUserProfileUserProfile.status = status;
  }
  final int? points = jsonConvert.convert<int>(json['points']);
  if (points != null) {
    getUserProfileUserProfile.points = points;
  }
  final int? views = jsonConvert.convert<int>(json['views']);
  if (views != null) {
    getUserProfileUserProfile.views = views;
  }
  final String? emailvarify = jsonConvert.convert<String>(json['emailvarify']);
  if (emailvarify != null) {
    getUserProfileUserProfile.emailvarify = emailvarify;
  }
  final String? vemailcode = jsonConvert.convert<String>(json['vemailcode']);
  if (vemailcode != null) {
    getUserProfileUserProfile.vemailcode = vemailcode;
  }
  final String? vphonecode = jsonConvert.convert<String>(json['vphonecode']);
  if (vphonecode != null) {
    getUserProfileUserProfile.vphonecode = vphonecode;
  }
  final dynamic stepno = json['stepno'];
  if (stepno != null) {
    getUserProfileUserProfile.stepno = stepno;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    getUserProfileUserProfile.token = token;
  }
  final dynamic approve = json['approve'];
  if (approve != null) {
    getUserProfileUserProfile.approve = approve;
  }
  final dynamic verifyEmail = json['verify_email'];
  if (verifyEmail != null) {
    getUserProfileUserProfile.verifyEmail = verifyEmail;
  }
  final String? blockeduser = jsonConvert.convert<String>(json['blockeduser']);
  if (blockeduser != null) {
    getUserProfileUserProfile.blockeduser = blockeduser;
  }
  final String? showindirctry = jsonConvert.convert<String>(
      json['showindirctry']);
  if (showindirctry != null) {
    getUserProfileUserProfile.showindirctry = showindirctry;
  }
  final dynamic blockdate = json['blockdate'];
  if (blockdate != null) {
    getUserProfileUserProfile.blockdate = blockdate;
  }
  final String? plan = jsonConvert.convert<String>(json['plan']);
  if (plan != null) {
    getUserProfileUserProfile.plan = plan;
  }
  final String? blocktype = jsonConvert.convert<String>(json['blocktype']);
  if (blocktype != null) {
    getUserProfileUserProfile.blocktype = blocktype;
  }
  final int? paidno = jsonConvert.convert<int>(json['paidno']);
  if (paidno != null) {
    getUserProfileUserProfile.paidno = paidno;
  }
  final String? isapprove = jsonConvert.convert<String>(json['isapprove']);
  if (isapprove != null) {
    getUserProfileUserProfile.isapprove = isapprove;
  }
  final String? passtoken = jsonConvert.convert<String>(json['passtoken']);
  if (passtoken != null) {
    getUserProfileUserProfile.passtoken = passtoken;
  }
  final dynamic tokendate = json['tokendate'];
  if (tokendate != null) {
    getUserProfileUserProfile.tokendate = tokendate;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    getUserProfileUserProfile.urlcomponent = urlcomponent;
  }
  final dynamic aboutcompany = json['aboutcompany'];
  if (aboutcompany != null) {
    getUserProfileUserProfile.aboutcompany = aboutcompany;
  }
  final dynamic fblink = json['fblink'];
  if (fblink != null) {
    getUserProfileUserProfile.fblink = fblink;
  }
  final dynamic instalink = json['instalink'];
  if (instalink != null) {
    getUserProfileUserProfile.instalink = instalink;
  }
  final dynamic twiterlink = json['twiterlink'];
  if (twiterlink != null) {
    getUserProfileUserProfile.twiterlink = twiterlink;
  }
  final dynamic lilink = json['lilink'];
  if (lilink != null) {
    getUserProfileUserProfile.lilink = lilink;
  }
  final dynamic youlink = json['youlink'];
  if (youlink != null) {
    getUserProfileUserProfile.youlink = youlink;
  }
  final dynamic wplink = json['wplink'];
  if (wplink != null) {
    getUserProfileUserProfile.wplink = wplink;
  }
  final dynamic telink = json['telink'];
  if (telink != null) {
    getUserProfileUserProfile.telink = telink;
  }
  final String? proceedstatus = jsonConvert.convert<String>(
      json['proceedstatus']);
  if (proceedstatus != null) {
    getUserProfileUserProfile.proceedstatus = proceedstatus;
  }
  final String? device = jsonConvert.convert<String>(json['device']);
  if (device != null) {
    getUserProfileUserProfile.device = device;
  }
  final String? platform = jsonConvert.convert<String>(json['platform']);
  if (platform != null) {
    getUserProfileUserProfile.platform = platform;
  }
  final dynamic proceeddate = json['proceeddate'];
  if (proceeddate != null) {
    getUserProfileUserProfile.proceeddate = proceeddate;
  }
  final int? isApproved = jsonConvert.convert<int>(json['is_approved']);
  if (isApproved != null) {
    getUserProfileUserProfile.isApproved = isApproved;
  }
  final String? countrycode1 = jsonConvert.convert<String>(
      json['countrycode1']);
  if (countrycode1 != null) {
    getUserProfileUserProfile.countrycode1 = countrycode1;
  }
  final dynamic lat = json['lat'];
  if (lat != null) {
    getUserProfileUserProfile.lat = lat;
  }
  final dynamic lng = json['lng'];
  if (lng != null) {
    getUserProfileUserProfile.lng = lng;
  }
  final int? followersCount = jsonConvert.convert<int>(json['followers_count']);
  if (followersCount != null) {
    getUserProfileUserProfile.followersCount = followersCount;
  }
  final int? followingCount = jsonConvert.convert<int>(json['following_count']);
  if (followingCount != null) {
    getUserProfileUserProfile.followingCount = followingCount;
  }
  final int? totalPost = jsonConvert.convert<int>(json['total_post']);
  if (totalPost != null) {
    getUserProfileUserProfile.totalPost = totalPost;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getUserProfileUserProfile.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getUserProfileUserProfile.imageThumPath = imageThumPath;
  }
  return getUserProfileUserProfile;
}

Map<String, dynamic> $GetUserProfileUserProfileToJson(
    GetUserProfileUserProfile entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['immlm'] = entity.immlm;
  data['username'] = entity.username;
  data['password'] = entity.password;
  data['sex'] = entity.sex;
  data['name'] = entity.name;
  data['email'] = entity.email;
  data['mobile'] = entity.mobile;
  data['birthdate'] = entity.birthdate;
  data['address'] = entity.address;
  data['country'] = entity.country;
  data['state'] = entity.state;
  data['city'] = entity.city;
  data['pincode'] = entity.pincode;
  data['employment'] = entity.employment;
  data['userimage'] = entity.userimage;
  data['joindate'] = entity.joindate;
  data['ip'] = entity.ip;
  data['lastip'] = entity.lastip;
  data['lastlogin'] = entity.lastlogin;
  data['aboutyou'] = entity.aboutyou;
  data['website'] = entity.website;
  data['comp_website'] = entity.compWebsite;
  data['company'] = entity.company;
  data['newregi'] = entity.newregi;
  data['status'] = entity.status;
  data['points'] = entity.points;
  data['views'] = entity.views;
  data['emailvarify'] = entity.emailvarify;
  data['vemailcode'] = entity.vemailcode;
  data['vphonecode'] = entity.vphonecode;
  data['stepno'] = entity.stepno;
  data['token'] = entity.token;
  data['approve'] = entity.approve;
  data['verify_email'] = entity.verifyEmail;
  data['blockeduser'] = entity.blockeduser;
  data['showindirctry'] = entity.showindirctry;
  data['blockdate'] = entity.blockdate;
  data['plan'] = entity.plan;
  data['blocktype'] = entity.blocktype;
  data['paidno'] = entity.paidno;
  data['isapprove'] = entity.isapprove;
  data['passtoken'] = entity.passtoken;
  data['tokendate'] = entity.tokendate;
  data['urlcomponent'] = entity.urlcomponent;
  data['aboutcompany'] = entity.aboutcompany;
  data['fblink'] = entity.fblink;
  data['instalink'] = entity.instalink;
  data['twiterlink'] = entity.twiterlink;
  data['lilink'] = entity.lilink;
  data['youlink'] = entity.youlink;
  data['wplink'] = entity.wplink;
  data['telink'] = entity.telink;
  data['proceedstatus'] = entity.proceedstatus;
  data['device'] = entity.device;
  data['platform'] = entity.platform;
  data['proceeddate'] = entity.proceeddate;
  data['is_approved'] = entity.isApproved;
  data['countrycode1'] = entity.countrycode1;
  data['lat'] = entity.lat;
  data['lng'] = entity.lng;
  data['followers_count'] = entity.followersCount;
  data['following_count'] = entity.followingCount;
  data['total_post'] = entity.totalPost;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension GetUserProfileUserProfileExtension on GetUserProfileUserProfile {
  GetUserProfileUserProfile copyWith({
    int? id,
    String? immlm,
    String? username,
    String? password,
    String? sex,
    String? name,
    String? email,
    String? mobile,
    dynamic birthdate,
    String? address,
    String? country,
    String? state,
    String? city,
    String? pincode,
    dynamic employment,
    String? userimage,
    String? joindate,
    String? ip,
    String? lastip,
    String? lastlogin,
    dynamic aboutyou,
    dynamic website,
    dynamic compWebsite,
    String? company,
    String? newregi,
    int? status,
    int? points,
    int? views,
    String? emailvarify,
    String? vemailcode,
    String? vphonecode,
    dynamic stepno,
    String? token,
    dynamic approve,
    dynamic verifyEmail,
    String? blockeduser,
    String? showindirctry,
    dynamic blockdate,
    String? plan,
    String? blocktype,
    int? paidno,
    String? isapprove,
    String? passtoken,
    dynamic tokendate,
    String? urlcomponent,
    dynamic aboutcompany,
    dynamic fblink,
    dynamic instalink,
    dynamic twiterlink,
    dynamic lilink,
    dynamic youlink,
    dynamic wplink,
    dynamic telink,
    String? proceedstatus,
    String? device,
    String? platform,
    dynamic proceeddate,
    int? isApproved,
    String? countrycode1,
    dynamic lat,
    dynamic lng,
    int? followersCount,
    int? followingCount,
    int? totalPost,
    String? imagePath,
    String? imageThumPath,
  }) {
    return GetUserProfileUserProfile()
      ..id = id ?? this.id
      ..immlm = immlm ?? this.immlm
      ..username = username ?? this.username
      ..password = password ?? this.password
      ..sex = sex ?? this.sex
      ..name = name ?? this.name
      ..email = email ?? this.email
      ..mobile = mobile ?? this.mobile
      ..birthdate = birthdate ?? this.birthdate
      ..address = address ?? this.address
      ..country = country ?? this.country
      ..state = state ?? this.state
      ..city = city ?? this.city
      ..pincode = pincode ?? this.pincode
      ..employment = employment ?? this.employment
      ..userimage = userimage ?? this.userimage
      ..joindate = joindate ?? this.joindate
      ..ip = ip ?? this.ip
      ..lastip = lastip ?? this.lastip
      ..lastlogin = lastlogin ?? this.lastlogin
      ..aboutyou = aboutyou ?? this.aboutyou
      ..website = website ?? this.website
      ..compWebsite = compWebsite ?? this.compWebsite
      ..company = company ?? this.company
      ..newregi = newregi ?? this.newregi
      ..status = status ?? this.status
      ..points = points ?? this.points
      ..views = views ?? this.views
      ..emailvarify = emailvarify ?? this.emailvarify
      ..vemailcode = vemailcode ?? this.vemailcode
      ..vphonecode = vphonecode ?? this.vphonecode
      ..stepno = stepno ?? this.stepno
      ..token = token ?? this.token
      ..approve = approve ?? this.approve
      ..verifyEmail = verifyEmail ?? this.verifyEmail
      ..blockeduser = blockeduser ?? this.blockeduser
      ..showindirctry = showindirctry ?? this.showindirctry
      ..blockdate = blockdate ?? this.blockdate
      ..plan = plan ?? this.plan
      ..blocktype = blocktype ?? this.blocktype
      ..paidno = paidno ?? this.paidno
      ..isapprove = isapprove ?? this.isapprove
      ..passtoken = passtoken ?? this.passtoken
      ..tokendate = tokendate ?? this.tokendate
      ..urlcomponent = urlcomponent ?? this.urlcomponent
      ..aboutcompany = aboutcompany ?? this.aboutcompany
      ..fblink = fblink ?? this.fblink
      ..instalink = instalink ?? this.instalink
      ..twiterlink = twiterlink ?? this.twiterlink
      ..lilink = lilink ?? this.lilink
      ..youlink = youlink ?? this.youlink
      ..wplink = wplink ?? this.wplink
      ..telink = telink ?? this.telink
      ..proceedstatus = proceedstatus ?? this.proceedstatus
      ..device = device ?? this.device
      ..platform = platform ?? this.platform
      ..proceeddate = proceeddate ?? this.proceeddate
      ..isApproved = isApproved ?? this.isApproved
      ..countrycode1 = countrycode1 ?? this.countrycode1
      ..lat = lat ?? this.lat
      ..lng = lng ?? this.lng
      ..followersCount = followersCount ?? this.followersCount
      ..followingCount = followingCount ?? this.followingCount
      ..totalPost = totalPost ?? this.totalPost
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}