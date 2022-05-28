import 'package:flutter/cupertino.dart';

@immutable
abstract class NavigationEvent {}

class ShowAddTimezonePage extends NavigationEvent {
  @override
  String toString() {
    return "ShowAddTimezonePage";
  }
}

class ShowHomePage extends NavigationEvent {
  @override
  String toString() {
    return "ShowHomePage";
  }
}

class ShowListTimezonePage extends NavigationEvent {
  @override
  String toString() {
    return "ShowListTimezonePage";
  }
}
