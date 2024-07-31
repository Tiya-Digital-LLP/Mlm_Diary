import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/mutual_friends_entity.dart';

MutualFriendsEntity $MutualFriendsEntityFromJson(Map<String, dynamic> json) {
  final MutualFriendsEntity mutualFriendsEntity = MutualFriendsEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    mutualFriendsEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    mutualFriendsEntity.message = message;
  }
  final List<MutualFriendsData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<MutualFriendsData>(e) as MutualFriendsData)
      .toList();
  if (data != null) {
    mutualFriendsEntity.data = data;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    mutualFriendsEntity.total = total;
  }
  final int? currentPage = jsonConvert.convert<int>(json['current_page']);
  if (currentPage != null) {
    mutualFriendsEntity.currentPage = currentPage;
  }
  final int? perPage = jsonConvert.convert<int>(json['per_page']);
  if (perPage != null) {
    mutualFriendsEntity.perPage = perPage;
  }
  return mutualFriendsEntity;
}

Map<String, dynamic> $MutualFriendsEntityToJson(MutualFriendsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['total'] = entity.total;
  data['current_page'] = entity.currentPage;
  data['per_page'] = entity.perPage;
  return data;
}

extension MutualFriendsEntityExtension on MutualFriendsEntity {
  MutualFriendsEntity copyWith({
    int? status,
    String? message,
    List<MutualFriendsData>? data,
    int? total,
    int? currentPage,
    int? perPage,
  }) {
    return MutualFriendsEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data
      ..total = total ?? this.total
      ..currentPage = currentPage ?? this.currentPage
      ..perPage = perPage ?? this.perPage;
  }
}

