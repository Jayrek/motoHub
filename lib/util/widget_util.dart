import 'package:flutter/material.dart';

showSnackBar(BuildContext ctx, String msg) {
  return ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg)));
}

const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

const colorizeTextStyle = TextStyle(
  fontSize: 50.0,
  fontFamily: 'Horizon',
);
