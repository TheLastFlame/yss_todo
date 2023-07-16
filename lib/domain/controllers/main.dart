import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

Future<String> _getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (kIsWeb) {
    // The web doesnt have a device UID, so use a combination fingerprint
    WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
    return (webInfo.vendor ?? '') +
        (webInfo.userAgent ?? '') +
        webInfo.hardwareConcurrency.toString();
  }
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor ?? 'undefined IOS';
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.id;
  } else if (Platform.isWindows) {
    var windowsDeviceInfo = await deviceInfo.windowsInfo;
    return windowsDeviceInfo.productId;
  }
  return 'unknown';
}

class MainController {
  late final String deviceId;
  MainController._init();

  static Future<MainController> init({bool isTest = false}) async {
    var controller = MainController._init();
    controller.deviceId = isTest ? 'test' : await _getId();
    return controller;
  }
}
