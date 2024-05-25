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
  final String? refrelid = jsonConvert.convert<String>(json['refrelid']);
  if (refrelid != null) {
    getUserProfileUserProfile.refrelid = refrelid;
  }
  final dynamic treedirection = json['treedirection'];
  if (treedirection != null) {
    getUserProfileUserProfile.treedirection = treedirection;
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
  final dynamic phonecode = json['phonecode'];
  if (phonecode != null) {
    getUserProfileUserProfile.phonecode = phonecode;
  }
  final String? countrycode1 = jsonConvert.convert<String>(
      json['countrycode1']);
  if (countrycode1 != null) {
    getUserProfileUserProfile.countrycode1 = countrycode1;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    getUserProfileUserProfile.mobile = mobile;
  }
  final dynamic birthdate = json['birthdate'];
  if (birthdate != null) {
    getUserProfileUserProfile.birthdate = birthdate;
  }
  final dynamic secondmail = json['secondmail'];
  if (secondmail != null) {
    getUserProfileUserProfile.secondmail = secondmail;
  }
  final dynamic secondphone = json['secondphone'];
  if (secondphone != null) {
    getUserProfileUserProfile.secondphone = secondphone;
  }
  final dynamic homemobile = json['homemobile'];
  if (homemobile != null) {
    getUserProfileUserProfile.homemobile = homemobile;
  }
  final dynamic address = json['address'];
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
  final dynamic dist = json['dist'];
  if (dist != null) {
    getUserProfileUserProfile.dist = dist;
  }
  final dynamic pincode = json['pincode'];
  if (pincode != null) {
    getUserProfileUserProfile.pincode = pincode;
  }
  final dynamic language = json['language'];
  if (language != null) {
    getUserProfileUserProfile.language = language;
  }
  final dynamic education = json['education'];
  if (education != null) {
    getUserProfileUserProfile.education = education;
  }
  final dynamic employment = json['employment'];
  if (employment != null) {
    getUserProfileUserProfile.employment = employment;
  }
  final dynamic userimage = json['userimage'];
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
  final String? loginLocation = jsonConvert.convert<String>(
      json['login_location']);
  if (loginLocation != null) {
    getUserProfileUserProfile.loginLocation = loginLocation;
  }
  final String? completee = jsonConvert.convert<String>(json['completee']);
  if (completee != null) {
    getUserProfileUserProfile.completee = completee;
  }
  final dynamic aboutyou = json['aboutyou'];
  if (aboutyou != null) {
    getUserProfileUserProfile.aboutyou = aboutyou;
  }
  final dynamic website = json['website'];
  if (website != null) {
    getUserProfileUserProfile.website = website;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    getUserProfileUserProfile.company = company;
  }
  final dynamic aboutbusi = json['aboutbusi'];
  if (aboutbusi != null) {
    getUserProfileUserProfile.aboutbusi = aboutbusi;
  }
  final dynamic pastwebsite = json['pastwebsite'];
  if (pastwebsite != null) {
    getUserProfileUserProfile.pastwebsite = pastwebsite;
  }
  final dynamic pastcompany = json['pastcompany'];
  if (pastcompany != null) {
    getUserProfileUserProfile.pastcompany = pastcompany;
  }
  final dynamic pastwebsite2 = json['pastwebsite2'];
  if (pastwebsite2 != null) {
    getUserProfileUserProfile.pastwebsite2 = pastwebsite2;
  }
  final dynamic pastwebsite3 = json['pastwebsite3'];
  if (pastwebsite3 != null) {
    getUserProfileUserProfile.pastwebsite3 = pastwebsite3;
  }
  final dynamic pastcompany2 = json['pastcompany2'];
  if (pastcompany2 != null) {
    getUserProfileUserProfile.pastcompany2 = pastcompany2;
  }
  final dynamic pastcompany3 = json['pastcompany3'];
  if (pastcompany3 != null) {
    getUserProfileUserProfile.pastcompany3 = pastcompany3;
  }
  final String? newregi = jsonConvert.convert<String>(json['newregi']);
  if (newregi != null) {
    getUserProfileUserProfile.newregi = newregi;
  }
  final dynamic hearabout = json['hearabout'];
  if (hearabout != null) {
    getUserProfileUserProfile.hearabout = hearabout;
  }
  final dynamic keywordd = json['keywordd'];
  if (keywordd != null) {
    getUserProfileUserProfile.keywordd = keywordd;
  }
  final dynamic proupdate = json['proupdate'];
  if (proupdate != null) {
    getUserProfileUserProfile.proupdate = proupdate;
  }
  final dynamic aboutmlm = json['aboutmlm'];
  if (aboutmlm != null) {
    getUserProfileUserProfile.aboutmlm = aboutmlm;
  }
  final String? inrOther = jsonConvert.convert<String>(json['inr_other']);
  if (inrOther != null) {
    getUserProfileUserProfile.inrOther = inrOther;
  }
  final dynamic inrAdver = json['inr_adver'];
  if (inrAdver != null) {
    getUserProfileUserProfile.inrAdver = inrAdver;
  }
  final dynamic inrDb = json['inr_db'];
  if (inrDb != null) {
    getUserProfileUserProfile.inrDb = inrDb;
  }
  final dynamic inrSoft = json['inr_soft'];
  if (inrSoft != null) {
    getUserProfileUserProfile.inrSoft = inrSoft;
  }
  final dynamic sendArt = json['send_art'];
  if (sendArt != null) {
    getUserProfileUserProfile.sendArt = sendArt;
  }
  final dynamic sendNews = json['send_news'];
  if (sendNews != null) {
    getUserProfileUserProfile.sendNews = sendNews;
  }
  final dynamic comments = json['comments'];
  if (comments != null) {
    getUserProfileUserProfile.comments = comments;
  }
  final dynamic callafter = json['callafter'];
  if (callafter != null) {
    getUserProfileUserProfile.callafter = callafter;
  }
  final dynamic yourref = json['yourref'];
  if (yourref != null) {
    getUserProfileUserProfile.yourref = yourref;
  }
  final dynamic refName = json['ref_name'];
  if (refName != null) {
    getUserProfileUserProfile.refName = refName;
  }
  final dynamic refPhone1 = json['ref_phone1'];
  if (refPhone1 != null) {
    getUserProfileUserProfile.refPhone1 = refPhone1;
  }
  final dynamic refPhone2 = json['ref_phone2'];
  if (refPhone2 != null) {
    getUserProfileUserProfile.refPhone2 = refPhone2;
  }
  final dynamic refCity = json['ref_city'];
  if (refCity != null) {
    getUserProfileUserProfile.refCity = refCity;
  }
  final dynamic refEmail = json['ref_email'];
  if (refEmail != null) {
    getUserProfileUserProfile.refEmail = refEmail;
  }
  final dynamic refCompany = json['ref_company'];
  if (refCompany != null) {
    getUserProfileUserProfile.refCompany = refCompany;
  }
  final dynamic refExx = json['ref_exx'];
  if (refExx != null) {
    getUserProfileUserProfile.refExx = refExx;
  }
  final dynamic lastcalldate = json['lastcalldate'];
  if (lastcalldate != null) {
    getUserProfileUserProfile.lastcalldate = lastcalldate;
  }
  final dynamic callafterRecall = json['callafter_recall'];
  if (callafterRecall != null) {
    getUserProfileUserProfile.callafterRecall = callafterRecall;
  }
  final dynamic staffid = json['staffid'];
  if (staffid != null) {
    getUserProfileUserProfile.staffid = staffid;
  }
  final dynamic staffdate = json['staffdate'];
  if (staffdate != null) {
    getUserProfileUserProfile.staffdate = staffdate;
  }
  final String? newuserFin = jsonConvert.convert<String>(json['newuser_fin']);
  if (newuserFin != null) {
    getUserProfileUserProfile.newuserFin = newuserFin;
  }
  final String? olduseFin = jsonConvert.convert<String>(json['olduse_fin']);
  if (olduseFin != null) {
    getUserProfileUserProfile.olduseFin = olduseFin;
  }
  final String? recallFin = jsonConvert.convert<String>(json['recall_fin']);
  if (recallFin != null) {
    getUserProfileUserProfile.recallFin = recallFin;
  }
  final String? inaciveFin = jsonConvert.convert<String>(json['inacive_fin']);
  if (inaciveFin != null) {
    getUserProfileUserProfile.inaciveFin = inaciveFin;
  }
  final String? recallinacFin = jsonConvert.convert<String>(
      json['recallinac_fin']);
  if (recallinacFin != null) {
    getUserProfileUserProfile.recallinacFin = recallinacFin;
  }
  final String? refregFin = jsonConvert.convert<String>(json['refreg_fin']);
  if (refregFin != null) {
    getUserProfileUserProfile.refregFin = refregFin;
  }
  final String? recallrefFin = jsonConvert.convert<String>(
      json['recallref_fin']);
  if (recallrefFin != null) {
    getUserProfileUserProfile.recallrefFin = recallrefFin;
  }
  final String? advertFin = jsonConvert.convert<String>(json['advert_fin']);
  if (advertFin != null) {
    getUserProfileUserProfile.advertFin = advertFin;
  }
  final String? softFin = jsonConvert.convert<String>(json['soft_fin']);
  if (softFin != null) {
    getUserProfileUserProfile.softFin = softFin;
  }
  final String? dbFin = jsonConvert.convert<String>(json['db_fin']);
  if (dbFin != null) {
    getUserProfileUserProfile.dbFin = dbFin;
  }
  final String? sndartFin = jsonConvert.convert<String>(json['sndart_fin']);
  if (sndartFin != null) {
    getUserProfileUserProfile.sndartFin = sndartFin;
  }
  final String? sndnewsFin = jsonConvert.convert<String>(json['sndnews_fin']);
  if (sndnewsFin != null) {
    getUserProfileUserProfile.sndnewsFin = sndnewsFin;
  }
  final String? otherFin = jsonConvert.convert<String>(json['other_fin']);
  if (otherFin != null) {
    getUserProfileUserProfile.otherFin = otherFin;
  }
  final int? advertMailStatus = jsonConvert.convert<int>(
      json['advert_mail_status']);
  if (advertMailStatus != null) {
    getUserProfileUserProfile.advertMailStatus = advertMailStatus;
  }
  final String? rssUrls = jsonConvert.convert<String>(json['rss_urls']);
  if (rssUrls != null) {
    getUserProfileUserProfile.rssUrls = rssUrls;
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
  final String? terms = jsonConvert.convert<String>(json['terms']);
  if (terms != null) {
    getUserProfileUserProfile.terms = terms;
  }
  final String? nlss = jsonConvert.convert<String>(json['nlss']);
  if (nlss != null) {
    getUserProfileUserProfile.nlss = nlss;
  }
  final String? emailvarify = jsonConvert.convert<String>(json['emailvarify']);
  if (emailvarify != null) {
    getUserProfileUserProfile.emailvarify = emailvarify;
  }
  final String? vemailcode = jsonConvert.convert<String>(json['vemailcode']);
  if (vemailcode != null) {
    getUserProfileUserProfile.vemailcode = vemailcode;
  }
  final dynamic phonevarify = json['phonevarify'];
  if (phonevarify != null) {
    getUserProfileUserProfile.phonevarify = phonevarify;
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
  final dynamic emailvarifycode = json['emailvarifycode'];
  if (emailvarifycode != null) {
    getUserProfileUserProfile.emailvarifycode = emailvarifycode;
  }
  final dynamic countrycode2 = json['countrycode2'];
  if (countrycode2 != null) {
    getUserProfileUserProfile.countrycode2 = countrycode2;
  }
  final dynamic countrycode3 = json['countrycode3'];
  if (countrycode3 != null) {
    getUserProfileUserProfile.countrycode3 = countrycode3;
  }
  final dynamic countrycode4 = json['countrycode4'];
  if (countrycode4 != null) {
    getUserProfileUserProfile.countrycode4 = countrycode4;
  }
  final dynamic cemail = json['cemail'];
  if (cemail != null) {
    getUserProfileUserProfile.cemail = cemail;
  }
  final dynamic cphone = json['cphone'];
  if (cphone != null) {
    getUserProfileUserProfile.cphone = cphone;
  }
  final dynamic approve = json['approve'];
  if (approve != null) {
    getUserProfileUserProfile.approve = approve;
  }
  final dynamic verifyEmail = json['verify_email'];
  if (verifyEmail != null) {
    getUserProfileUserProfile.verifyEmail = verifyEmail;
  }
  final String? isphone = jsonConvert.convert<String>(json['isphone']);
  if (isphone != null) {
    getUserProfileUserProfile.isphone = isphone;
  }
  final String? isemail = jsonConvert.convert<String>(json['isemail']);
  if (isemail != null) {
    getUserProfileUserProfile.isemail = isemail;
  }
  final dynamic verifyPhone = json['verify_phone'];
  if (verifyPhone != null) {
    getUserProfileUserProfile.verifyPhone = verifyPhone;
  }
  final dynamic anniversaryDate = json['anniversary_date'];
  if (anniversaryDate != null) {
    getUserProfileUserProfile.anniversaryDate = anniversaryDate;
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
  final String? blockdate = jsonConvert.convert<String>(json['blockdate']);
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
  final String? tokendate = jsonConvert.convert<String>(json['tokendate']);
  if (tokendate != null) {
    getUserProfileUserProfile.tokendate = tokendate;
  }
  final String? urlcomponent = jsonConvert.convert<String>(
      json['urlcomponent']);
  if (urlcomponent != null) {
    getUserProfileUserProfile.urlcomponent = urlcomponent;
  }
  final String? aboutcompany = jsonConvert.convert<String>(
      json['aboutcompany']);
  if (aboutcompany != null) {
    getUserProfileUserProfile.aboutcompany = aboutcompany;
  }
  final String? fblink = jsonConvert.convert<String>(json['fblink']);
  if (fblink != null) {
    getUserProfileUserProfile.fblink = fblink;
  }
  final String? instalink = jsonConvert.convert<String>(json['instalink']);
  if (instalink != null) {
    getUserProfileUserProfile.instalink = instalink;
  }
  final String? twiterlink = jsonConvert.convert<String>(json['twiterlink']);
  if (twiterlink != null) {
    getUserProfileUserProfile.twiterlink = twiterlink;
  }
  final String? lilink = jsonConvert.convert<String>(json['lilink']);
  if (lilink != null) {
    getUserProfileUserProfile.lilink = lilink;
  }
  final String? youlink = jsonConvert.convert<String>(json['youlink']);
  if (youlink != null) {
    getUserProfileUserProfile.youlink = youlink;
  }
  final String? wplink = jsonConvert.convert<String>(json['wplink']);
  if (wplink != null) {
    getUserProfileUserProfile.wplink = wplink;
  }
  final String? telink = jsonConvert.convert<String>(json['telink']);
  if (telink != null) {
    getUserProfileUserProfile.telink = telink;
  }
  final String? proceedstatus = jsonConvert.convert<String>(
      json['proceedstatus']);
  if (proceedstatus != null) {
    getUserProfileUserProfile.proceedstatus = proceedstatus;
  }
  final String? proceeddate = jsonConvert.convert<String>(json['proceeddate']);
  if (proceeddate != null) {
    getUserProfileUserProfile.proceeddate = proceeddate;
  }
  final int? isApproved = jsonConvert.convert<int>(json['is_approved']);
  if (isApproved != null) {
    getUserProfileUserProfile.isApproved = isApproved;
  }
  return getUserProfileUserProfile;
}

Map<String, dynamic> $GetUserProfileUserProfileToJson(
    GetUserProfileUserProfile entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['immlm'] = entity.immlm;
  data['refrelid'] = entity.refrelid;
  data['treedirection'] = entity.treedirection;
  data['username'] = entity.username;
  data['password'] = entity.password;
  data['sex'] = entity.sex;
  data['name'] = entity.name;
  data['email'] = entity.email;
  data['phonecode'] = entity.phonecode;
  data['countrycode1'] = entity.countrycode1;
  data['mobile'] = entity.mobile;
  data['birthdate'] = entity.birthdate;
  data['secondmail'] = entity.secondmail;
  data['secondphone'] = entity.secondphone;
  data['homemobile'] = entity.homemobile;
  data['address'] = entity.address;
  data['country'] = entity.country;
  data['state'] = entity.state;
  data['city'] = entity.city;
  data['dist'] = entity.dist;
  data['pincode'] = entity.pincode;
  data['language'] = entity.language;
  data['education'] = entity.education;
  data['employment'] = entity.employment;
  data['userimage'] = entity.userimage;
  data['joindate'] = entity.joindate;
  data['ip'] = entity.ip;
  data['lastip'] = entity.lastip;
  data['lastlogin'] = entity.lastlogin;
  data['login_location'] = entity.loginLocation;
  data['completee'] = entity.completee;
  data['aboutyou'] = entity.aboutyou;
  data['website'] = entity.website;
  data['company'] = entity.company;
  data['aboutbusi'] = entity.aboutbusi;
  data['pastwebsite'] = entity.pastwebsite;
  data['pastcompany'] = entity.pastcompany;
  data['pastwebsite2'] = entity.pastwebsite2;
  data['pastwebsite3'] = entity.pastwebsite3;
  data['pastcompany2'] = entity.pastcompany2;
  data['pastcompany3'] = entity.pastcompany3;
  data['newregi'] = entity.newregi;
  data['hearabout'] = entity.hearabout;
  data['keywordd'] = entity.keywordd;
  data['proupdate'] = entity.proupdate;
  data['aboutmlm'] = entity.aboutmlm;
  data['inr_other'] = entity.inrOther;
  data['inr_adver'] = entity.inrAdver;
  data['inr_db'] = entity.inrDb;
  data['inr_soft'] = entity.inrSoft;
  data['send_art'] = entity.sendArt;
  data['send_news'] = entity.sendNews;
  data['comments'] = entity.comments;
  data['callafter'] = entity.callafter;
  data['yourref'] = entity.yourref;
  data['ref_name'] = entity.refName;
  data['ref_phone1'] = entity.refPhone1;
  data['ref_phone2'] = entity.refPhone2;
  data['ref_city'] = entity.refCity;
  data['ref_email'] = entity.refEmail;
  data['ref_company'] = entity.refCompany;
  data['ref_exx'] = entity.refExx;
  data['lastcalldate'] = entity.lastcalldate;
  data['callafter_recall'] = entity.callafterRecall;
  data['staffid'] = entity.staffid;
  data['staffdate'] = entity.staffdate;
  data['newuser_fin'] = entity.newuserFin;
  data['olduse_fin'] = entity.olduseFin;
  data['recall_fin'] = entity.recallFin;
  data['inacive_fin'] = entity.inaciveFin;
  data['recallinac_fin'] = entity.recallinacFin;
  data['refreg_fin'] = entity.refregFin;
  data['recallref_fin'] = entity.recallrefFin;
  data['advert_fin'] = entity.advertFin;
  data['soft_fin'] = entity.softFin;
  data['db_fin'] = entity.dbFin;
  data['sndart_fin'] = entity.sndartFin;
  data['sndnews_fin'] = entity.sndnewsFin;
  data['other_fin'] = entity.otherFin;
  data['advert_mail_status'] = entity.advertMailStatus;
  data['rss_urls'] = entity.rssUrls;
  data['status'] = entity.status;
  data['points'] = entity.points;
  data['views'] = entity.views;
  data['terms'] = entity.terms;
  data['nlss'] = entity.nlss;
  data['emailvarify'] = entity.emailvarify;
  data['vemailcode'] = entity.vemailcode;
  data['phonevarify'] = entity.phonevarify;
  data['vphonecode'] = entity.vphonecode;
  data['stepno'] = entity.stepno;
  data['token'] = entity.token;
  data['emailvarifycode'] = entity.emailvarifycode;
  data['countrycode2'] = entity.countrycode2;
  data['countrycode3'] = entity.countrycode3;
  data['countrycode4'] = entity.countrycode4;
  data['cemail'] = entity.cemail;
  data['cphone'] = entity.cphone;
  data['approve'] = entity.approve;
  data['verify_email'] = entity.verifyEmail;
  data['isphone'] = entity.isphone;
  data['isemail'] = entity.isemail;
  data['verify_phone'] = entity.verifyPhone;
  data['anniversary_date'] = entity.anniversaryDate;
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
  data['proceeddate'] = entity.proceeddate;
  data['is_approved'] = entity.isApproved;
  return data;
}

extension GetUserProfileUserProfileExtension on GetUserProfileUserProfile {
  GetUserProfileUserProfile copyWith({
    int? id,
    String? immlm,
    String? refrelid,
    dynamic treedirection,
    String? username,
    String? password,
    String? sex,
    String? name,
    String? email,
    dynamic phonecode,
    String? countrycode1,
    String? mobile,
    dynamic birthdate,
    dynamic secondmail,
    dynamic secondphone,
    dynamic homemobile,
    dynamic address,
    String? country,
    String? state,
    String? city,
    dynamic dist,
    dynamic pincode,
    dynamic language,
    dynamic education,
    dynamic employment,
    dynamic userimage,
    String? joindate,
    String? ip,
    String? lastip,
    String? lastlogin,
    String? loginLocation,
    String? completee,
    dynamic aboutyou,
    dynamic website,
    String? company,
    dynamic aboutbusi,
    dynamic pastwebsite,
    dynamic pastcompany,
    dynamic pastwebsite2,
    dynamic pastwebsite3,
    dynamic pastcompany2,
    dynamic pastcompany3,
    String? newregi,
    dynamic hearabout,
    dynamic keywordd,
    dynamic proupdate,
    dynamic aboutmlm,
    String? inrOther,
    dynamic inrAdver,
    dynamic inrDb,
    dynamic inrSoft,
    dynamic sendArt,
    dynamic sendNews,
    dynamic comments,
    dynamic callafter,
    dynamic yourref,
    dynamic refName,
    dynamic refPhone1,
    dynamic refPhone2,
    dynamic refCity,
    dynamic refEmail,
    dynamic refCompany,
    dynamic refExx,
    dynamic lastcalldate,
    dynamic callafterRecall,
    dynamic staffid,
    dynamic staffdate,
    String? newuserFin,
    String? olduseFin,
    String? recallFin,
    String? inaciveFin,
    String? recallinacFin,
    String? refregFin,
    String? recallrefFin,
    String? advertFin,
    String? softFin,
    String? dbFin,
    String? sndartFin,
    String? sndnewsFin,
    String? otherFin,
    int? advertMailStatus,
    String? rssUrls,
    int? status,
    int? points,
    int? views,
    String? terms,
    String? nlss,
    String? emailvarify,
    String? vemailcode,
    dynamic phonevarify,
    String? vphonecode,
    dynamic stepno,
    String? token,
    dynamic emailvarifycode,
    dynamic countrycode2,
    dynamic countrycode3,
    dynamic countrycode4,
    dynamic cemail,
    dynamic cphone,
    dynamic approve,
    dynamic verifyEmail,
    String? isphone,
    String? isemail,
    dynamic verifyPhone,
    dynamic anniversaryDate,
    String? blockeduser,
    String? showindirctry,
    String? blockdate,
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
    String? proceeddate,
    int? isApproved,
  }) {
    return GetUserProfileUserProfile()
      ..id = id ?? this.id
      ..immlm = immlm ?? this.immlm
      ..refrelid = refrelid ?? this.refrelid
      ..treedirection = treedirection ?? this.treedirection
      ..username = username ?? this.username
      ..password = password ?? this.password
      ..sex = sex ?? this.sex
      ..name = name ?? this.name
      ..email = email ?? this.email
      ..phonecode = phonecode ?? this.phonecode
      ..countrycode1 = countrycode1 ?? this.countrycode1
      ..mobile = mobile ?? this.mobile
      ..birthdate = birthdate ?? this.birthdate
      ..secondmail = secondmail ?? this.secondmail
      ..secondphone = secondphone ?? this.secondphone
      ..homemobile = homemobile ?? this.homemobile
      ..address = address ?? this.address
      ..country = country ?? this.country
      ..state = state ?? this.state
      ..city = city ?? this.city
      ..dist = dist ?? this.dist
      ..pincode = pincode ?? this.pincode
      ..language = language ?? this.language
      ..education = education ?? this.education
      ..employment = employment ?? this.employment
      ..userimage = userimage ?? this.userimage
      ..joindate = joindate ?? this.joindate
      ..ip = ip ?? this.ip
      ..lastip = lastip ?? this.lastip
      ..lastlogin = lastlogin ?? this.lastlogin
      ..loginLocation = loginLocation ?? this.loginLocation
      ..completee = completee ?? this.completee
      ..aboutyou = aboutyou ?? this.aboutyou
      ..website = website ?? this.website
      ..company = company ?? this.company
      ..aboutbusi = aboutbusi ?? this.aboutbusi
      ..pastwebsite = pastwebsite ?? this.pastwebsite
      ..pastcompany = pastcompany ?? this.pastcompany
      ..pastwebsite2 = pastwebsite2 ?? this.pastwebsite2
      ..pastwebsite3 = pastwebsite3 ?? this.pastwebsite3
      ..pastcompany2 = pastcompany2 ?? this.pastcompany2
      ..pastcompany3 = pastcompany3 ?? this.pastcompany3
      ..newregi = newregi ?? this.newregi
      ..hearabout = hearabout ?? this.hearabout
      ..keywordd = keywordd ?? this.keywordd
      ..proupdate = proupdate ?? this.proupdate
      ..aboutmlm = aboutmlm ?? this.aboutmlm
      ..inrOther = inrOther ?? this.inrOther
      ..inrAdver = inrAdver ?? this.inrAdver
      ..inrDb = inrDb ?? this.inrDb
      ..inrSoft = inrSoft ?? this.inrSoft
      ..sendArt = sendArt ?? this.sendArt
      ..sendNews = sendNews ?? this.sendNews
      ..comments = comments ?? this.comments
      ..callafter = callafter ?? this.callafter
      ..yourref = yourref ?? this.yourref
      ..refName = refName ?? this.refName
      ..refPhone1 = refPhone1 ?? this.refPhone1
      ..refPhone2 = refPhone2 ?? this.refPhone2
      ..refCity = refCity ?? this.refCity
      ..refEmail = refEmail ?? this.refEmail
      ..refCompany = refCompany ?? this.refCompany
      ..refExx = refExx ?? this.refExx
      ..lastcalldate = lastcalldate ?? this.lastcalldate
      ..callafterRecall = callafterRecall ?? this.callafterRecall
      ..staffid = staffid ?? this.staffid
      ..staffdate = staffdate ?? this.staffdate
      ..newuserFin = newuserFin ?? this.newuserFin
      ..olduseFin = olduseFin ?? this.olduseFin
      ..recallFin = recallFin ?? this.recallFin
      ..inaciveFin = inaciveFin ?? this.inaciveFin
      ..recallinacFin = recallinacFin ?? this.recallinacFin
      ..refregFin = refregFin ?? this.refregFin
      ..recallrefFin = recallrefFin ?? this.recallrefFin
      ..advertFin = advertFin ?? this.advertFin
      ..softFin = softFin ?? this.softFin
      ..dbFin = dbFin ?? this.dbFin
      ..sndartFin = sndartFin ?? this.sndartFin
      ..sndnewsFin = sndnewsFin ?? this.sndnewsFin
      ..otherFin = otherFin ?? this.otherFin
      ..advertMailStatus = advertMailStatus ?? this.advertMailStatus
      ..rssUrls = rssUrls ?? this.rssUrls
      ..status = status ?? this.status
      ..points = points ?? this.points
      ..views = views ?? this.views
      ..terms = terms ?? this.terms
      ..nlss = nlss ?? this.nlss
      ..emailvarify = emailvarify ?? this.emailvarify
      ..vemailcode = vemailcode ?? this.vemailcode
      ..phonevarify = phonevarify ?? this.phonevarify
      ..vphonecode = vphonecode ?? this.vphonecode
      ..stepno = stepno ?? this.stepno
      ..token = token ?? this.token
      ..emailvarifycode = emailvarifycode ?? this.emailvarifycode
      ..countrycode2 = countrycode2 ?? this.countrycode2
      ..countrycode3 = countrycode3 ?? this.countrycode3
      ..countrycode4 = countrycode4 ?? this.countrycode4
      ..cemail = cemail ?? this.cemail
      ..cphone = cphone ?? this.cphone
      ..approve = approve ?? this.approve
      ..verifyEmail = verifyEmail ?? this.verifyEmail
      ..isphone = isphone ?? this.isphone
      ..isemail = isemail ?? this.isemail
      ..verifyPhone = verifyPhone ?? this.verifyPhone
      ..anniversaryDate = anniversaryDate ?? this.anniversaryDate
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
      ..proceeddate = proceeddate ?? this.proceeddate
      ..isApproved = isApproved ?? this.isApproved;
  }
}