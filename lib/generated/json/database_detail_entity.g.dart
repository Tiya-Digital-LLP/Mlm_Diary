import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/database_detail_entity.dart';

DatabaseDetailEntity $DatabaseDetailEntityFromJson(Map<String, dynamic> json) {
  final DatabaseDetailEntity databaseDetailEntity = DatabaseDetailEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    databaseDetailEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    databaseDetailEntity.message = message;
  }
  final DatabaseDetailData? data = jsonConvert.convert<DatabaseDetailData>(
      json['data']);
  if (data != null) {
    databaseDetailEntity.data = data;
  }
  return databaseDetailEntity;
}

Map<String, dynamic> $DatabaseDetailEntityToJson(DatabaseDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension DatabaseDetailEntityExtension on DatabaseDetailEntity {
  DatabaseDetailEntity copyWith({
    int? status,
    String? message,
    DatabaseDetailData? data,
  }) {
    return DatabaseDetailEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

DatabaseDetailData $DatabaseDetailDataFromJson(Map<String, dynamic> json) {
  final DatabaseDetailData databaseDetailData = DatabaseDetailData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    databaseDetailData.id = id;
  }
  final String? immlm = jsonConvert.convert<String>(json['immlm']);
  if (immlm != null) {
    databaseDetailData.immlm = immlm;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    databaseDetailData.username = username;
  }
  final String? password = jsonConvert.convert<String>(json['password']);
  if (password != null) {
    databaseDetailData.password = password;
  }
  final String? sex = jsonConvert.convert<String>(json['sex']);
  if (sex != null) {
    databaseDetailData.sex = sex;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    databaseDetailData.name = name;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    databaseDetailData.email = email;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    databaseDetailData.mobile = mobile;
  }
  final dynamic birthdate = json['birthdate'];
  if (birthdate != null) {
    databaseDetailData.birthdate = birthdate;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    databaseDetailData.address = address;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    databaseDetailData.country = country;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    databaseDetailData.state = state;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    databaseDetailData.city = city;
  }
  final String? pincode = jsonConvert.convert<String>(json['pincode']);
  if (pincode != null) {
    databaseDetailData.pincode = pincode;
  }
  final dynamic employment = json['employment'];
  if (employment != null) {
    databaseDetailData.employment = employment;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    databaseDetailData.userimage = userimage;
  }
  final String? joindate = jsonConvert.convert<String>(json['joindate']);
  if (joindate != null) {
    databaseDetailData.joindate = joindate;
  }
  final String? ip = jsonConvert.convert<String>(json['ip']);
  if (ip != null) {
    databaseDetailData.ip = ip;
  }
  final String? lastip = jsonConvert.convert<String>(json['lastip']);
  if (lastip != null) {
    databaseDetailData.lastip = lastip;
  }
  final String? lastlogin = jsonConvert.convert<String>(json['lastlogin']);
  if (lastlogin != null) {
    databaseDetailData.lastlogin = lastlogin;
  }
  final dynamic aboutyou = json['aboutyou'];
  if (aboutyou != null) {
    databaseDetailData.aboutyou = aboutyou;
  }
  final dynamic website = json['website'];
  if (website != null) {
    databaseDetailData.website = website;
  }
  final dynamic compWebsite = json['comp_website'];
  if (compWebsite != null) {
    databaseDetailData.compWebsite = compWebsite;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    databaseDetailData.company = company;
  }
  final String? newregi = jsonConvert.convert<String>(json['newregi']);
  if (newregi != null) {
    databaseDetailData.newregi = newregi;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    databaseDetailData.status = status;
  }
  final int? points = jsonConvert.convert<int>(json['points']);
  if (points != null) {
    databaseDetailData.points = points;
  }
  final int? views = jsonConvert.convert<int>(json['views']);
  if (views != null) {
    databaseDetailData.views = views;
  }
  final String? emailvarify = jsonConvert.convert<String>(json['emailvarify']);
  if (emailvarify != null) {
    databaseDetailData.emailvarify = emailvarify;
  }
  final String? vemailcode = jsonConvert.convert<String>(json['vemailcode']);
  if (vemailcode != null) {
    databaseDetailData.vemailcode = vemailcode;
  }
  final String? vphonecode = jsonConvert.convert<String>(json['vphonecode']);
  if (vphonecode != null) {
    databaseDetailData.vphonecode = vphonecode;
  }
  final dynamic stepno = json['stepno'];
  if (stepno != null) {
    databaseDetailData.stepno = stepno;
  }
  final dynamic token = json['token'];
  if (token != null) {
    databaseDetailData.token = token;
  }
  final dynamic approve = json['approve'];
  if (approve != null) {
    databaseDetailData.approve = approve;
  }
  final dynamic verifyEmail = json['verify_email'];
  if (verifyEmail != null) {
    databaseDetailData.verifyEmail = verifyEmail;
  }
  final String? blockeduser = jsonConvert.convert<String>(json['blockeduser']);
  if (blockeduser != null) {
    databaseDetailData.blockeduser = blockeduser;
  }
  final String? showindirctry = jsonConvert.convert<String>(
      json['showindirctry']);
  if (showindirctry != null) {
    databaseDetailData.showindirctry = showindirctry;
  }
  final dynamic blockdate = json['blockdate'];
  if (blockdate != null) {
    databaseDetailData.blockdate = blockdate;
  }
  final String? plan = jsonConvert.convert<String>(json['plan']);
  if (plan != null) {
    databaseDetailData.plan = plan;
  }
  final String? blocktype = jsonConvert.convert<String>(json['blocktype']);
  if (blocktype != null) {
    databaseDetailData.blocktype = blocktype;
  }
  final int? paidno = jsonConvert.convert<int>(json['paidno']);
  if (paidno != null) {
    databaseDetailData.paidno = paidno;
  }
  final String? isapprove = jsonConvert.convert<String>(json['isapprove']);
  if (isapprove != null) {
    databaseDetailData.isapprove = isapprove;
  }
  final String? passtoken = jsonConvert.convert<String>(json['passtoken']);
  if (passtoken != null) {
    databaseDetailData.passtoken = passtoken;
  }
  final dynamic tokendate = json['tokendate'];
  if (tokendate != null) {
    databaseDetailData.tokendate = tokendate;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    databaseDetailData.urlcomponent = urlcomponent;
  }
  final dynamic aboutcompany = json['aboutcompany'];
  if (aboutcompany != null) {
    databaseDetailData.aboutcompany = aboutcompany;
  }
  final dynamic fblink = json['fblink'];
  if (fblink != null) {
    databaseDetailData.fblink = fblink;
  }
  final dynamic instalink = json['instalink'];
  if (instalink != null) {
    databaseDetailData.instalink = instalink;
  }
  final dynamic twiterlink = json['twiterlink'];
  if (twiterlink != null) {
    databaseDetailData.twiterlink = twiterlink;
  }
  final dynamic lilink = json['lilink'];
  if (lilink != null) {
    databaseDetailData.lilink = lilink;
  }
  final dynamic youlink = json['youlink'];
  if (youlink != null) {
    databaseDetailData.youlink = youlink;
  }
  final dynamic wplink = json['wplink'];
  if (wplink != null) {
    databaseDetailData.wplink = wplink;
  }
  final dynamic telink = json['telink'];
  if (telink != null) {
    databaseDetailData.telink = telink;
  }
  final String? proceedstatus = jsonConvert.convert<String>(
      json['proceedstatus']);
  if (proceedstatus != null) {
    databaseDetailData.proceedstatus = proceedstatus;
  }
  final String? device = jsonConvert.convert<String>(json['device']);
  if (device != null) {
    databaseDetailData.device = device;
  }
  final String? platform = jsonConvert.convert<String>(json['platform']);
  if (platform != null) {
    databaseDetailData.platform = platform;
  }
  final String? proceeddate = jsonConvert.convert<String>(json['proceeddate']);
  if (proceeddate != null) {
    databaseDetailData.proceeddate = proceeddate;
  }
  final int? isApproved = jsonConvert.convert<int>(json['is_approved']);
  if (isApproved != null) {
    databaseDetailData.isApproved = isApproved;
  }
  final String? countrycode1 = jsonConvert.convert<String>(
      json['countrycode1']);
  if (countrycode1 != null) {
    databaseDetailData.countrycode1 = countrycode1;
  }
  final int? followersCount = jsonConvert.convert<int>(json['followers_count']);
  if (followersCount != null) {
    databaseDetailData.followersCount = followersCount;
  }
  final int? followingCount = jsonConvert.convert<int>(json['following_count']);
  if (followingCount != null) {
    databaseDetailData.followingCount = followingCount;
  }
  final bool? followStatus = jsonConvert.convert<bool>(json['follow_status']);
  if (followStatus != null) {
    databaseDetailData.followStatus = followStatus;
  }
  final bool? favStatus = jsonConvert.convert<bool>(json['fav_status']);
  if (favStatus != null) {
    databaseDetailData.favStatus = favStatus;
  }
  final dynamic chatId = json['chat_id'];
  if (chatId != null) {
    databaseDetailData.chatId = chatId;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    databaseDetailData.imageUrl = imageUrl;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    databaseDetailData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    databaseDetailData.imageThumPath = imageThumPath;
  }
  return databaseDetailData;
}

Map<String, dynamic> $DatabaseDetailDataToJson(DatabaseDetailData entity) {
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
  data['followers_count'] = entity.followersCount;
  data['following_count'] = entity.followingCount;
  data['follow_status'] = entity.followStatus;
  data['fav_status'] = entity.favStatus;
  data['chat_id'] = entity.chatId;
  data['image_url'] = entity.imageUrl;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension DatabaseDetailDataExtension on DatabaseDetailData {
  DatabaseDetailData copyWith({
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
    int? followersCount,
    int? followingCount,
    bool? followStatus,
    bool? favStatus,
    dynamic chatId,
    String? imageUrl,
    String? imagePath,
    String? imageThumPath,
  }) {
    return DatabaseDetailData()
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
      ..followersCount = followersCount ?? this.followersCount
      ..followingCount = followingCount ?? this.followingCount
      ..followStatus = followStatus ?? this.followStatus
      ..favStatus = favStatus ?? this.favStatus
      ..chatId = chatId ?? this.chatId
      ..imageUrl = imageUrl ?? this.imageUrl
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}