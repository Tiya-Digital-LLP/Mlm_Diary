import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/outlined_button.dart';

class Utility {
  static setLightStatusBar() {
    return SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(
            statusBarColor: AppColors.primaryColor,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light));
  }

  static setDarkStatusBar() {
    return SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(
            statusBarColor: AppColors.primaryColor,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark));
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static String convertDateFormat(String date) {
    if (date.isNotEmpty) {
      final inputTimestamp = DateTime.parse(date);
      final outputFormat = DateFormat("[MMM dd]");
      final formattedDateTime = outputFormat.format(inputTimestamp);
      return formattedDateTime;
    } else {
      return '';
    }
  }

  static PopupMenuItem buildPopupMenuItem(
      String title, IconData? iconData, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        children: [
          if (iconData != null)
            Icon(
              iconData,
              size: 20,
              color: Colors.black,
            ),
          if (iconData != null)
            const SizedBox(
              width: 10,
            ),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  static showBottomSheetAlert(
      {required VoidCallback onNegativePressed,
      required VoidCallback onPositivePressed,
      required String negativeButtonText,
      required String positiveButtonText,
      required String message,
      required String iconPath}) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: AppColors.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        builder: (context) {
          return SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      iconPath,
                      height: 40,
                      width: 40,
                      fit: BoxFit.fill,
                    ).marginOnly(top: 20),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1.3),
                    ).marginOnly(top: 20),
                    Row(
                      children: [
                        Expanded(
                            child: LinedButton(
                          onPressed: onNegativePressed,
                          text: negativeButtonText,
                        )),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ).marginOnly(top: 20, bottom: 20)
                  ],
                ).marginSymmetric(horizontal: 16),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      splashRadius: 20,
                      iconSize: 20,
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  static bool isValidUrl(String? str,
      {List<String?> protocols = const ['http', 'https', 'ftp'],
      bool requireTld = true,
      bool requireProtocol = false,
      bool allowUnderscore = false,
      List<String> hostWhitelist = const [],
      List<String> hostBlacklist = const []}) {
    if (str == null ||
        str.isEmpty ||
        str.length > 2083 ||
        str.startsWith('mailto:')) {
      return false;
    }

    // ignore: prefer_typing_uninitialized_variables
    var protocol,
        // ignore: prefer_typing_uninitialized_variables
        user,
        // ignore: prefer_typing_uninitialized_variables
        auth,
        // ignore: prefer_typing_uninitialized_variables
        host,
        // ignore: prefer_typing_uninitialized_variables
        hostname,
        // ignore: prefer_typing_uninitialized_variables
        port,
        // ignore: prefer_typing_uninitialized_variables
        portStr,
        // ignore: prefer_typing_uninitialized_variables
        path,
        // ignore: prefer_typing_uninitialized_variables
        query,
        // ignore: prefer_typing_uninitialized_variables
        hash,
        // ignore: prefer_typing_uninitialized_variables
        split;

    // check protocol
    split = str.split('://');
    if (split.length > 1) {
      protocol = shift(split);
      if (!protocols.contains(protocol)) {
        return false;
      }
    } else if (requireProtocol == true) {
      return false;
    }
    str = split.join('://');

    // check hash
    split = str!.split('#');
    str = shift(split);
    hash = split.join('#');
    if (hash != null && hash != "" && RegExp(r'\s').hasMatch(hash)) {
      return false;
    }

    // check query params
    split = str!.split('?');
    str = shift(split);
    query = split.join('?');
    if (query != null && query != "" && RegExp(r'\s').hasMatch(query)) {
      return false;
    }

    // check path
    split = str!.split('/');
    str = shift(split);
    path = split.join('/');
    if (path != null && path != "" && RegExp(r'\s').hasMatch(path)) {
      return false;
    }

    // check auth type urls
    split = str!.split('@');
    if (split.length > 1) {
      auth = shift(split);
      if (auth.indexOf(':') >= 0) {
        auth = auth.split(':');
        user = shift(auth);
        if (!RegExp(r'^\S+$').hasMatch(user)) {
          return false;
        }
        if (!RegExp(r'^\S*$').hasMatch(user)) {
          return false;
        }
      }
    }

    // check hostname
    hostname = split.join('@');
    split = hostname.split(':');
    host = shift(split);
    if (split.length > 0) {
      portStr = split.join(':');
      try {
        port = int.parse(portStr, radix: 10);
      } catch (e) {
        return false;
      }
      if (!RegExp(r'^[0-9]+$').hasMatch(portStr) || port <= 0 || port > 65535) {
        return false;
      }
    }

    if (!isIP(host) &&
        !isFQDN(host,
            requireTld: requireTld, allowUnderscores: allowUnderscore) &&
        host != 'localhost') {
      return false;
    }

    if (hostWhitelist.isNotEmpty && !hostWhitelist.contains(host)) {
      return false;
    }

    if (hostBlacklist.isNotEmpty && hostBlacklist.contains(host)) {
      return false;
    }

    return true;
  }

  static shift(List l) {
    if (l.isNotEmpty) {
      var first = l.first;
      l.removeAt(0);
      return first;
    }
    return null;
  }

  static final RegExp _ipv4Maybe =
      RegExp(r'^(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)$');
  static final RegExp _ipv6 =
      RegExp(r'^::|^::1|^([a-fA-F0-9]{1,4}::?){1,7}([a-fA-F0-9]{1,4})$');

  static bool isIP(String? str, [/*<String | int>*/ version]) {
    version = version.toString();
    if (version == 'null') {
      return isIP(str, 4) || isIP(str, 6);
    } else if (version == '4') {
      if (!_ipv4Maybe.hasMatch(str!)) {
        return false;
      }
      var parts = str.split('.');
      parts.sort((a, b) => int.parse(a) - int.parse(b));
      return int.parse(parts[3]) <= 255;
    }
    return version == '6' && _ipv6.hasMatch(str!);
  }

  /// check if the string [str] is a fully qualified domain name (e.g. domain.com).
  ///
  /// * [requireTld] sets if TLD is required
  /// * [allowUnderscore] sets if underscores are allowed
  static bool isFQDN(String str,
      {bool requireTld = true, bool allowUnderscores = false}) {
    var parts = str.split('.');
    if (requireTld) {
      var tld = parts.removeLast();
      if (parts.isEmpty || !RegExp(r'^[a-z]{2,}$').hasMatch(tld)) {
        return false;
      }
    }

    for (var part in parts) {
      if (allowUnderscores) {
        if (part.contains('__')) {
          return false;
        }
      }
      if (!RegExp(r'^[a-z\\u00a1-\\uffff0-9-]+$').hasMatch(part)) {
        return false;
      }
      if (part[0] == '-' ||
          part[part.length - 1] == '-' ||
          part.contains('---')) {
        return false;
      }
    }
    return true;
  }
}
