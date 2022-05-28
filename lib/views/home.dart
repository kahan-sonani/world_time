import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:time_text/time_text.dart';
import 'package:world_time/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:world_time/bloc/navigation_bloc/navigation_state.dart';
import 'package:world_time/classes/timezone_data.dart';
import 'package:world_time/main.dart';
import 'package:world_time/views/choose_location.dart';
import 'package:world_time/views/list_location.dart';
import 'package:world_time/widgets/bottom_navigation.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  Widget? getNavigationPage(NavigationState state) {
    if (state is ShowAddTimezonePageSuccess) {
      return Location();
    } else if (state is ShowListTimezonePageSuccess) {
      return const ListFavoriteLocation();
    }
    return null;
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: widget.getNavigationPage(state) ??
              Consumer<TimezoneData>(builder: (context, provider, child) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnalogClock(
                        height: 220.0,
                        decoration: BoxDecoration(
                            border: Border.all(width: 2.0, color: Colors.white),
                            color: Colors.transparent,
                            shape: BoxShape.circle),
                        width: 200.0,
                        isLive: true,
                        hourHandColor: Colors.white,
                        minuteHandColor: Colors.white,
                        showSecondHand: true,
                        secondHandColor: Palette.primary,
                        numberColor: Colors.white70,
                        showNumbers: true,
                        showAllNumbers: true,
                        textScaleFactor: 1.4,
                        showTicks: true,
                        showDigitalClock: false,
                        datetime: provider.localTime,
                      ),
                      TimeText(
                        style: const TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.w100,
                            color: Colors.white),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(80, 5, 80, 0),
                          child: Text(
                            provider.calculateArea(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                      Text(
                        provider.calculateState(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              padding: const EdgeInsets.all(20),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text: provider.calculateAddress()));
                                const snackBar = SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text('Address copied to clipboard!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              icon: const Icon(Icons.copy)),
                          IconButton(
                              onPressed: () async {
                                await provider.updateLocation();
                              },
                              icon: const Icon(Icons.refresh)),
                        ],
                      )
                    ],
                  ),
                );
              }),
          bottomNavigationBar: BottomNavigation(gContext: context),
        );
      },
    );
  }
}
