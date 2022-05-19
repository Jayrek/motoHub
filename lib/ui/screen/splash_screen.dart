import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:motohub/util/string_util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late PermissionStatus _permissionStatus;
  Location location = Location();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Text('Welcome to',
          style: TextStyle(fontSize: 20.0, color: Colors.black87)),
      const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text('MotoHub',
              style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87))),
      const SizedBox(height: 20),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              elevation: 3,
              minimumSize: const Size(200, 50)),
          onPressed: () => Navigator.of(context).pushNamed(searchScreen),
          child: const Text('Tap to continue', style: TextStyle(fontSize: 15))),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 40),
          child: Column(children: const [
            Text(
                'MotoHub helps you find the nearest and cheapest Motorcycle parts you need.'),
            SizedBox(height: 10),
            Text('Locates the nearest Motorcycle Shop partners with MotoHub.')
          ]))
    ])));
  }

  Future<void> _checkPermission() async {
    final PermissionStatus permissionResult = await location.hasPermission();
    setState(() => _permissionStatus = permissionResult);
    debugPrint('_permissionStatus $_permissionStatus');
  }

  Future<void> _requestPermission() async {
    if (_permissionStatus != PermissionStatus.granted) {
      final PermissionStatus result = await location.requestPermission();
      setState(() => _permissionStatus = result);
      if (_permissionStatus == PermissionStatus.denied) {
        await _requestPermission();
      }
    }
    debugPrint('result $_permissionStatus');
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await _checkPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text('Disclaimer',
                    style: Theme.of(context).textTheme.headline6!.merge(
                        const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87))),
                content: SingleChildScrollView(
                    child: ListBody(children: <Widget>[
                  Text(
                      "This app detects user's current location, which is use for searching the nearest shop.",
                      style: Theme.of(context).textTheme.headline6!.merge(
                          const TextStyle(fontSize: 18, color: Colors.black45)))
                ])),
                actions: <Widget>[
                  TextButton(
                      child: const Text('Allow'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _requestPermission();
                      })
                ]);
          });
    }
  }
}
