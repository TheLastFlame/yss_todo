import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class MainController {
  late final String deviceId;

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor ?? 'undefined IOS';
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    } else if (Platform.isWindows) {
      var windowsDeviceInfo = await deviceInfo.windowsInfo;
      return windowsDeviceInfo.productId;
    } else if (kIsWeb) {
      // The web doesnt have a device UID, so use a combination fingerprint 
      WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
      return (webInfo.vendor ?? '') +
          (webInfo.userAgent ?? '') +
          webInfo.hardwareConcurrency.toString();
    }
    return 'unknown'; // unknown
  }

  MainController._init();

  static Future<MainController> init() async {
    var controller = MainController._init();
    controller.deviceId = await controller._getId();
    return controller;
  }
}
