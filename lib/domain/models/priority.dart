import 'package:flutter/material.dart';

import '../../i18n/strings.g.dart';

enum Priority { low, basic, important }

extension PriorityExtension on Priority {
  String get name {
    switch (this) {
      case Priority.low:
        return t.taskpage.low;
      case Priority.basic:
        return t.taskpage.regular;
      case Priority.important:
        return t.taskpage.hight;
    }
  }

  IconData get icon {
    switch (this) {
      case Priority.low:
        return Icons.arrow_downward;
      case Priority.basic:
        return Icons.fiber_manual_record_outlined;
      case Priority.important:
        return Icons.warning_amber_rounded;
    }
  }

  Color? get color {
    switch (this) {
      case Priority.important:
        return Colors.red;
      default:
        return null;
    }
  }
}
