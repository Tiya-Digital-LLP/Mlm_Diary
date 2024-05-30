import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_banner_entity.dart';

GetBannerEntity $GetBannerEntityFromJson(Map<String, dynamic> json) {
  final GetBannerEntity getBannerEntity = GetBannerEntity();
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    getBannerEntity.status = status;
  }
  final List<GetBannerData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<GetBannerData>(e) as GetBannerData)
      .toList();
  if (data != null) {
    getBannerEntity.data = data;
  }
  return getBannerEntity;
}

Map<String, dynamic> $GetBannerEntityToJson(GetBannerEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetBannerEntityExtension on GetBannerEntity {
  GetBannerEntity copyWith({
    String? status,
    List<GetBannerData>? data,
  }) {
    return GetBannerEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

GetBannerData $GetBannerDataFromJson(Map<String, dynamic> json) {
  final GetBannerData getBannerData = GetBannerData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getBannerData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getBannerData.title = title;
  }
  final String? weblink = jsonConvert.convert<String>(json['weblink']);
  if (weblink != null) {
    getBannerData.weblink = weblink;
  }
  final String? sdate = jsonConvert.convert<String>(json['sdate']);
  if (sdate != null) {
    getBannerData.sdate = sdate;
  }
  final String? edate = jsonConvert.convert<String>(json['edate']);
  if (edate != null) {
    getBannerData.edate = edate;
  }
  final String? addby = jsonConvert.convert<String>(json['addby']);
  if (addby != null) {
    getBannerData.addby = addby;
  }
  final String? displayedIn = jsonConvert.convert<String>(json['displayed_in']);
  if (displayedIn != null) {
    getBannerData.displayedIn = displayedIn;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    getBannerData.image = image;
  }
  final String? position = jsonConvert.convert<String>(json['position']);
  if (position != null) {
    getBannerData.position = position;
  }
  final String? postpage = jsonConvert.convert<String>(json['postpage']);
  if (postpage != null) {
    getBannerData.postpage = postpage;
  }
  final String? contact1 = jsonConvert.convert<String>(json['contact1']);
  if (contact1 != null) {
    getBannerData.contact1 = contact1;
  }
  final String? contact2 = jsonConvert.convert<String>(json['contact2']);
  if (contact2 != null) {
    getBannerData.contact2 = contact2;
  }
  final String? contact3 = jsonConvert.convert<String>(json['contact3']);
  if (contact3 != null) {
    getBannerData.contact3 = contact3;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    getBannerData.content = content;
  }
  final dynamic createdate = json['createdate'];
  if (createdate != null) {
    getBannerData.createdate = createdate;
  }
  final int? view = jsonConvert.convert<int>(json['view']);
  if (view != null) {
    getBannerData.view = view;
  }
  final int? sequence = jsonConvert.convert<int>(json['sequence']);
  if (sequence != null) {
    getBannerData.sequence = sequence;
  }
  final int? clicks = jsonConvert.convert<int>(json['clicks']);
  if (clicks != null) {
    getBannerData.clicks = clicks;
  }
  final String? btype = jsonConvert.convert<String>(json['btype']);
  if (btype != null) {
    getBannerData.btype = btype;
  }
  return getBannerData;
}

Map<String, dynamic> $GetBannerDataToJson(GetBannerData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['weblink'] = entity.weblink;
  data['sdate'] = entity.sdate;
  data['edate'] = entity.edate;
  data['addby'] = entity.addby;
  data['displayed_in'] = entity.displayedIn;
  data['image'] = entity.image;
  data['position'] = entity.position;
  data['postpage'] = entity.postpage;
  data['contact1'] = entity.contact1;
  data['contact2'] = entity.contact2;
  data['contact3'] = entity.contact3;
  data['content'] = entity.content;
  data['createdate'] = entity.createdate;
  data['view'] = entity.view;
  data['sequence'] = entity.sequence;
  data['clicks'] = entity.clicks;
  data['btype'] = entity.btype;
  return data;
}

extension GetBannerDataExtension on GetBannerData {
  GetBannerData copyWith({
    int? id,
    String? title,
    String? weblink,
    String? sdate,
    String? edate,
    String? addby,
    String? displayedIn,
    String? image,
    String? position,
    String? postpage,
    String? contact1,
    String? contact2,
    String? contact3,
    String? content,
    dynamic createdate,
    int? view,
    int? sequence,
    int? clicks,
    String? btype,
  }) {
    return GetBannerData()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..weblink = weblink ?? this.weblink
      ..sdate = sdate ?? this.sdate
      ..edate = edate ?? this.edate
      ..addby = addby ?? this.addby
      ..displayedIn = displayedIn ?? this.displayedIn
      ..image = image ?? this.image
      ..position = position ?? this.position
      ..postpage = postpage ?? this.postpage
      ..contact1 = contact1 ?? this.contact1
      ..contact2 = contact2 ?? this.contact2
      ..contact3 = contact3 ?? this.contact3
      ..content = content ?? this.content
      ..createdate = createdate ?? this.createdate
      ..view = view ?? this.view
      ..sequence = sequence ?? this.sequence
      ..clicks = clicks ?? this.clicks
      ..btype = btype ?? this.btype;
  }
}