import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/post_detail_entity.dart';

PostDetailEntity $PostDetailEntityFromJson(Map<String, dynamic> json) {
  final PostDetailEntity postDetailEntity = PostDetailEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    postDetailEntity.status = status;
  }
  final PostDetailData? data = jsonConvert.convert<PostDetailData>(
      json['data']);
  if (data != null) {
    postDetailEntity.data = data;
  }
  return postDetailEntity;
}

Map<String, dynamic> $PostDetailEntityToJson(PostDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.toJson();
  return data;
}

extension PostDetailEntityExtension on PostDetailEntity {
  PostDetailEntity copyWith({
    int? status,
    PostDetailData? data,
  }) {
    return PostDetailEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

PostDetailData $PostDetailDataFromJson(Map<String, dynamic> json) {
  final PostDetailData postDetailData = PostDetailData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    postDetailData.id = id;
  }
  final String? comments = jsonConvert.convert<String>(json['comments']);
  if (comments != null) {
    postDetailData.comments = comments;
  }
  final String? attachment = jsonConvert.convert<String>(json['attachment']);
  if (attachment != null) {
    postDetailData.attachment = attachment;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    postDetailData.pgcnt = pgcnt;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    postDetailData.createdate = createdate;
  }
  final String? comtype = jsonConvert.convert<String>(json['comtype']);
  if (comtype != null) {
    postDetailData.comtype = comtype;
  }
  final String? userid = jsonConvert.convert<String>(json['userid']);
  if (userid != null) {
    postDetailData.userid = userid;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    postDetailData.totallike = totallike;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    postDetailData.totalcomment = totalcomment;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    postDetailData.likedByUser = likedByUser;
  }
  final bool? bookmarkedByUser = jsonConvert.convert<bool>(
      json['bookmarked_by_user']);
  if (bookmarkedByUser != null) {
    postDetailData.bookmarkedByUser = bookmarkedByUser;
  }
  final PostDetailDataUserData? userData = jsonConvert.convert<
      PostDetailDataUserData>(json['user_data']);
  if (userData != null) {
    postDetailData.userData = userData;
  }
  final String? attachmentPath = jsonConvert.convert<String>(
      json['attachment_path']);
  if (attachmentPath != null) {
    postDetailData.attachmentPath = attachmentPath;
  }
  return postDetailData;
}

Map<String, dynamic> $PostDetailDataToJson(PostDetailData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['comments'] = entity.comments;
  data['attachment'] = entity.attachment;
  data['pgcnt'] = entity.pgcnt;
  data['createdate'] = entity.createdate;
  data['comtype'] = entity.comtype;
  data['userid'] = entity.userid;
  data['totallike'] = entity.totallike;
  data['totalcomment'] = entity.totalcomment;
  data['liked_by_user'] = entity.likedByUser;
  data['bookmarked_by_user'] = entity.bookmarkedByUser;
  data['user_data'] = entity.userData?.toJson();
  data['attachment_path'] = entity.attachmentPath;
  return data;
}

extension PostDetailDataExtension on PostDetailData {
  PostDetailData copyWith({
    int? id,
    String? comments,
    String? attachment,
    int? pgcnt,
    String? createdate,
    String? comtype,
    String? userid,
    int? totallike,
    int? totalcomment,
    bool? likedByUser,
    bool? bookmarkedByUser,
    PostDetailDataUserData? userData,
    String? attachmentPath,
  }) {
    return PostDetailData()
      ..id = id ?? this.id
      ..comments = comments ?? this.comments
      ..attachment = attachment ?? this.attachment
      ..pgcnt = pgcnt ?? this.pgcnt
      ..createdate = createdate ?? this.createdate
      ..comtype = comtype ?? this.comtype
      ..userid = userid ?? this.userid
      ..totallike = totallike ?? this.totallike
      ..totalcomment = totalcomment ?? this.totalcomment
      ..likedByUser = likedByUser ?? this.likedByUser
      ..bookmarkedByUser = bookmarkedByUser ?? this.bookmarkedByUser
      ..userData = userData ?? this.userData
      ..attachmentPath = attachmentPath ?? this.attachmentPath;
  }
}

PostDetailDataUserData $PostDetailDataUserDataFromJson(
    Map<String, dynamic> json) {
  final PostDetailDataUserData postDetailDataUserData = PostDetailDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    postDetailDataUserData.id = id;
  }
  final String? immlm = jsonConvert.convert<String>(json['immlm']);
  if (immlm != null) {
    postDetailDataUserData.immlm = immlm;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    postDetailDataUserData.username = username;
  }
  final String? password = jsonConvert.convert<String>(json['password']);
  if (password != null) {
    postDetailDataUserData.password = password;
  }
  final String? sex = jsonConvert.convert<String>(json['sex']);
  if (sex != null) {
    postDetailDataUserData.sex = sex;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    postDetailDataUserData.name = name;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    postDetailDataUserData.email = email;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    postDetailDataUserData.mobile = mobile;
  }
  final String? birthdate = jsonConvert.convert<String>(json['birthdate']);
  if (birthdate != null) {
    postDetailDataUserData.birthdate = birthdate;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    postDetailDataUserData.address = address;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    postDetailDataUserData.country = country;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    postDetailDataUserData.state = state;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    postDetailDataUserData.city = city;
  }
  final String? pincode = jsonConvert.convert<String>(json['pincode']);
  if (pincode != null) {
    postDetailDataUserData.pincode = pincode;
  }
  final dynamic employment = json['employment'];
  if (employment != null) {
    postDetailDataUserData.employment = employment;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    postDetailDataUserData.userimage = userimage;
  }
  final String? joindate = jsonConvert.convert<String>(json['joindate']);
  if (joindate != null) {
    postDetailDataUserData.joindate = joindate;
  }
  final String? ip = jsonConvert.convert<String>(json['ip']);
  if (ip != null) {
    postDetailDataUserData.ip = ip;
  }
  final String? lastip = jsonConvert.convert<String>(json['lastip']);
  if (lastip != null) {
    postDetailDataUserData.lastip = lastip;
  }
  final String? lastlogin = jsonConvert.convert<String>(json['lastlogin']);
  if (lastlogin != null) {
    postDetailDataUserData.lastlogin = lastlogin;
  }
  final String? aboutyou = jsonConvert.convert<String>(json['aboutyou']);
  if (aboutyou != null) {
    postDetailDataUserData.aboutyou = aboutyou;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    postDetailDataUserData.website = website;
  }
  final String? compWebsite = jsonConvert.convert<String>(json['comp_website']);
  if (compWebsite != null) {
    postDetailDataUserData.compWebsite = compWebsite;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    postDetailDataUserData.company = company;
  }
  final String? newregi = jsonConvert.convert<String>(json['newregi']);
  if (newregi != null) {
    postDetailDataUserData.newregi = newregi;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    postDetailDataUserData.status = status;
  }
  final int? points = jsonConvert.convert<int>(json['points']);
  if (points != null) {
    postDetailDataUserData.points = points;
  }
  final int? views = jsonConvert.convert<int>(json['views']);
  if (views != null) {
    postDetailDataUserData.views = views;
  }
  final String? emailvarify = jsonConvert.convert<String>(json['emailvarify']);
  if (emailvarify != null) {
    postDetailDataUserData.emailvarify = emailvarify;
  }
  final String? vemailcode = jsonConvert.convert<String>(json['vemailcode']);
  if (vemailcode != null) {
    postDetailDataUserData.vemailcode = vemailcode;
  }
  final String? vphonecode = jsonConvert.convert<String>(json['vphonecode']);
  if (vphonecode != null) {
    postDetailDataUserData.vphonecode = vphonecode;
  }
  final dynamic stepno = json['stepno'];
  if (stepno != null) {
    postDetailDataUserData.stepno = stepno;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    postDetailDataUserData.token = token;
  }
  final dynamic approve = json['approve'];
  if (approve != null) {
    postDetailDataUserData.approve = approve;
  }
  final dynamic verifyEmail = json['verify_email'];
  if (verifyEmail != null) {
    postDetailDataUserData.verifyEmail = verifyEmail;
  }
  final String? blockeduser = jsonConvert.convert<String>(json['blockeduser']);
  if (blockeduser != null) {
    postDetailDataUserData.blockeduser = blockeduser;
  }
  final String? showindirctry = jsonConvert.convert<String>(
      json['showindirctry']);
  if (showindirctry != null) {
    postDetailDataUserData.showindirctry = showindirctry;
  }
  final dynamic blockdate = json['blockdate'];
  if (blockdate != null) {
    postDetailDataUserData.blockdate = blockdate;
  }
  final String? plan = jsonConvert.convert<String>(json['plan']);
  if (plan != null) {
    postDetailDataUserData.plan = plan;
  }
  final String? blocktype = jsonConvert.convert<String>(json['blocktype']);
  if (blocktype != null) {
    postDetailDataUserData.blocktype = blocktype;
  }
  final int? paidno = jsonConvert.convert<int>(json['paidno']);
  if (paidno != null) {
    postDetailDataUserData.paidno = paidno;
  }
  final String? isapprove = jsonConvert.convert<String>(json['isapprove']);
  if (isapprove != null) {
    postDetailDataUserData.isapprove = isapprove;
  }
  final String? passtoken = jsonConvert.convert<String>(json['passtoken']);
  if (passtoken != null) {
    postDetailDataUserData.passtoken = passtoken;
  }
  final dynamic tokendate = json['tokendate'];
  if (tokendate != null) {
    postDetailDataUserData.tokendate = tokendate;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    postDetailDataUserData.urlcomponent = urlcomponent;
  }
  final String? aboutcompany = jsonConvert.convert<String>(
      json['aboutcompany']);
  if (aboutcompany != null) {
    postDetailDataUserData.aboutcompany = aboutcompany;
  }
  final dynamic fblink = json['fblink'];
  if (fblink != null) {
    postDetailDataUserData.fblink = fblink;
  }
  final dynamic instalink = json['instalink'];
  if (instalink != null) {
    postDetailDataUserData.instalink = instalink;
  }
  final dynamic twiterlink = json['twiterlink'];
  if (twiterlink != null) {
    postDetailDataUserData.twiterlink = twiterlink;
  }
  final dynamic lilink = json['lilink'];
  if (lilink != null) {
    postDetailDataUserData.lilink = lilink;
  }
  final dynamic youlink = json['youlink'];
  if (youlink != null) {
    postDetailDataUserData.youlink = youlink;
  }
  final dynamic wplink = json['wplink'];
  if (wplink != null) {
    postDetailDataUserData.wplink = wplink;
  }
  final dynamic telink = json['telink'];
  if (telink != null) {
    postDetailDataUserData.telink = telink;
  }
  final String? proceedstatus = jsonConvert.convert<String>(
      json['proceedstatus']);
  if (proceedstatus != null) {
    postDetailDataUserData.proceedstatus = proceedstatus;
  }
  final String? device = jsonConvert.convert<String>(json['device']);
  if (device != null) {
    postDetailDataUserData.device = device;
  }
  final String? platform = jsonConvert.convert<String>(json['platform']);
  if (platform != null) {
    postDetailDataUserData.platform = platform;
  }
  final dynamic proceeddate = json['proceeddate'];
  if (proceeddate != null) {
    postDetailDataUserData.proceeddate = proceeddate;
  }
  final int? isApproved = jsonConvert.convert<int>(json['is_approved']);
  if (isApproved != null) {
    postDetailDataUserData.isApproved = isApproved;
  }
  final String? countrycode1 = jsonConvert.convert<String>(
      json['countrycode1']);
  if (countrycode1 != null) {
    postDetailDataUserData.countrycode1 = countrycode1;
  }
  final dynamic lat = json['lat'];
  if (lat != null) {
    postDetailDataUserData.lat = lat;
  }
  final dynamic lng = json['lng'];
  if (lng != null) {
    postDetailDataUserData.lng = lng;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    postDetailDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    postDetailDataUserData.imageThumPath = imageThumPath;
  }
  return postDetailDataUserData;
}

Map<String, dynamic> $PostDetailDataUserDataToJson(
    PostDetailDataUserData entity) {
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
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension PostDetailDataUserDataExtension on PostDetailDataUserData {
  PostDetailDataUserData copyWith({
    int? id,
    String? immlm,
    String? username,
    String? password,
    String? sex,
    String? name,
    String? email,
    String? mobile,
    String? birthdate,
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
    String? aboutyou,
    String? website,
    String? compWebsite,
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
    String? aboutcompany,
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
    String? imagePath,
    String? imageThumPath,
  }) {
    return PostDetailDataUserData()
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
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}