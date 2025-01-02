import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

Future<String> createDynamicLink(
    String url, String targetScreen, String data) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://mlmdiary.page.link',
    link: Uri.parse('$url?screen=$targetScreen&data=$data'),
    androidParameters: const AndroidParameters(
      packageName: 'com.mlm.mlmdiary',
      minimumVersion: 1,
    ),
    iosParameters: const IOSParameters(
      bundleId: 'com.mlm.mlmdiary',
      minimumVersion: '1.0.1',
    ),
  );

  final Uri dynamicUrl =
      // ignore: deprecated_member_use
      await FirebaseDynamicLinks.instance.buildLink(parameters);
  return dynamicUrl.toString();
}
