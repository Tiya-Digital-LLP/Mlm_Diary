import 'package:mlmdiary/generated/json/base/json_convert_content.dart';
import 'package:mlmdiary/generated/get_pop_up_banner_entity.dart';

GetPopUpBannerEntity $GetPopUpBannerEntityFromJson(Map<String, dynamic> json) {
  final GetPopUpBannerEntity getPopUpBannerEntity = GetPopUpBannerEntity();
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    getPopUpBannerEntity.status = status;
  }
  final List<GetPopUpBannerData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<GetPopUpBannerData>(e) as GetPopUpBannerData)
      .toList();
  if (data != null) {
    getPopUpBannerEntity.data = data;
  }
  return getPopUpBannerEntity;
}

Map<String, dynamic> $GetPopUpBannerEntityToJson(GetPopUpBannerEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension GetPopUpBannerEntityExtension on GetPopUpBannerEntity {
  GetPopUpBannerEntity copyWith({
    String? status,
    List<GetPopUpBannerData>? data,
  }) {
    return GetPopUpBannerEntity()
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

GetPopUpBannerData $GetPopUpBannerDataFromJson(Map<String, dynamic> json) {
  final GetPopUpBannerData getPopUpBannerData = GetPopUpBannerData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    getPopUpBannerData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    getPopUpBannerData.title = title;
  }
  final String? weblink = jsonConvert.convert<String>(json['weblink']);
  if (weblink != null) {
    getPopUpBannerData.weblink = weblink;
  }
  final String? sdate = jsonConvert.convert<String>(json['sdate']);
  if (sdate != null) {
    getPopUpBannerData.sdate = sdate;
  }
  final String? edate = jsonConvert.convert<String>(json['edate']);
  if (edate != null) {
    getPopUpBannerData.edate = edate;
  }
  final String? addby = jsonConvert.convert<String>(json['addby']);
  if (addby != null) {
    getPopUpBannerData.addby = addby;
  }
  final String? displayedIn = jsonConvert.convert<String>(json['displayed_in']);
  if (displayedIn != null) {
    getPopUpBannerData.displayedIn = displayedIn;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    getPopUpBannerData.image = image;
  }
  final String? position = jsonConvert.convert<String>(json['position']);
  if (position != null) {
    getPopUpBannerData.position = position;
  }
  final String? postpage = jsonConvert.convert<String>(json['postpage']);
  if (postpage != null) {
    getPopUpBannerData.postpage = postpage;
  }
  final String? contact1 = jsonConvert.convert<String>(json['contact1']);
  if (contact1 != null) {
    getPopUpBannerData.contact1 = contact1;
  }
  final String? contact2 = jsonConvert.convert<String>(json['contact2']);
  if (contact2 != null) {
    getPopUpBannerData.contact2 = contact2;
  }
  final String? contact3 = jsonConvert.convert<String>(json['contact3']);
  if (contact3 != null) {
    getPopUpBannerData.contact3 = contact3;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    getPopUpBannerData.content = content;
  }
  final dynamic createdate = json['createdate'];
  if (createdate != null) {
    getPopUpBannerData.createdate = createdate;
  }
  final int? view = jsonConvert.convert<int>(json['view']);
  if (view != null) {
    getPopUpBannerData.view = view;
  }
  final int? sequence = jsonConvert.convert<int>(json['sequence']);
  if (sequence != null) {
    getPopUpBannerData.sequence = sequence;
  }
  final int? clicks = jsonConvert.convert<int>(json['clicks']);
  if (clicks != null) {
    getPopUpBannerData.clicks = clicks;
  }
  final String? btype = jsonConvert.convert<String>(json['btype']);
  if (btype != null) {
    getPopUpBannerData.btype = btype;
  }
  return getPopUpBannerData;
}

Map<String, dynamic> $GetPopUpBannerDataToJson(GetPopUpBannerData entity) {
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

extension GetPopUpBannerDataExtension on GetPopUpBannerData {
  GetPopUpBannerData copyWith({
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
    return GetPopUpBannerData()
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