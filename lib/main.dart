import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motohub/data/repository/repository_implementation.dart';
import 'package:provider/provider.dart';

import 'data/model/location_model.dart';
import 'route_generator.dart';
import 'service/location_service.dart';
import 'util/string_util.dart';
import 'vmodel/search_vmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        StreamProvider<LocationModel>(
            initialData: LocationModel(),
            create: (context) => LocationService().locationStream),
        ChangeNotifierProvider<SearchViewModel>(
            create: (context) => SearchViewModel(RepositoryImpl()))
      ],
      child: MaterialApp(
          title: 'MotoHub',
          initialRoute: splash,
          onGenerateRoute: RouteGenerator.generateRoute,
          debugShowCheckedModeBanner: false,
          theme:
              ThemeData(fontFamily: 'Quicksand', primarySwatch: Colors.blue)),
    );
  }
}
