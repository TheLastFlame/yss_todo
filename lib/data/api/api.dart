import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:yss_todo/domain/models/task.dart';

import '../../domain/models/resstatuses.dart';

const host = String.fromEnvironment('HOST');
const token = "Bearer ${const String.fromEnvironment('TOKEN')}";

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
  return 'unknown';
}

class TasksAPI {
  late final String deviceId;
  String lastKnownRevision = '0';

  Future<Map<String, dynamic>> getAll() async {
    var res = await http.get(
      Uri.parse('$host/list'),
      headers: {"Authorization": token, 'X-Generate-Fails': '100'},
    );
    print('object');
    switch (res.statusCode) {
      case 200:
        final Map<String, dynamic> json = jsonDecode(res.body);
        return {
          'status': ResponseStatus.normal,
          'tasks': (json['list'] as List).map((e) => TaskModel.fromJson(e)),
        };
      case 500:
        return {
          'status': ResponseStatus.iternalProblem,
        };
      default:
        return {
          'status': ResponseStatus.badRequest,
        };
    }
  }

  TasksAPI._init();

  static Future<TasksAPI> init() async {
    var controller = TasksAPI._init();
    controller.deviceId = await _getId();
    return controller;
  }
}
