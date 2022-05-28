import 'package:flutter/cupertino.dart';

class ListFavoriteLocation extends StatefulWidget {
  const ListFavoriteLocation({Key? key}) : super(key: key);

  @override
  State<ListFavoriteLocation> createState() => _ListFavoriteLocationState();
}

class _ListFavoriteLocationState extends State<ListFavoriteLocation> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'No Favorites',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
    ));
  }
}
