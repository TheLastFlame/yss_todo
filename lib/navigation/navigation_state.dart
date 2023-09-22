class NavigationState {
  final bool? _new;

  String? selectedTaskId;

  bool get isNewTaskPage => _new == true;

  bool get isTaskPage => selectedTaskId != null;

  bool get isRoot => !isNewTaskPage && !isTaskPage;

  NavigationState.root()
      : _new = false,
        selectedTaskId = null;

  NavigationState.creating()
      : _new = true,
        selectedTaskId = null;

  NavigationState.task(this.selectedTaskId) : _new = false;
}
