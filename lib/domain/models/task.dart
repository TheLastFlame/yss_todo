import 'package:get_it/get_it.dart';
import "package:mobx/mobx.dart";
import 'package:yss_todo/domain/controllers/main.dart';
import 'package:yss_todo/domain/models/priority.dart';
import 'package:uuid/uuid.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable(includeIfNull: false)
class TaskModel {
  late String id;

  late Observable<String?> text;

  @JsonKey(toJson: _odtToJson, fromJson: _odtFromJson)
  late Observable<DateTime?> deadline;

  late Observable<Priority> importance;

  late Observable<bool> done;

  @JsonKey(toJson: _dtToJson, fromJson: _dtFromJson, name: 'created_at')
  late DateTime? createdAt;

  @JsonKey(toJson: _dtToJson, fromJson: _dtFromJson, name: 'changed_at')
  late DateTime? changedAt;

  @JsonKey(name: 'last_updated_by')
  late String lastUpdatedBy;

  TaskModel(
      {id,
      name,
      dueDate,
      priority = Priority.basic,
      isCompleted = false,
      createdAt,
      changedAt}) {
    this.id = id ?? const Uuid().v4();
    text = Observable(name);
    deadline = Observable(dueDate);
    importance = Observable(priority);
    done = Observable(isCompleted);
    this.createdAt = createdAt ?? DateTime.now();
    this.changedAt = changedAt ?? DateTime.now();
    lastUpdatedBy = GetIt.I<MainController>().deviceId;
  }

  //ужаснейший код для автогена. честно говоря, гораздо проще было вручную написать. но интереса ради...
  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  static int? _dtToJson(DateTime? value) => value?.millisecondsSinceEpoch;
  static DateTime? _dtFromJson(int? value) =>
      value != null ? DateTime.fromMillisecondsSinceEpoch(value) : null;

  static int? _odtToJson(Observable<DateTime?> value) =>
      value.value != null ? _dtToJson(value.value!) : null;

  static Observable<DateTime?> _odtFromJson(int? value) =>
      Observable(_dtFromJson(value));
}
