import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:yss_todo/logger.dart';

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
  var primaryColor = Observable<Color?>(null);

  static void _initCrashlytics() {
    FlutterError.onError = (errorDetails) {
      logger.e('onError in Flutter');
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      logger.e('onError in PlatformDispatcher');
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    logger.i('Crashlytics inited');
  }

  MainController._init() {
    _initCrashlytics();
  }

  static Future<MainController> init({bool isTest = false}) async {
    var controller = MainController._init();

    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    await remoteConfig.fetchAndActivate();
    final color = int.tryParse(
      remoteConfig.getString('color').substring(1),
      radix: 16,
    );
    runInAction(
      () => controller.primaryColor.value = color != null ? Color(color) : null,
    );

    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
      logger.i(remoteConfig.getString('color'));
      final color = int.tryParse(
        remoteConfig.getString('color').substring(1),
        radix: 16,
      );
      runInAction(
        () =>
            controller.primaryColor.value = color != null ? Color(color) : null,
      );
    });

    controller.deviceId = isTest ? 'test' : await _getId();
    return controller;
  }
}
