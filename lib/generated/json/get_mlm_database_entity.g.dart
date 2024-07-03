import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_mlm_database_entity.dart';

GetMlmDatabaseEntity $GetMlmDatabaseEntityFromJson(Map<String, dynamic> json) {
  final GetMlmDatabaseEntity getMlmDatabaseEntity = GetMlmDatabaseEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getMlmDatabaseEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getMlmDatabaseEntity.message = message;
  }
  final List<GetMlmDatabaseData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetMlmDatabaseData>(e) as GetMlmDatabaseData)
      .toList();
  if (data != null) {
    getMlmDatabaseEntity.data = data;
  }
  return getMlmDatabaseEntity;
}

Map<String, dynamic> $GetMlmDatabaseEntityToJson(GetMlmDatabaseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetMlmDatabaseEntityExtension on GetMlmDatabaseEntity {
  GetMlmDatabaseEntity copyWith({
    int? status,
    String? message,
    List<GetMlmDatabaseData>? data,
  }) {
    return GetMlmDatabaseEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

GetMlmDatabaseData $GetMlmDatabaseDataFromJson(Map<String, dynamic> json) {
  final GetMlmDatabaseData getMlmDatabaseData = GetMlmDatabaseData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getMlmDatabaseData.id = id;
  }
  final String? immlm = jsonConvert.convert<String>(json['immlm']);
  if (immlm != null) {
    getMlmDatabaseData.immlm = immlm;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    getMlmDatabaseData.username = username;
  }
  final String? password = jsonConvert.convert<String>(json['password']);
  if (password != null) {
    getMlmDatabaseData.password = password;
  }
  final String? sex = jsonConvert.convert<String>(json['sex']);
  if (sex != null) {
    getMlmDatabaseData.sex = sex;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getMlmDatabaseData.name = name;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    getMlmDatabaseData.email = email;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    getMlmDatabaseData.mobile = mobile;
  }
  final dynamic birthdate = json['birthdate'];
  if (birthdate != null) {
    getMlmDatabaseData.birthdate = birthdate;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    getMlmDatabaseData.address = address;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    getMlmDatabaseData.country = country;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    getMlmDatabaseData.state = state;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    getMlmDatabaseData.city = city;
  }
  final String? pincode = jsonConvert.convert<String>(json['pincode']);
  if (pincode != null) {
    getMlmDatabaseData.pincode = pincode;
  }
  final dynamic employment = json['employment'];
  if (employment != null) {
    getMlmDatabaseData.employment = employment;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getMlmDatabaseData.userimage = userimage;
  }
  final String? joindate = jsonConvert.convert<String>(json['joindate']);
  if (joindate != null) {
    getMlmDatabaseData.joindate = joindate;
  }
  final String? ip = jsonConvert.convert<String>(json['ip']);
  if (ip != null) {
    getMlmDatabaseData.ip = ip;
  }
  final String? lastip = jsonConvert.convert<String>(json['lastip']);
  if (lastip != null) {
    getMlmDatabaseData.lastip = lastip;
  }
  final String? lastlogin = jsonConvert.convert<String>(json['lastlogin']);
  if (lastlogin != null) {
    getMlmDatabaseData.lastlogin = lastlogin;
  }
  final dynamic aboutyou = json['aboutyou'];
  if (aboutyou != null) {
    getMlmDatabaseData.aboutyou = aboutyou;
  }
  final dynamic website = json['website'];
  if (website != null) {
    getMlmDatabaseData.website = website;
  }
  final dynamic compWebsite = json['comp_website'];
  if (compWebsite != null) {
    getMlmDatabaseData.compWebsite = compWebsite;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    getMlmDatabaseData.company = company;
  }
  final String? newregi = jsonConvert.convert<String>(json['newregi']);
  if (newregi != null) {
    getMlmDatabaseData.newregi = newregi;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getMlmDatabaseData.status = status;
  }
  final int? points = jsonConvert.convert<int>(json['points']);
  if (points != null) {
    getMlmDatabaseData.points = points;
  }
  final int? views = jsonConvert.convert<int>(json['views']);
  if (views != null) {
    getMlmDatabaseData.views = views;
  }
  final String? emailvarify = jsonConvert.convert<String>(json['emailvarify']);
  if (emailvarify != null) {
    getMlmDatabaseData.emailvarify = emailvarify;
  }
  final String? vemailcode = jsonConvert.convert<String>(json['vemailcode']);
  if (vemailcode != null) {
    getMlmDatabaseData.vemailcode = vemailcode;
  }
  final String? vphonecode = jsonConvert.convert<String>(json['vphonecode']);
  if (vphonecode != null) {
    getMlmDatabaseData.vphonecode = vphonecode;
  }
  final dynamic stepno = json['stepno'];
  if (stepno != null) {
    getMlmDatabaseData.stepno = stepno;
  }
  final dynamic token = json['token'];
  if (token != null) {
    getMlmDatabaseData.token = token;
  }
  final dynamic approve = json['approve'];
  if (approve != null) {
    getMlmDatabaseData.approve = approve;
  }
  final dynamic verifyEmail = json['verify_email'];
  if (verifyEmail != null) {
    getMlmDatabaseData.verifyEmail = verifyEmail;
  }
  final String? blockeduser = jsonConvert.convert<String>(json['blockeduser']);
  if (blockeduser != null) {
    getMlmDatabaseData.blockeduser = blockeduser;
  }
  final String? showindirctry = jsonConvert.convert<String>(
      json['showindirctry']);
  if (showindirctry != null) {
    getMlmDatabaseData.showindirctry = showindirctry;
  }
  final dynamic blockdate = json['blockdate'];
  if (blockdate != null) {
    getMlmDatabaseData.blockdate = blockdate;
  }
  final String? plan = jsonConvert.convert<String>(json['plan']);
  if (plan != null) {
    getMlmDatabaseData.plan = plan;
  }
  final String? blocktype = jsonConvert.convert<String>(json['blocktype']);
  if (blocktype != null) {
    getMlmDatabaseData.blocktype = blocktype;
  }
  final int? paidno = jsonConvert.convert<int>(json['paidno']);
  if (paidno != null) {
    getMlmDatabaseData.paidno = paidno;
  }
  final String? isapprove = jsonConvert.convert<String>(json['isapprove']);
  if (isapprove != null) {
    getMlmDatabaseData.isapprove = isapprove;
  }
  final String? passtoken = jsonConvert.convert<String>(json['passtoken']);
  if (passtoken != null) {
    getMlmDatabaseData.passtoken = passtoken;
  }
  final dynamic tokendate = json['tokendate'];
  if (tokendate != null) {
    getMlmDatabaseData.tokendate = tokendate;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    getMlmDatabaseData.urlcomponent = urlcomponent;
  }
  final dynamic aboutcompany = json['aboutcompany'];
  if (aboutcompany != null) {
    getMlmDatabaseData.aboutcompany = aboutcompany;
  }
  final dynamic fblink = json['fblink'];
  if (fblink != null) {
    getMlmDatabaseData.fblink = fblink;
  }
  final dynamic instalink = json['instalink'];
  if (instalink != null) {
    getMlmDatabaseData.instalink = instalink;
  }
  final dynamic twiterlink = json['twiterlink'];
  if (twiterlink != null) {
    getMlmDatabaseData.twiterlink = twiterlink;
  }
  final dynamic lilink = json['lilink'];
  if (lilink != null) {
    getMlmDatabaseData.lilink = lilink;
  }
  final dynamic youlink = json['youlink'];
  if (youlink != null) {
    getMlmDatabaseData.youlink = youlink;
  }
  final dynamic wplink = json['wplink'];
  if (wplink != null) {
    getMlmDatabaseData.wplink = wplink;
  }
  final dynamic telink = json['telink'];
  if (telink != null) {
    getMlmDatabaseData.telink = telink;
  }
  final String? proceedstatus = jsonConvert.convert<String>(
      json['proceedstatus']);
  if (proceedstatus != null) {
    getMlmDatabaseData.proceedstatus = proceedstatus;
  }
  final String? device = jsonConvert.convert<String>(json['device']);
  if (device != null) {
    getMlmDatabaseData.device = device;
  }
  final String? platform = jsonConvert.convert<String>(json['platform']);
  if (platform != null) {
    getMlmDatabaseData.platform = platform;
  }
  final String? proceeddate = jsonConvert.convert<String>(json['proceeddate']);
  if (proceeddate != null) {
    getMlmDatabaseData.proceeddate = proceeddate;
  }
  final int? isApproved = jsonConvert.convert<int>(json['is_approved']);
  if (isApproved != null) {
    getMlmDatabaseData.isApproved = isApproved;
  }
  final String? countrycode1 = jsonConvert.convert<String>(
      json['countrycode1']);
  if (countrycode1 != null) {
    getMlmDatabaseData.countrycode1 = countrycode1;
  }
  final bool? favStatus = jsonConvert.convert<bool>(json['fav_status']);
  if (favStatus != null) {
    getMlmDatabaseData.favStatus = favStatus;
  }
  final bool? followStatus = jsonConvert.convert<bool>(json['follow_status']);
  if (followStatus != null) {
    getMlmDatabaseData.followStatus = followStatus;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    getMlmDatabaseData.imageUrl = imageUrl;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getMlmDatabaseData.title = title;
  }
  final dynamic pgcnt = json['pgcnt'];
  if (pgcnt != null) {
    getMlmDatabaseData.pgcnt = pgcnt;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getMlmDatabaseData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getMlmDatabaseData.imageThumPath = imageThumPath;
  }
  return getMlmDatabaseData;
}

Map<String, dynamic> $GetMlmDatabaseDataToJson(GetMlmDatabaseData entity) {
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
  data['fav_status'] = entity.favStatus;
  data['follow_status'] = entity.followStatus;
  data['image_url'] = entity.imageUrl;
  data['title'] = entity.title;
  data['pgcnt'] = entity.pgcnt;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension GetMlmDatabaseDataExtension on GetMlmDatabaseData {
  GetMlmDatabaseData copyWith({
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
    dynamic token,
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
    String? proceeddate,
    int? isApproved,
    String? countrycode1,
    bool? favStatus,
    bool? followStatus,
    String? imageUrl,
    String? title,
    dynamic pgcnt,
    String? imagePath,
    String? imageThumPath,
  }) {
    return GetMlmDatabaseData()
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
      ..favStatus = favStatus ?? this.favStatus
      ..followStatus = followStatus ?? this.followStatus
      ..imageUrl = imageUrl ?? this.imageUrl
      ..title = title ?? this.title
      ..pgcnt = pgcnt ?? this.pgcnt
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}