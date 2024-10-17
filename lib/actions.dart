/*
class MyAction {
  dynamic object;
  dynamic valueStart;
  dynamic valueEnd;
  String variableName;
  MyAction(this.object, this.valueStart, this.valueEnd, this.variableName);

  @override
  String toString() {
    return 'MyAction{object: $object, valueStart: $valueStart, valueEnd: $valueEnd, variableName: $variableName}';
  }
}

class MyActions {
  List<MyAction> actions = [];
  int _currentIndex = -1;

  void addAction(MyAction action) {
    if (_currentIndex < actions.length - 1) {
      actions = actions.sublist(0, _currentIndex + 1);
    }
    actions.add(action);
    _currentIndex++;
  }

  void undo() {
    if (_currentIndex >= 0) {
      _currentIndex--;
    }
    MyAction? a = currentAction;
    if (a != null) {
      a.object.setVal(a.valueStart, a.variableName);
    }
  }

  void redo() {
    if (_currentIndex < actions.length - 1) {
      _currentIndex++;
    }

    MyAction? a = currentAction;
    if (a != null) {
      a.object.setVal(a.valueEnd, a.variableName);
    }
  }

  MyAction? get currentAction {
    if (_currentIndex >= 0 && _currentIndex < actions.length) {
      return actions[_currentIndex];
    }
    return null;
  }
}
*/