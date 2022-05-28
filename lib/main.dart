import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:world_time/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:world_time/bloc/navigation_bloc/navigation_state.dart';
import 'package:world_time/classes/timezone_data.dart';
import 'package:world_time/views/loading.dart';

const appName = 'World Time';

class Palette {
  static const primary = Colors.tealAccent;
}

void main() async {
  runApp(BlocProvider<NavigationBloc>(
    create: (context) => NavigationBloc(ShowHomePageSuccess()),
    child: ChangeNotifierProvider<TimezoneData>(
      create: (context) => TimezoneData(),
      child: MaterialApp(
        title: 'World Time',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeData.dark(),
        home: const Loading(),
      ),
    ),
  ));
}
