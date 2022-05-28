import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_time/bloc/navigation_bloc/navigation_event.dart';
import 'package:world_time/bloc/navigation_bloc/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  static NavigationEvent currentEvent = ShowHomePage();

  NavigationBloc(NavigationState initialState) : super(initialState) {
    on<ShowHomePage>((event, emit) => emit(ShowHomePageSuccess()));
    on<ShowAddTimezonePage>(
        (event, emit) => emit(ShowAddTimezonePageSuccess()));
    on<ShowListTimezonePage>(
        (event, emit) => emit(ShowListTimezonePageSuccess()));
  }
}
