import 'package:flutter/material.dart';
import 'package:motohub/data/model/route_argument.dart';
import 'package:motohub/data/model/search_model.dart';
import 'package:motohub/util/string_util.dart';
import 'package:provider/provider.dart';

import '../../data/model/location_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.routeArgument}) : super(key: key);
  final RouteArgument routeArgument;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late LocationModel locationModel;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    locationModel = Provider.of<LocationModel>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(mainAxisSize: MainAxisSize.min, children: [
          Column(children: [
            const SizedBox(height: 40),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Good day!',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)))),
            locationModel.addressName == null &&
                    locationModel.latitude == null &&
                    locationModel.longitude == null
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(children: const [
                      SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.blue)),
                      SizedBox(width: 10),
                      Text('Fetching location...',
                          style: TextStyle(
                              fontSize: 12, fontStyle: FontStyle.italic))
                    ]))
                : ListTile(
                    leading: const Padding(
                        padding: EdgeInsets.all(8),
                        child:
                            Icon(Icons.location_on_rounded, color: Colors.red)),
                    title: Text(
                        locationModel.addressName.toString().isEmpty
                            ? 'Loading...'
                            : locationModel.addressName.toString(),
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        '${locationModel.latitude.toString()} ${locationModel.longitude.toString()}',
                        style: const TextStyle(fontSize: 11)),
                    horizontalTitleGap: 5,
                    minLeadingWidth: 5,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 5))
          ]),
          const Divider(height: 1, endIndent: 20, indent: 20),
          const SizedBox(height: 40),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('MotoHub',
                  style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87))),
          Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                  enabled: true,
                  autofocus: true,
                  onChanged: (input) {
                    setState(() {
                      isType();
                    });
                  },
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.words,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      label: const Text('What you are looking for?',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      filled: true,
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.grey[800]),
                      hintText: 'Looking for cheapest motor parts?',
                      fillColor: Colors.white70),
                  controller: searchController)),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  elevation: 3,
                  minimumSize: const Size(200, 50)),
              onPressed: isType()
                  ? () {
                      Navigator.of(context).pushNamed(resultScreen,
                          arguments: SearchModel(
                              latitude: locationModel.latitude.toString(),
                              longitude: locationModel.longitude.toString(),
                              item: searchController.text));
                    }
                  : null,
              child:
                  const Text('Tap to search', style: TextStyle(fontSize: 15)))
        ]));
  }

  bool isType() {
    return searchController.text.isNotEmpty && locationModel.longitude != null;
  }
}
