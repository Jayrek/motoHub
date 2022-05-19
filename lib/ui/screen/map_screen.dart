import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:motohub/data/model/route_argument.dart';

import '../../data/model/search_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required this.routeArgument}) : super(key: key);
  final RouteArgument routeArgument;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  late SearchModel searchModel;
  final Set<Marker> markers = {};

  Set<Marker> getMarkers() {
    setState(() {
      markers.add(Marker(
        markerId: MarkerId(
            '${searchModel.latitude.toString()}-${searchModel.longitude.toString()}'),
        position: LatLng(
            double.parse(searchModel.latitude.toString()),
            double.parse(
                searchModel.longitude.toString())), //position of marker
        infoWindow: InfoWindow(
            title: searchModel.item.toString(), snippet: 'Store name'),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
    });

    return markers;
  }

  @override
  void initState() {
    super.initState();
    searchModel = widget.routeArgument.param;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(searchModel.item.toString(),
                style: const TextStyle(fontSize: 18))),
        body: GoogleMap(
            markers: getMarkers(),
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(searchModel.latitude.toString()),
                    double.parse(searchModel.longitude.toString())),
                zoom: 18),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            }));
  }
}
