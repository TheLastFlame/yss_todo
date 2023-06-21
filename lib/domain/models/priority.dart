import 'package:flutter/material.dart';

import '../../i18n/strings.g.dart';

enum Priority {
  low,
  regular,
  high
}

extension PriorityExtension on Priority {
  String get name {
    switch (this) {
      case Priority.low:
        return t.taskpage.low;
      case Priority.regular:
        return t.taskpage.regular;
      case Priority.high:
        return t.taskpage.hight;
    }
  }
  IconData get icon {
    switch (this) {
      case Priority.low:
        return Icons.arrow_downward;
      case Priority.regular:
        return Icons.fiber_manual_record_outlined;
      case Priority.high:
        return Icons.warning_amber_rounded;
    }
  }
  Color? get color {
    switch (this) {
      case Priority.high:
        return Colors.red;
      default:
        return null;
    }
  }
}