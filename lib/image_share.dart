import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class ImageShare {
  ImageShare.toInstagram({@required this.imageUrl}) : assert(imageUrl != null);

  ImageShare(
      {@required this.androidPackageId,
      @required this.iosPackageId,
      @required this.imageUrl,
      String iosAppId}) {
    iosAppId = iosAppId ?? this.iosPackageId;
  }

  static const MethodChannel _channel =
      MethodChannel('de/brandad-systems/socialdear/image_share');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static const String PATH = 'path';
  static const String IOS_PACKAGE_ID = 'IOS_PACKAGE_ID';
  static const String IOS_APP_ID = 'IOS_APP_ID';
  static const String ANDROID_ID = 'ANDROID_ID';

  String androidPackageId = 'com.instagram.android';
  String iosPackageId = 'com.instagram.exclusivegram';
  String iosAppId = 'instagram://app';
  String imageUrl;

  Future<void> share(
      {Function(BuildContext) onAppNotInstalled, BuildContext context}) async {
    if (!await isPackageInstalled(
        iosPackageId: iosPackageId,
        androidId: androidPackageId,
        iosAppId: iosAppId)) {
      if (onAppNotInstalled != null && context != null) {
        onAppNotInstalled(context);
      }
    } else {
      final Map<String, dynamic> params = <String, dynamic>{};

      params[PATH] = imageUrl;
      params[ANDROID_ID] = androidPackageId;
      params[IOS_APP_ID] = iosAppId;
      params[IOS_PACKAGE_ID] = iosPackageId;

      _channel.invokeMethod<void>('share', params);
    }
  }

  static Future<bool> isPackageInstalled(
      {@required String iosPackageId,
      @required String androidId,
      String iosAppId}) {
    final Map<String, dynamic> params = <String, String>{};

    params[ANDROID_ID] = androidId;
    params[IOS_APP_ID] = iosAppId ?? iosPackageId;
    params[IOS_PACKAGE_ID] = iosPackageId;

    return _channel.invokeMethod('isPackageInstalled', params);
  }

  @override
  String toString() {
    return 'Share{path: $imageUrl}';
  }
}
