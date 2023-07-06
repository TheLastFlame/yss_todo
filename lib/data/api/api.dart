import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:yss_todo/domain/models/task.dart';

import '../../domain/models/resstatuses.dart';

const host = String.fromEnvironment('HOST');
const token = "Bearer ${const String.fromEnvironment('TOKEN')}";

class TasksAPI {
  String lastKnownRevision = '0';

  Future<Map<String, dynamic>> getAll() async {
    try {
      var res = await http.get(
        Uri.parse('$host/list'),
        headers: {"Authorization": token},
      );
      switch (res.statusCode) {
        case 200:
          final Map<String, dynamic> json = jsonDecode(res.body);
          lastKnownRevision = json['revision'].toString();
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
    } catch (e) {
      return {
        'status': ResponseStatus.noInternet,
      };
    }
  }

  Future<Map<String, dynamic>> updateAll(List<TaskModel> tasks) async {
    try {
      var res = await http.patch(
        Uri.parse('$host/list'),
        headers: {
          "Authorization": token,
          'X-Last-Known-Revision': lastKnownRevision
        },
        body: '{"list": [${tasks.map(
              (e) => jsonEncode(e.toJson()),
            ).join(", ")}]}',
      );
      switch (res.statusCode) {
        case 200:
          final Map<String, dynamic> json = jsonDecode(res.body);
          lastKnownRevision = json['revision'].toString();
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
    } catch (e) {
      return {
        'status': ResponseStatus.noInternet,
      };
    }
  }

  Future<ResponseStatus> addTask(TaskModel task) async {
    try {
      var res = await http.post(
        Uri.parse('$host/list'),
        headers: {
          "Authorization": token,
          'X-Last-Known-Revision': lastKnownRevision
        },
        body: '{"element": ${jsonEncode(task.toJson())}}',
      );
      switch (res.statusCode) {
        case 200:
          final Map<String, dynamic> json = jsonDecode(res.body);
          lastKnownRevision = json['revision'].toString();
          return ResponseStatus.normal;
        case 500:
          return ResponseStatus.iternalProblem;
        default:
          return ResponseStatus.badRequest;
      }
    } catch (e) {
      return ResponseStatus.noInternet;
    }
  }

  Future<ResponseStatus> editTask(TaskModel task) async {
    try {
      var res = await http.put(
        Uri.parse('$host/list/${task.id}'),
        headers: {
          "Authorization": token,
          'X-Last-Known-Revision': lastKnownRevision
        },
        body: '{"element": ${jsonEncode(task.toJson())}}',
      );
      switch (res.statusCode) {
        case 200:
          final Map<String, dynamic> json = jsonDecode(res.body);
          lastKnownRevision = json['revision'].toString();
          return ResponseStatus.normal;
        case 500:
          return ResponseStatus.iternalProblem;
        default:
          return ResponseStatus.badRequest;
      }
    } catch (e) {
      return ResponseStatus.noInternet;
    }
  }

  Future<ResponseStatus> deleteTask(String id) async {
    try {
      var res = await http.delete(
        Uri.parse('$host/list/$id'),
        headers: {
          "Authorization": token,
          'X-Last-Known-Revision': lastKnownRevision
        },
      );
      switch (res.statusCode) {
        case 200:
          final Map<String, dynamic> json = jsonDecode(res.body);
          lastKnownRevision = json['revision'].toString();
          return ResponseStatus.normal;
        case 500:
          return ResponseStatus.iternalProblem;
        default:
          return ResponseStatus.badRequest;
      }
    } catch (e) {
      return ResponseStatus.noInternet;
    }
  }

  TasksAPI._init();

  static Future<TasksAPI> init() async {
    var controller = TasksAPI._init();
    return controller;
  }
}