MutualFriendsData $MutualFriendsDataFromJson(Map<String, dynamic> json) {
  final MutualFriendsData mutualFriendsData = MutualFriendsData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    mutualFriendsData.id = id;
  }
  final String? immlm = jsonConvert.convert<String>(json['immlm']);
  if (immlm != null) {
    mutualFriendsData.immlm = immlm;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    mutualFriendsData.username = username;
  }
  final String? password = jsonConvert.convert<String>(json['password']);
  if (password != null) {
    mutualFriendsData.password = password;
  }
  final String? sex = jsonConvert.convert<String>(json['sex']);
  if (sex != null) {
    mutualFriendsData.sex = sex;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    mutualFriendsData.name = name;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    mutualFriendsData.email = email;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    mutualFriendsData.mobile = mobile;
  }
  final String? birthdate = jsonConvert.convert<String>(json['birthdate']);
  if (birthdate != null) {
    mutualFriendsData.birthdate = birthdate;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    mutualFriendsData.address = address;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    mutualFriendsData.country = country;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    mutualFriendsData.state = state;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    mutualFriendsData.city = city;
  }
  final String? pincode = jsonConvert.convert<String>(json['pincode']);
  if (pincode != null) {
    mutualFriendsData.pincode = pincode;
  }
  final String? employment = jsonConvert.convert<String>(json['employment']);
  if (employment != null) {
    mutualFriendsData.employment = employment;
  }
  final String? userimage = jsonConvert.convert<String>(json['userimage']);
  if (userimage != null) {
    mutualFriendsData.userimage = userimage;
  }
  final String? joindate = jsonConvert.convert<String>(json['joindate']);
  if (joindate != null) {
    mutualFriendsData.joindate = joindate;
  }
  final String? ip = jsonConvert.convert<String>(json['ip']);
  if (ip != null) {
    mutualFriendsData.ip = ip;
  }
  final String? lastip = jsonConvert.convert<String>(json['lastip']);
  if (lastip != null) {
    mutualFriendsData.lastip = lastip;
  }
  final String? lastlogin = jsonConvert.convert<String>(json['lastlogin']);
  if (lastlogin != null) {
    mutualFriendsData.lastlogin = lastlogin;
  }
  final String? aboutyou = jsonConvert.convert<String>(json['aboutyou']);
  if (aboutyou != null) {
    mutualFriendsData.aboutyou = aboutyou;
  }
  final String? website = jsonConvert.convert<String>(json['website']);
  if (website != null) {
    mutualFriendsData.website = website;
  }
  final dynamic compWebsite = json['comp_website'];
  if (compWebsite != null) {
    mutualFriendsData.compWebsite = compWebsite;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    mutualFriendsData.company = company;
  }
  final String? newregi = jsonConvert.convert<String>(json['newregi']);
  if (newregi != null) {
    mutualFriendsData.newregi = newregi;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    mutualFriendsData.status = status;
  }
  final int? points = jsonConvert.convert<int>(json['points']);
  if (points != null) {
    mutualFriendsData.points = points;
  }
  final int? views = jsonConvert.convert<int>(json['views']);
  if (views != null) {
    mutualFriendsData.views = views;
  }
  final dynamic emailvarify = json['emailvarify'];
  if (emailvarify != null) {
    mutualFriendsData.emailvarify = emailvarify;
  }
  final dynamic vemailcode = json['vemailcode'];
  if (vemailcode != null) {
    mutualFriendsData.vemailcode = vemailcode;
  }
  final String? vphonecode = jsonConvert.convert<String>(json['vphonecode']);
  if (vphonecode != null) {
    mutualFriendsData.vphonecode = vphonecode;
  }
  final dynamic stepno = json['stepno'];
  if (stepno != null) {
    mutualFriendsData.stepno = stepno;
  }
  final dynamic token = json['token'];
  if (token != null) {
    mutualFriendsData.token = token;
  }
  final dynamic approve = json['approve'];
  if (approve != null) {
    mutualFriendsData.approve = approve;
  }
  final String? verifyEmail = jsonConvert.convert<String>(json['verify_email']);
  if (verifyEmail != null) {
    mutualFriendsData.verifyEmail = verifyEmail;
  }
  final String? blockeduser = jsonConvert.convert<String>(json['blockeduser']);
  if (blockeduser != null) {
    mutualFriendsData.blockeduser = blockeduser;
  }
  final String? showindirctry = jsonConvert.convert<String>(
      json['showindirctry']);
  if (showindirctry != null) {
    mutualFriendsData.showindirctry = showindirctry;
  }
  final dynamic blockdate = json['blockdate'];
  if (blockdate != null) {
    mutualFriendsData.blockdate = blockdate;
  }
  final String? plan = jsonConvert.convert<String>(json['plan']);
  if (plan != null) {
    mutualFriendsData.plan = plan;
  }
  final String? blocktype = jsonConvert.convert<String>(json['blocktype']);
  if (blocktype != null) {
    mutualFriendsData.blocktype = blocktype;
  }
  final int? paidno = jsonConvert.convert<int>(json['paidno']);
  if (paidno != null) {
    mutualFriendsData.paidno = paidno;
  }
  final String? isapprove = jsonConvert.convert<String>(json['isapprove']);
  if (isapprove != null) {
    mutualFriendsData.isapprove = isapprove;
  }
  final String? passtoken = jsonConvert.convert<String>(json['passtoken']);
  if (passtoken != null) {
    mutualFriendsData.passtoken = passtoken;
  }
  final String? tokendate = jsonConvert.convert<String>(json['tokendate']);
  if (tokendate != null) {
    mutualFriendsData.tokendate = tokendate;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    mutualFriendsData.urlcomponent = urlcomponent;
  }
  final String? aboutcompany = jsonConvert.convert<String>(
      json['aboutcompany']);
  if (aboutcompany != null) {
    mutualFriendsData.aboutcompany = aboutcompany;
  }
  final String? fblink = jsonConvert.convert<String>(json['fblink']);
  if (fblink != null) {
    mutualFriendsData.fblink = fblink;
  }
  final String? instalink = jsonConvert.convert<String>(json['instalink']);
  if (instalink != null) {
    mutualFriendsData.instalink = instalink;
  }
  final String? twiterlink = jsonConvert.convert<String>(json['twiterlink']);
  if (twiterlink != null) {
    mutualFriendsData.twiterlink = twiterlink;
  }
  final String? lilink = jsonConvert.convert<String>(json['lilink']);
  if (lilink != null) {
    mutualFriendsData.lilink = lilink;
  }
  final String? youlink = jsonConvert.convert<String>(json['youlink']);
  if (youlink != null) {
    mutualFriendsData.youlink = youlink;
  }
  final String? wplink = jsonConvert.convert<String>(json['wplink']);
  if (wplink != null) {
    mutualFriendsData.wplink = wplink;
  }
  final String? telink = jsonConvert.convert<String>(json['telink']);
  if (telink != null) {
    mutualFriendsData.telink = telink;
  }
  final String? proceedstatus = jsonConvert.convert<String>(
      json['proceedstatus']);
  if (proceedstatus != null) {
    mutualFriendsData.proceedstatus = proceedstatus;
  }
  final dynamic device = json['device'];
  if (device != null) {
    mutualFriendsData.device = device;
  }
  final dynamic platform = json['platform'];
  if (platform != null) {
    mutualFriendsData.platform = platform;
  }
  final String? proceeddate = jsonConvert.convert<String>(json['proceeddate']);
  if (proceeddate != null) {
    mutualFriendsData.proceeddate = proceeddate;
  }
  final int? isApproved = jsonConvert.convert<int>(json['is_approved']);
  if (isApproved != null) {
    mutualFriendsData.isApproved = isApproved;
  }
  final String? countrycode1 = jsonConvert.convert<String>(
      json['countrycode1']);
  if (countrycode1 != null) {
    mutualFriendsData.countrycode1 = countrycode1;
  }
  final String? lat = jsonConvert.convert<String>(json['lat']);
  if (lat != null) {
    mutualFriendsData.lat = lat;
  }
  final String? lng = jsonConvert.convert<String>(json['lng']);
  if (lng != null) {
    mutualFriendsData.lng = lng;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
  if (imageUrl != null) {
    mutualFriendsData.imageUrl = imageUrl;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    mutualFriendsData.title = title;
  }
  final int? pgcnt = jsonConvert.convert<int>(json['pgcnt']);
  if (pgcnt != null) {
    mutualFriendsData.pgcnt = pgcnt;
  }
  final bool? isFollowing = jsonConvert.convert<bool>(json['is_following']);
  if (isFollowing != null) {
    mutualFriendsData.isFollowing = isFollowing;
  }
  final int? followersCount = jsonConvert.convert<int>(json['followers_count']);
  if (followersCount != null) {
    mutualFriendsData.followersCount = followersCount;
  }
  final int? followingCount = jsonConvert.convert<int>(json['following_count']);
  if (followingCount != null) {
    mutualFriendsData.followingCount = followingCount;
  }
  final int? totalPost = jsonConvert.convert<int>(json['total_post']);
  if (totalPost != null) {
    mutualFriendsData.totalPost = totalPost;
  }
  final String? imagePath = jsonConvert.convert<String>(json['image_path']);
  if (imagePath != null) {
    mutualFriendsData.imagePath = imagePath;
  }
  final String? imageThumPath = jsonConvert.convert<String>(
      json['image_thum_path']);
  if (imageThumPath != null) {
    mutualFriendsData.imageThumPath = imageThumPath;
  }
  return mutualFriendsData;
}

