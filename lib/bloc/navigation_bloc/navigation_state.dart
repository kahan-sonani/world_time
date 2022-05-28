import 'package:flutter/widgets.dart';

@immutable
abstract class NavigationState {}

class ShowAddTimezonePageSuccess extends NavigationState {
  @override
  String toString() {
    return "ShowAddTimezonePageSuccess";
  }
}

class ShowHomePageSuccess extends NavigationState {
  @override
  String toString() {
    return "ShowHomePageSuccess";
  }
}

class ShowListTimezonePageSuccess extends NavigationState {
  @override
  String toString() {
    return "ShowListTimezonePageSuccess";
  }
}
