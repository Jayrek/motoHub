import 'package:flutter/material.dart';
import 'package:motohub/data/model/location_model.dart';
import 'package:motohub/util/string_util.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late LocationModel locationModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    locationModel = Provider.of<LocationModel>(context);
    debugPrint(locationModel.latitude.toString());
    debugPrint(locationModel.longitude.toString());
    debugPrint('address: ${locationModel.addressName.toString()}');
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text('MotoHub',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87))),
        body: SingleChildScrollView(
            child: Column(children: [
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
                      style: const TextStyle(fontSize: 13)),
                  subtitle: Text(
                      '${locationModel.latitude.toString()} ${locationModel.longitude.toString()}',
                      style: const TextStyle(fontSize: 11)),
                  trailing: TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed(searchScreen),
                      child: const Text('Search Product')),
                  horizontalTitleGap: 5,
                  minLeadingWidth: 5,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 5))
        ])));
  }
}