Map<String, dynamic> $MutualFriendsDataToJson(MutualFriendsData entity) {
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
  data['image_url'] = entity.imageUrl;
  data['title'] = entity.title;
  data['pgcnt'] = entity.pgcnt;
  data['is_following'] = entity.isFollowing;
  data['followers_count'] = entity.followersCount;
  data['following_count'] = entity.followingCount;
  data['total_post'] = entity.totalPost;
  data['image_path'] = entity.imagePath;
  data['image_thum_path'] = entity.imageThumPath;
  return data;
}

extension MutualFriendsDataExtension on MutualFriendsData {
  MutualFriendsData copyWith({
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
    String? employment,
    String? userimage,
    String? joindate,
    String? ip,
    String? lastip,
    String? lastlogin,
    String? aboutyou,
    String? website,
    dynamic compWebsite,
    String? company,
    String? newregi,
    int? status,
    int? points,
    int? views,
    dynamic emailvarify,
    dynamic vemailcode,
    String? vphonecode,
    dynamic stepno,
    dynamic token,
    dynamic approve,
    String? verifyEmail,
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
    dynamic device,
    dynamic platform,
    String? proceeddate,
    int? isApproved,
    String? countrycode1,
    String? lat,
    String? lng,
    String? imageUrl,
    String? title,
    int? pgcnt,
    bool? isFollowing,
    int? followersCount,
    int? followingCount,
    int? totalPost,
    String? imagePath,
    String? imageThumPath,
  }) {
    return MutualFriendsData()
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
      ..imageUrl = imageUrl ?? this.imageUrl
      ..title = title ?? this.title
      ..pgcnt = pgcnt ?? this.pgcnt
      ..isFollowing = isFollowing ?? this.isFollowing
      ..followersCount = followersCount ?? this.followersCount
      ..followingCount = followingCount ?? this.followingCount
      ..totalPost = totalPost ?? this.totalPost
      ..imagePath = imagePath ?? this.imagePath
      ..imageThumPath = imageThumPath ?? this.imageThumPath;
  }
}