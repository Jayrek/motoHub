import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:motohub/data/model/route_argument.dart';

import '../../data/model/search_product_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required this.routeArgument}) : super(key: key);
  final RouteArgument routeArgument;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  late Datum datum;
  final Set<Marker> markers = {};

  Set<Marker> getMarkers() {
    setState(() {
      markers.add(Marker(
        markerId: MarkerId('${datum.lat.toString()}-${datum.long.toString()}'),
        position: LatLng(double.parse(datum.lat.toString()),
            double.parse(datum.long.toString())), //position of marker
        infoWindow: InfoWindow(
            title: datum.storeName.toString(), snippet: 'Store name'),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
    });

    return markers;
  }

  @override
  void initState() {
    super.initState();
    datum = widget.routeArgument.param;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                const Text('Store Location', style: TextStyle(fontSize: 18))),
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
              child: GoogleMap(
                  markers: getMarkers(),
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse(datum.lat.toString()),
                          double.parse(datum.long.toString())),
                      zoom: 18),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  })),
          Container(
              color: Colors.white,
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 20, left: 15),
                        child: Text(datum.storeName.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20))),
                    const SizedBox(height: 10),
                    const Divider(height: 1, endIndent: 20, indent: 20),
                    ListTile(
                        leading: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.location_on_rounded,
                                color: Colors.red)),
                        title: Text(datum.storeLocation.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45)),
                        subtitle: Text(
                            '${datum.distance!.toStringAsFixed(2).toString()} km',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45))),
                    const Divider(height: 1, endIndent: 20, indent: 20)
                  ]))
        ]));
  }
}
