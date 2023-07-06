// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'],
      createdAt: TaskModel._dtFromJson(json['created_at'] as int?),
      changedAt: TaskModel._dtFromJson(json['changed_at'] as int?),
    )
      ..text = Observable(json['text'] as String?)
      ..deadline = TaskModel._odtFromJson(json['deadline'] as int?)
      ..importance =
          Observable($enumDecode(_$PriorityEnumMap, json['importance']))
      ..done = Observable(json['done'] as bool)
      ..lastUpdatedBy = json['last_updated_by'] as String;

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'text': (instance.text).value,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('deadline', TaskModel._odtToJson(instance.deadline));
  val['importance'] = _$PriorityEnumMap[(instance.importance).value]!;
  val['done'] = (instance.done).value;
  writeNotNull('created_at', TaskModel._dtToJson(instance.createdAt));
  writeNotNull('changed_at', TaskModel._dtToJson(instance.changedAt));
  val['last_updated_by'] = instance.lastUpdatedBy;
  return val;
}

const _$PriorityEnumMap = {
  Priority.low: 'low',
  Priority.basic: 'basic',
  Priority.important: 'important',
};
