import '../../i18n/strings.g.dart';

enum ResponseStatus {
  normal,
  badRequest,
  iternalProblem,
  noInternet,
}

extension RSExtension on ResponseStatus {
  String get text {
    switch (this) {
      case ResponseStatus.normal:
      case ResponseStatus.iternalProblem:
        return t.errors.iternal;
      case ResponseStatus.noInternet:
        return t.errors.no_internet;
      default:
        return t.errors.unknown;
    }
  }
}