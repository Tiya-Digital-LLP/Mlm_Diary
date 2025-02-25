import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_views_entity.dart';

GetViewsEntity $GetViewsEntityFromJson(Map<String, dynamic> json) {
  final GetViewsEntity getViewsEntity = GetViewsEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getViewsEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    getViewsEntity.message = message;
  }
  final List<GetViewsData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<GetViewsData>(e) as GetViewsData).toList();
  if (data != null) {
    getViewsEntity.data = data;
  }
  return getViewsEntity;
}

Map<String, dynamic> $GetViewsEntityToJson(GetViewsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetViewsEntityExtension on GetViewsEntity {
  GetViewsEntity copyWith({
    int? status,
    String? message,
    List<GetViewsData>? data,
  }) {
    return GetViewsEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

GetViewsData $GetViewsDataFromJson(Map<String, dynamic> json) {
  final GetViewsData getViewsData = GetViewsData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getViewsData.id = id;
  }
  final String? immlm = jsonConvert.convert<String>(json['immlm']);
  if (immlm != null) {
    getViewsData.immlm = immlm;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    getViewsData.username = username;
  }
  final String? password = jsonConvert.convert<String>(json['password']);
  if (password != null) {
    getViewsData.password = password;
  }
  final String? sex = jsonConvert.convert<String>(json['sex']);
  if (sex != null) {
    getViewsData.sex = sex;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getViewsData.name = name;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    getViewsData.email = email;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    getViewsData.mobile = mobile;
  }
  final String? birthdate = jsonConvert.convert<String>(json['birthdate']);
  if (birthdate != null) {
    getViewsData.birthdate = birthdate;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    getViewsData.address = address;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    getViewsData.country = country;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    getViewsData.state = state;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    getViewsData.city = city;
  }
  final String? pincode = jsonConvert.convert<String>(json['pincode']);
  if (pincode != null) {
    getViewsData.pincode = pincode;
  }
  final dynamic employment = json['employment'];
  if (employment != null) {
    getViewsData.employment = employment;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getViewsData.userimage = userimage;
  }
  final String? joindate = jsonConvert.convert<String>(json['joindate']);
  if (joindate != null) {
    getViewsData.joindate = joindate;
  }
  final String? ip = jsonConvert.convert<String>(json['ip']);
  if (ip != null) {
    getViewsData.ip = ip;
  }
  final String? lastip = jsonConvert.convert<String>(json['lastip']);
  if (lastip != null) {
    getViewsData.lastip = lastip;
  }
  final String? lastlogin = jsonConvert.convert<String>(json['lastlogin']);
  if (lastlogin != null) {
    getViewsData.lastlogin = lastlogin;
  }
  final String? aboutyou = jsonConvert.convert<String>(json['aboutyou']);
  if (aboutyou != null) {
    getViewsData.aboutyou = aboutyou;
  }
  final dynamic website = json['website'];
  if (website != null) {
    getViewsData.website = website;
  }
  final dynamic compWebsite = json['comp_website'];
  if (compWebsite != null) {
    getViewsData.compWebsite = compWebsite;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    getViewsData.company = company;
  }
  final String? newregi = jsonConvert.convert<String>(json['newregi']);
  if (newregi != null) {
    getViewsData.newregi = newregi;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getViewsData.status = status;
  }
  final int? points = jsonConvert.convert<int>(json['points']);
  if (points != null) {
    getViewsData.points = points;
  }
  final int? views = jsonConvert.convert<int>(json['views']);
  if (views != null) {
    getViewsData.views = views;
  }
  final String? emailvarify = jsonConvert.convert<String>(json['emailvarify']);
  if (emailvarify != null) {
    getViewsData.emailvarify = emailvarify;
  }
  final String? vemailcode = jsonConvert.convert<String>(json['vemailcode']);
  if (vemailcode != null) {
    getViewsData.vemailcode = vemailcode;
  }
  final String? vphonecode = jsonConvert.convert<String>(json['vphonecode']);
  if (vphonecode != null) {
    getViewsData.vphonecode = vphonecode;
  }
  final dynamic stepno = json['stepno'];
  if (stepno != null) {
    getViewsData.stepno = stepno;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    getViewsData.token = token;
  }
  final dynamic approve = json['approve'];
  if (approve != null) {
    getViewsData.approve = approve;
  }
  final dynamic verifyEmail = json['verify_email'];
  if (verifyEmail != null) {
    getViewsData.verifyEmail = verifyEmail;
  }
  final String? blockeduser = jsonConvert.convert<String>(json['blockeduser']);
  if (blockeduser != null) {
    getViewsData.blockeduser = blockeduser;
  }
  final String? showindirctry = jsonConvert.convert<String>(
      json['showindirctry']);
  if (showindirctry != null) {
    getViewsData.showindirctry = showindirctry;
  }
  final dynamic blockdate = json['blockdate'];
  if (blockdate != null) {
    getViewsData.blockdate = blockdate;
  }
  final String? plan = jsonConvert.convert<String>(json['plan']);
  if (plan != null) {
    getViewsData.plan = plan;
  }
  final String? blocktype = jsonConvert.convert<String>(json['blocktype']);
  if (blocktype != null) {
    getViewsData.blocktype = blocktype;
  }
  final int? paidno = jsonConvert.convert<int>(json['paidno']);
  if (paidno != null) {
    getViewsData.paidno = paidno;
  }
  final String? isapprove = jsonConvert.convert<String>(json['isapprove']);
  if (isapprove != null) {
    getViewsData.isapprove = isapprove;
  }
  final String? passtoken = jsonConvert.convert<String>(json['passtoken']);
  if (passtoken != null) {
    getViewsData.passtoken = passtoken;
  }
  final String? tokendate = jsonConvert.convert<String>(json['tokendate']);
  if (tokendate != null) {
    getViewsData.tokendate = tokendate;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    getViewsData.urlcomponent = urlcomponent;
  }
  final String? aboutcompany = jsonConvert.convert<String>(
      json['aboutcompany']);
  if (aboutcompany != null) {
    getViewsData.aboutcompany = aboutcompany;
  }
  final String? fblink = jsonConvert.convert<String>(json['fblink']);
  if (fblink != null) {
    getViewsData.fblink = fblink;
  }
  final String? instalink = jsonConvert.convert<String>(json['instalink']);
  if (instalink != null) {
    getViewsData.instalink = instalink;
  }
  final String? twiterlink = jsonConvert.convert<String>(json['twiterlink']);
  if (twiterlink != null) {
    getViewsData.twiterlink = twiterlink;
  }
  final String? lilink = jsonConvert.convert<String>(json['lilink']);
  if (lilink != null) {
    getViewsData.lilink = lilink;
  }
  final String? youlink = jsonConvert.convert<String>(json['youlink']);
  if (youlink != null) {
    getViewsData.youlink = youlink;
  }
  final String? wplink = jsonConvert.convert<String>(json['wplink']);
  if (wplink != null) {
    getViewsData.wplink = wplink;
  }
  final String? telink = jsonConvert.convert<String>(json['telink']);
  if (telink != null) {
    getViewsData.telink = telink;
  }
  final String? proceedstatus = jsonConvert.convert<String>(
      json['proceedstatus']);
  if (proceedstatus != null) {
    getViewsData.proceedstatus = proceedstatus;
  }
  final String? device = jsonConvert.convert<String>(json['device']);
  if (device != null) {
    getViewsData.device = device;
  }
  final String? platform = jsonConvert.convert<String>(json['platform']);
  if (platform != null) {
    getViewsData.platform = platform;
  }
  final String? proceeddate = jsonConvert.convert<String>(json['proceeddate']);
  if (proceeddate != null) {
    getViewsData.proceeddate = proceeddate;
  }
  final int? isApproved = jsonConvert.convert<int>(json['is_approved']);
  if (isApproved != null) {
    getViewsData.isApproved = isApproved;
  }
  final String? countrycode1 = jsonConvert.convert<String>(
      json['countrycode1']);
  if (countrycode1 != null) {
    getViewsData.countrycode1 = countrycode1;
  }
  final String? lat = jsonConvert.convert<String>(json['lat']);
  if (lat != null) {
    getViewsData.lat = lat;
  }
  final String? lng = jsonConvert.convert<String>(json['lng']);
  if (lng != null) {
    getViewsData.lng = lng;
  }
  final String? userimageUrl = jsonConvert.convert<String>(
      json['userimage_url']);
  if (userimageUrl != null) {
    getViewsData.userimageUrl = userimageUrl;
  }
  return getViewsData;
}

Map<String, dynamic> $GetViewsDataToJson(GetViewsData entity) {
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
  data['userimage_url'] = entity.userimageUrl;
  return data;
}

extension GetViewsDataExtension on GetViewsData {
  GetViewsData copyWith({
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
    String? tokendate,
    String? urlcomponent,
    String? aboutcompany,
    String? fblink,
    String? instalink,
    String? twiterlink,
    String? lilink,
    String? youlink,
    String? wplink,
    String? telink,
    String? proceedstatus,
    String? device,
    String? platform,
    String? proceeddate,
    int? isApproved,
    String? countrycode1,
    String? lat,
    String? lng,
    String? userimageUrl,
  }) {
    return GetViewsData()
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
      ..userimageUrl = userimageUrl ?? this.userimageUrl;
  }
}