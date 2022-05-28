import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_time/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:world_time/bloc/navigation_bloc/navigation_event.dart';

class BottomNavigation extends StatefulWidget {
  BuildContext gContext;

  BottomNavigation({Key? key, required this.gContext}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time),
          label: 'Clock',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add Timezone',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Timezone List',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        if (index == 0) {
          BlocProvider.of<NavigationBloc>(context).add(ShowHomePage());
          print(NavigationBloc.currentEvent);
        } else if (index == 1) {
          BlocProvider.of<NavigationBloc>(context).add(ShowAddTimezonePage());
        } else {
          BlocProvider.of<NavigationBloc>(context).add(ShowListTimezonePage());
        }
      },
      showUnselectedLabels: false,
    );
  }
}
