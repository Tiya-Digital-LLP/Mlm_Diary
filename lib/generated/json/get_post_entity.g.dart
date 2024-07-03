import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_post_entity.dart';

GetPostEntity $GetPostEntityFromJson(Map<String, dynamic> json) {
  final GetPostEntity getPostEntity = GetPostEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getPostEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getPostEntity.message = message;
  }
  final List<GetPostData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<GetPostData>(e) as GetPostData).toList();
  if (data != null) {
    getPostEntity.data = data;
  }
  return getPostEntity;
}

Map<String, dynamic> $GetPostEntityToJson(GetPostEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetPostEntityExtension on GetPostEntity {
  GetPostEntity copyWith({
    int? status,
    String? message,
    List<GetPostData>? data,
  }) {
    return GetPostEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

GetPostData $GetPostDataFromJson(Map<String, dynamic> json) {
  final GetPostData getPostData = GetPostData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getPostData.id = id;
  }
  final String? comments = jsonConvert.convert<String>(json['comments']);
  if (comments != null) {
    getPostData.comments = comments;
  }
  final String? attachment = jsonConvert.convert<String>(json['attachment']);
  if (attachment != null) {
    getPostData.attachment = attachment;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getPostData.createdate = createdate;
  }
  final String? comtype = jsonConvert.convert<String>(json['comtype']);
  if (comtype != null) {
    getPostData.comtype = comtype;
  }
  final String? userid = jsonConvert.convert<String>(json['userid']);
  if (userid != null) {
    getPostData.userid = userid;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    getPostData.totallike = totallike;
  }
  final int? totalbookmark = jsonConvert.convert<int>(json['totalbookmark']);
  if (totalbookmark != null) {
    getPostData.totalbookmark = totalbookmark;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    getPostData.totalcomment = totalcomment;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    getPostData.likedByUser = likedByUser;
  }
  final bool? bookmarkedByUser = jsonConvert.convert<bool>(
      json['bookmarked_by_user']);
  if (bookmarkedByUser != null) {
    getPostData.bookmarkedByUser = bookmarkedByUser;
  }
  final GetPostDataUserData? userData = jsonConvert.convert<
      GetPostDataUserData>(json['user_data']);
  if (userData != null) {
    getPostData.userData = userData;
  }
  final String? attachmentPath = jsonConvert.convert<String>(
      json['attachment_path']);
  if (attachmentPath != null) {
    getPostData.attachmentPath = attachmentPath;
  }
  return getPostData;
}

Map<String, dynamic> $GetPostDataToJson(GetPostData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['comments'] = entity.comments;
  data['attachment'] = entity.attachment;
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

extension GetPostDataExtension on GetPostData {
  GetPostData copyWith({
    int? id,
    String? comments,
    String? attachment,
    String? createdate,
    String? comtype,
    String? userid,
    int? totallike,
    int? totalbookmark,
    int? totalcomment,
    bool? likedByUser,
    bool? bookmarkedByUser,
    GetPostDataUserData? userData,
    String? attachmentPath,
  }) {
    return GetPostData()
      ..id = id ?? this.id
      ..comments = comments ?? this.comments
      ..attachment = attachment ?? this.attachment
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

GetPostDataUserData $GetPostDataUserDataFromJson(Map<String, dynamic> json) {
  final GetPostDataUserData getPostDataUserData = GetPostDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getPostDataUserData.id = id;
  }
  final String? immlm = jsonConvert.convert<String>(json['immlm']);
  if (immlm != null) {
    getPostDataUserData.immlm = immlm;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    getPostDataUserData.username = username;
  }
  final String? password = jsonConvert.convert<String>(json['password']);
  if (password != null) {
    getPostDataUserData.password = password;
  }
  final String? sex = jsonConvert.convert<String>(json['sex']);
  if (sex != null) {
    getPostDataUserData.sex = sex;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getPostDataUserData.name = name;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    getPostDataUserData.email = email;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    getPostDataUserData.mobile = mobile;
  }
  final dynamic birthdate = json['birthdate'];
  if (birthdate != null) {
    getPostDataUserData.birthdate = birthdate;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    getPostDataUserData.address = address;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    getPostDataUserData.country = country;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    getPostDataUserData.state = state;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    getPostDataUserData.city = city;
  }
  final String? pincode = jsonConvert.convert<String>(json['pincode']);
  if (pincode != null) {
    getPostDataUserData.pincode = pincode;
  }
  final dynamic employment = json['employment'];
  if (employment != null) {
    getPostDataUserData.employment = employment;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getPostDataUserData.userimage = userimage;
  }
  final String? joindate = jsonConvert.convert<String>(json['joindate']);
  if (joindate != null) {
    getPostDataUserData.joindate = joindate;
  }
  final String? ip = jsonConvert.convert<String>(json['ip']);
  if (ip != null) {
    getPostDataUserData.ip = ip;
  }
  final String? lastip = jsonConvert.convert<String>(json['lastip']);
  if (lastip != null) {
    getPostDataUserData.lastip = lastip;
  }
  final String? lastlogin = jsonConvert.convert<String>(json['lastlogin']);
  if (lastlogin != null) {
    getPostDataUserData.lastlogin = lastlogin;
  }
  final String? aboutyou = jsonConvert.convert<String>(json['aboutyou']);
  if (aboutyou != null) {
    getPostDataUserData.aboutyou = aboutyou;
  }
  final dynamic website = json['website'];
  if (website != null) {
    getPostDataUserData.website = website;
  }
  final dynamic compWebsite = json['comp_website'];
  if (compWebsite != null) {
    getPostDataUserData.compWebsite = compWebsite;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    getPostDataUserData.company = company;
  }
  final String? newregi = jsonConvert.convert<String>(json['newregi']);
  if (newregi != null) {
    getPostDataUserData.newregi = newregi;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getPostDataUserData.status = status;
  }
  final int? points = jsonConvert.convert<int>(json['points']);
  if (points != null) {
    getPostDataUserData.points = points;
  }
  final int? views = jsonConvert.convert<int>(json['views']);
  if (views != null) {
    getPostDataUserData.views = views;
  }
  final String? emailvarify = jsonConvert.convert<String>(json['emailvarify']);
  if (emailvarify != null) {
    getPostDataUserData.emailvarify = emailvarify;
  }
  final String? vemailcode = jsonConvert.convert<String>(json['vemailcode']);
  if (vemailcode != null) {
    getPostDataUserData.vemailcode = vemailcode;
  }
  final String? vphonecode = jsonConvert.convert<String>(json['vphonecode']);
  if (vphonecode != null) {
    getPostDataUserData.vphonecode = vphonecode;
  }
  final dynamic stepno = json['stepno'];
  if (stepno != null) {
    getPostDataUserData.stepno = stepno;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    getPostDataUserData.token = token;
  }
  final dynamic approve = json['approve'];
  if (approve != null) {
    getPostDataUserData.approve = approve;
  }
  final dynamic verifyEmail = json['verify_email'];
  if (verifyEmail != null) {
    getPostDataUserData.verifyEmail = verifyEmail;
  }
  final String? blockeduser = jsonConvert.convert<String>(json['blockeduser']);
  if (blockeduser != null) {
    getPostDataUserData.blockeduser = blockeduser;
  }
  final String? showindirctry = jsonConvert.convert<String>(
      json['showindirctry']);
  if (showindirctry != null) {
    getPostDataUserData.showindirctry = showindirctry;
  }
  final dynamic blockdate = json['blockdate'];
  if (blockdate != null) {
    getPostDataUserData.blockdate = blockdate;
  }
  final String? plan = jsonConvert.convert<String>(json['plan']);
  if (plan != null) {
    getPostDataUserData.plan = plan;
  }
  final String? blocktype = jsonConvert.convert<String>(json['blocktype']);
  if (blocktype != null) {
    getPostDataUserData.blocktype = blocktype;
  }
  final int? paidno = jsonConvert.convert<int>(json['paidno']);
  if (paidno != null) {
    getPostDataUserData.paidno = paidno;
  }
  final String? isapprove = jsonConvert.convert<String>(json['isapprove']);
  if (isapprove != null) {
    getPostDataUserData.isapprove = isapprove;
  }
  final String? passtoken = jsonConvert.convert<String>(json['passtoken']);
  if (passtoken != null) {
    getPostDataUserData.passtoken = passtoken;
  }
  final dynamic tokendate = json['tokendate'];
  if (tokendate != null) {
    getPostDataUserData.tokendate = tokendate;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    getPostDataUserData.urlcomponent = urlcomponent;
  }
  final String? aboutcompany = jsonConvert.convert<String>(
      json['aboutcompany']);
  if (aboutcompany != null) {
    getPostDataUserData.aboutcompany = aboutcompany;
  }
  final dynamic fblink = json['fblink'];
  if (fblink != null) {
    getPostDataUserData.fblink = fblink;
  }
  final String? instalink = jsonConvert.convert<String>(json['instalink']);
  if (instalink != null) {
    getPostDataUserData.instalink = instalink;
  }
  final dynamic twiterlink = json['twiterlink'];
  if (twiterlink != null) {
    getPostDataUserData.twiterlink = twiterlink;
  }
  final dynamic lilink = json['lilink'];
  if (lilink != null) {
    getPostDataUserData.lilink = lilink;
  }
  final dynamic youlink = json['youlink'];
  if (youlink != null) {
    getPostDataUserData.youlink = youlink;
  }
  final dynamic wplink = json['wplink'];
  if (wplink != null) {
    getPostDataUserData.wplink = wplink;
  }
  final dynamic telink = json['telink'];
  if (telink != null) {
    getPostDataUserData.telink = telink;
  }
  final String? proceedstatus = jsonConvert.convert<String>(
      json['proceedstatus']);
  if (proceedstatus != null) {
    getPostDataUserData.proceedstatus = proceedstatus;
  }
  final String? device = jsonConvert.convert<String>(json['device']);
  if (device != null) {
    getPostDataUserData.device = device;
  }
  final String? platform = jsonConvert.convert<String>(json['platform']);
  if (platform != null) {
    getPostDataUserData.platform = platform;
  }
  final String? proceeddate = jsonConvert.convert<String>(json['proceeddate']);
  if (proceeddate != null) {
    getPostDataUserData.proceeddate = proceeddate;
  }
  final int? isApproved = jsonConvert.convert<int>(json['is_approved']);
  if (isApproved != null) {
    getPostDataUserData.isApproved = isApproved;
  }
  final String? countrycode1 = jsonConvert.convert<String>(
      json['countrycode1']);
  if (countrycode1 != null) {
    getPostDataUserData.countrycode1 = countrycode1;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getPostDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getPostDataUserData.imageThumPath = imageThumPath;
  }
  return getPostDataUserData;
}

Map<String, dynamic> $GetPostDataUserDataToJson(GetPostDataUserData entity) {
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
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension GetPostDataUserDataExtension on GetPostDataUserData {
  GetPostDataUserData copyWith({
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
    String? aboutyou,
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
    String? aboutcompany,
    dynamic fblink,
    String? instalink,
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
    String? imagePath,
    String? imageThumPath,
  }) {
    return GetPostDataUserData()
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
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}