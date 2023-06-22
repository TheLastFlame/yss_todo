import "package:mobx/mobx.dart";
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

  @JsonKey(toJson: _dtToJson, fromJson: _dtFromJson)
  // ignore: non_constant_identifier_names
  late DateTime? created_at;

  @JsonKey(toJson: _dtToJson, fromJson: _dtFromJson)
  // ignore: non_constant_identifier_names
  late DateTime? changed_at;

  // ignore: non_constant_identifier_names
  late String last_updated_by;

  TaskModel(
      {id,
      name,
      description,
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
    created_at = createdAt ?? DateTime.now();
    changed_at = changedAt ?? DateTime.now();
    last_updated_by = 'test';
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
