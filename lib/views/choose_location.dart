import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_time/classes/timezone_data.dart';
import 'package:world_time/main.dart';

class Location extends StatefulWidget {
  Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final searchTextController = TextEditingController();
  TimezoneData? data;
  List<dynamic>? locations;

  @override
  Widget build(BuildContext context) {
    data = Provider.of<TimezoneData>(context, listen: false);
    locations = data?.locations!.keys.toList();

    return Scaffold(
        appBar: AppBar(
            // The search area here
            title: Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              controller: searchTextController,
              onChanged: searchLocation,
              cursorColor: Palette.primary,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Palette.primary,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Palette.primary,
                    ),
                    onPressed: () {
                      searchTextController.text = '';
                    },
                  ),
                  hintText: 'Search Timezones',
                  border: InputBorder.none),
            ),
          ),
        )),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          itemCount: locations?.length,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Image.network(
                      'https://countryflagsapi.com/png/${data?.locations?.keys.elementAt(index).split("/")[0]}',
                      height: 30,
                      width: 30,
                      loadingBuilder: (context, child, loadingProgress) =>
                          (loadingProgress == null)
                              ? child
                              : const CircularProgressIndicator(),
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.flag_sharp,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(locations?.elementAt(index))
                  ],
                ),
                decoration: const BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.all(Radius.circular(
                          5.0) //                 <--- border radius here
                      ),
                ));
          },
        ));
  }

  void searchLocation(String value) {
    print('sdfsdf');
    final flocations = data?.locations?.keys
        .where((element) => element.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {
      locations = flocations;
    });
  }
}
