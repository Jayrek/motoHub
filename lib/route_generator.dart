import 'package:flutter/material.dart';
import 'package:motohub/ui/screen/map_screen.dart';
import 'package:motohub/ui/screen/result_screen.dart';
import 'package:motohub/ui/screen/search_screen.dart';
import 'package:motohub/ui/screen/splash_screen.dart';
import 'package:motohub/util/string_util.dart';

import 'data/model/route_argument.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case searchScreen:
        return MaterialPageRoute(
            builder: (_) =>
                SearchScreen(routeArgument: RouteArgument(param: args)));
      case resultScreen:
        return MaterialPageRoute(
            builder: (_) =>
                ResultScreen(routeArgument: RouteArgument(param: args)));
      case mapScreen:
        return MaterialPageRoute(
            builder: (_) =>
                MapScreen(routeArgument: RouteArgument(param: args)));
      default:
        return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
