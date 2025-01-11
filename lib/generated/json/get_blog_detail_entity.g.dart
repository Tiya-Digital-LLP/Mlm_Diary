import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_blog_detail_entity.dart';

GetBlogDetailEntity $GetBlogDetailEntityFromJson(Map<String, dynamic> json) {
  final GetBlogDetailEntity getBlogDetailEntity = GetBlogDetailEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getBlogDetailEntity.status = status;
  }
  final GetBlogDetailData? data = jsonConvert.convert<GetBlogDetailData>(
      json['data']);
  if (data != null) {
    getBlogDetailEntity.data = data;
  }
  return getBlogDetailEntity;
}

Map<String, dynamic> $GetBlogDetailEntityToJson(GetBlogDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.toJson();
  return data;
}

extension GetBlogDetailEntityExtension on GetBlogDetailEntity {
  GetBlogDetailEntity copyWith({
    int? status,
    GetBlogDetailData? data,
  }) {
    return GetBlogDetailEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

GetBlogDetailData $GetBlogDetailDataFromJson(Map<String, dynamic> json) {
  final GetBlogDetailData getBlogDetailData = GetBlogDetailData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getBlogDetailData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getBlogDetailData.title = title;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    getBlogDetailData.image = image;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    getBlogDetailData.description = description;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    getBlogDetailData.pgcnt = pgcnt;
  }
  final String? createdate = jsonConvert.convert<String>(json['createdate']);
  if (createdate != null) {
    getBlogDetailData.createdate = createdate;
  }
  final String? datemodified = jsonConvert.convert<String>(
      json['datemodified']);
  if (datemodified != null) {
    getBlogDetailData.datemodified = datemodified;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    getBlogDetailData.category = category;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    getBlogDetailData.userId = userId;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    getBlogDetailData.subcategory = subcategory;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    getBlogDetailData.website = website;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    getBlogDetailData.urlcomponent = urlcomponent;
  }
  final int? totallike = jsonConvert.convert<int>(json['totallike']);
  if (totallike != null) {
    getBlogDetailData.totallike = totallike;
  }
  final int? totalbookmark = jsonConvert.convert<int>(json['totalbookmark']);
  if (totalbookmark != null) {
    getBlogDetailData.totalbookmark = totalbookmark;
  }
  final int? totalcomment = jsonConvert.convert<int>(json['totalcomment']);
  if (totalcomment != null) {
    getBlogDetailData.totalcomment = totalcomment;
  }
  final String? fullUrl = jsonConvert.convert<String>(json['full_url']);
  if (fullUrl != null) {
    getBlogDetailData.fullUrl = fullUrl;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    getBlogDetailData.imageUrl = imageUrl;
  }
  final bool? likedByUser = jsonConvert.convert<bool>(json['liked_by_user']);
  if (likedByUser != null) {
    getBlogDetailData.likedByUser = likedByUser;
  }
  final bool? bookmarkedByUser = jsonConvert.convert<bool>(
      json['bookmarked_by_user']);
  if (bookmarkedByUser != null) {
    getBlogDetailData.bookmarkedByUser = bookmarkedByUser;
  }
  final GetBlogDetailDataUserData? userData = jsonConvert.convert<
      GetBlogDetailDataUserData>(json['user_data']);
  if (userData != null) {
    getBlogDetailData.userData = userData;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getBlogDetailData.imagePath = imagePath;
  }
  return getBlogDetailData;
}

Map<String, dynamic> $GetBlogDetailDataToJson(GetBlogDetailData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['image'] = entity.image;
  data['description'] = entity.description;
  data['pgcnt'] = entity.pgcnt;
  data['createdate'] = entity.createdate;
  data['datemodified'] = entity.datemodified;
  data['category'] = entity.category;
  data['user_id'] = entity.userId;
  data['subcategory'] = entity.subcategory;
  data['website'] = entity.website;
  data['urlcomponent'] = entity.urlcomponent;
  data['totallike'] = entity.totallike;
  data['totalbookmark'] = entity.totalbookmark;
  data['totalcomment'] = entity.totalcomment;
  data['full_url'] = entity.fullUrl;
  data['image_url'] = entity.imageUrl;
  data['liked_by_user'] = entity.likedByUser;
  data['bookmarked_by_user'] = entity.bookmarkedByUser;
  data['user_data'] = entity.userData?.toJson();
  data['image_path'] = entity.imagePath;
  return data;
}

extension GetBlogDetailDataExtension on GetBlogDetailData {
  GetBlogDetailData copyWith({
    int? id,
    String? title,
    String? image,
    String? description,
    int? pgcnt,
    String? createdate,
    String? datemodified,
    String? category,
    int? userId,
    String? subcategory,
    String? website,
    String? urlcomponent,
    int? totallike,
    int? totalbookmark,
    int? totalcomment,
    String? fullUrl,
    String? imageUrl,
    bool? likedByUser,
    bool? bookmarkedByUser,
    GetBlogDetailDataUserData? userData,
    String? imagePath,
  }) {
    return GetBlogDetailData()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..image = image ?? this.image
      ..description = description ?? this.description
      ..pgcnt = pgcnt ?? this.pgcnt
      ..createdate = createdate ?? this.createdate
      ..datemodified = datemodified ?? this.datemodified
      ..category = category ?? this.category
      ..userId = userId ?? this.userId
      ..subcategory = subcategory ?? this.subcategory
      ..website = website ?? this.website
      ..urlcomponent = urlcomponent ?? this.urlcomponent
      ..totallike = totallike ?? this.totallike
      ..totalbookmark = totalbookmark ?? this.totalbookmark
      ..totalcomment = totalcomment ?? this.totalcomment
      ..fullUrl = fullUrl ?? this.fullUrl
      ..imageUrl = imageUrl ?? this.imageUrl
      ..likedByUser = likedByUser ?? this.likedByUser
      ..bookmarkedByUser = bookmarkedByUser ?? this.bookmarkedByUser
      ..userData = userData ?? this.userData
      ..imagePath = imagePath ?? this.imagePath;
  }
}

GetBlogDetailDataUserData $GetBlogDetailDataUserDataFromJson(
    Map<String, dynamic> json) {
  final GetBlogDetailDataUserData getBlogDetailDataUserData = GetBlogDetailDataUserData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getBlogDetailDataUserData.id = id;
  }
  final dynamic immlm = json['immlm'];
  if (immlm != null) {
    getBlogDetailDataUserData.immlm = immlm;
  }
  final dynamic username = json['username'];
  if (username != null) {
    getBlogDetailDataUserData.username = username;
  }
  final dynamic password = json['password'];
  if (password != null) {
    getBlogDetailDataUserData.password = password;
  }
  final String? sex = jsonConvert.convert<String>(json['sex']);
  if (sex != null) {
    getBlogDetailDataUserData.sex = sex;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getBlogDetailDataUserData.name = name;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    getBlogDetailDataUserData.email = email;
  }
  final dynamic mobile = json['mobile'];
  if (mobile != null) {
    getBlogDetailDataUserData.mobile = mobile;
  }
  final dynamic birthdate = json['birthdate'];
  if (birthdate != null) {
    getBlogDetailDataUserData.birthdate = birthdate;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    getBlogDetailDataUserData.address = address;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    getBlogDetailDataUserData.country = country;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    getBlogDetailDataUserData.state = state;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    getBlogDetailDataUserData.city = city;
  }
  final String? pincode = jsonConvert.convert<String>(json['pincode']);
  if (pincode != null) {
    getBlogDetailDataUserData.pincode = pincode;
  }
  final dynamic employment = json['employment'];
  if (employment != null) {
    getBlogDetailDataUserData.employment = employment;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    getBlogDetailDataUserData.userimage = userimage;
  }
  final String? joindate = jsonConvert.convert<String>(json['joindate']);
  if (joindate != null) {
    getBlogDetailDataUserData.joindate = joindate;
  }
  final String? ip = jsonConvert.convert<String>(json['ip']);
  if (ip != null) {
    getBlogDetailDataUserData.ip = ip;
  }
  final String? lastip = jsonConvert.convert<String>(json['lastip']);
  if (lastip != null) {
    getBlogDetailDataUserData.lastip = lastip;
  }
  final dynamic lastlogin = json['lastlogin'];
  if (lastlogin != null) {
    getBlogDetailDataUserData.lastlogin = lastlogin;
  }
  final dynamic aboutyou = json['aboutyou'];
  if (aboutyou != null) {
    getBlogDetailDataUserData.aboutyou = aboutyou;
  }
  final dynamic website = json['website'];
  if (website != null) {
    getBlogDetailDataUserData.website = website;
  }
  final String? compWebsite = jsonConvert.convert<String>(json['comp_website']);
  if (compWebsite != null) {
    getBlogDetailDataUserData.compWebsite = compWebsite;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    getBlogDetailDataUserData.company = company;
  }
  final String? newregi = jsonConvert.convert<String>(json['newregi']);
  if (newregi != null) {
    getBlogDetailDataUserData.newregi = newregi;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    getBlogDetailDataUserData.status = status;
  }
  final int? points = jsonConvert.convert<int>(json['points']);
  if (points != null) {
    getBlogDetailDataUserData.points = points;
  }
  final int? views = jsonConvert.convert<int>(json['views']);
  if (views != null) {
    getBlogDetailDataUserData.views = views;
  }
  final dynamic emailvarify = json['emailvarify'];
  if (emailvarify != null) {
    getBlogDetailDataUserData.emailvarify = emailvarify;
  }
  final dynamic vemailcode = json['vemailcode'];
  if (vemailcode != null) {
    getBlogDetailDataUserData.vemailcode = vemailcode;
  }
  final dynamic vphonecode = json['vphonecode'];
  if (vphonecode != null) {
    getBlogDetailDataUserData.vphonecode = vphonecode;
  }
  final dynamic stepno = json['stepno'];
  if (stepno != null) {
    getBlogDetailDataUserData.stepno = stepno;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    getBlogDetailDataUserData.token = token;
  }
  final dynamic approve = json['approve'];
  if (approve != null) {
    getBlogDetailDataUserData.approve = approve;
  }
  final dynamic verifyEmail = json['verify_email'];
  if (verifyEmail != null) {
    getBlogDetailDataUserData.verifyEmail = verifyEmail;
  }
  final String? blockeduser = jsonConvert.convert<String>(json['blockeduser']);
  if (blockeduser != null) {
    getBlogDetailDataUserData.blockeduser = blockeduser;
  }
  final String? showindirctry = jsonConvert.convert<String>(
      json['showindirctry']);
  if (showindirctry != null) {
    getBlogDetailDataUserData.showindirctry = showindirctry;
  }
  final dynamic blockdate = json['blockdate'];
  if (blockdate != null) {
    getBlogDetailDataUserData.blockdate = blockdate;
  }
  final String? plan = jsonConvert.convert<String>(json['plan']);
  if (plan != null) {
    getBlogDetailDataUserData.plan = plan;
  }
  final String? blocktype = jsonConvert.convert<String>(json['blocktype']);
  if (blocktype != null) {
    getBlogDetailDataUserData.blocktype = blocktype;
  }
  final int? paidno = jsonConvert.convert<int>(json['paidno']);
  if (paidno != null) {
    getBlogDetailDataUserData.paidno = paidno;
  }
  final String? isapprove = jsonConvert.convert<String>(json['isapprove']);
  if (isapprove != null) {
    getBlogDetailDataUserData.isapprove = isapprove;
  }
  final String? passtoken = jsonConvert.convert<String>(json['passtoken']);
  if (passtoken != null) {
    getBlogDetailDataUserData.passtoken = passtoken;
  }
  final String? tokendate = jsonConvert.convert<String>(json['tokendate']);
  if (tokendate != null) {
    getBlogDetailDataUserData.tokendate = tokendate;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    getBlogDetailDataUserData.urlcomponent = urlcomponent;
  }
  final String? aboutcompany = jsonConvert.convert<String>(
      json['aboutcompany']);
  if (aboutcompany != null) {
    getBlogDetailDataUserData.aboutcompany = aboutcompany;
  }
  final String? fblink = jsonConvert.convert<String>(json['fblink']);
  if (fblink != null) {
    getBlogDetailDataUserData.fblink = fblink;
  }
  final String? instalink = jsonConvert.convert<String>(json['instalink']);
  if (instalink != null) {
    getBlogDetailDataUserData.instalink = instalink;
  }
  final dynamic twiterlink = json['twiterlink'];
  if (twiterlink != null) {
    getBlogDetailDataUserData.twiterlink = twiterlink;
  }
  final dynamic lilink = json['lilink'];
  if (lilink != null) {
    getBlogDetailDataUserData.lilink = lilink;
  }
  final dynamic youlink = json['youlink'];
  if (youlink != null) {
    getBlogDetailDataUserData.youlink = youlink;
  }
  final dynamic wplink = json['wplink'];
  if (wplink != null) {
    getBlogDetailDataUserData.wplink = wplink;
  }
  final dynamic telink = json['telink'];
  if (telink != null) {
    getBlogDetailDataUserData.telink = telink;
  }
  final String? proceedstatus = jsonConvert.convert<String>(
      json['proceedstatus']);
  if (proceedstatus != null) {
    getBlogDetailDataUserData.proceedstatus = proceedstatus;
  }
  final dynamic device = json['device'];
  if (device != null) {
    getBlogDetailDataUserData.device = device;
  }
  final dynamic platform = json['platform'];
  if (platform != null) {
    getBlogDetailDataUserData.platform = platform;
  }
  final dynamic proceeddate = json['proceeddate'];
  if (proceeddate != null) {
    getBlogDetailDataUserData.proceeddate = proceeddate;
  }
  final int? isApproved = jsonConvert.convert<int>(json['is_approved']);
  if (isApproved != null) {
    getBlogDetailDataUserData.isApproved = isApproved;
  }
  final dynamic countrycode1 = json['countrycode1'];
  if (countrycode1 != null) {
    getBlogDetailDataUserData.countrycode1 = countrycode1;
  }
  final dynamic lat = json['lat'];
  if (lat != null) {
    getBlogDetailDataUserData.lat = lat;
  }
  final dynamic lng = json['lng'];
  if (lng != null) {
    getBlogDetailDataUserData.lng = lng;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    getBlogDetailDataUserData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    getBlogDetailDataUserData.imageThumPath = imageThumPath;
  }
  return getBlogDetailDataUserData;
}

Map<String, dynamic> $GetBlogDetailDataUserDataToJson(
    GetBlogDetailDataUserData entity) {
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

extension GetBlogDetailDataUserDataExtension on GetBlogDetailDataUserData {
  GetBlogDetailDataUserData copyWith({
    int? id,
    dynamic immlm,
    dynamic username,
    dynamic password,
    String? sex,
    String? name,
    String? email,
    dynamic mobile,
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
    dynamic lastlogin,
    dynamic aboutyou,
    dynamic website,
    String? compWebsite,
    String? company,
    String? newregi,
    int? status,
    int? points,
    int? views,
    dynamic emailvarify,
    dynamic vemailcode,
    dynamic vphonecode,
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
    dynamic twiterlink,
    dynamic lilink,
    dynamic youlink,
    dynamic wplink,
    dynamic telink,
    String? proceedstatus,
    dynamic device,
    dynamic platform,
    dynamic proceeddate,
    int? isApproved,
    dynamic countrycode1,
    dynamic lat,
    dynamic lng,
    String? imagePath,
    String? imageThumPath,
  }) {
    return GetBlogDetailDataUserData()
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