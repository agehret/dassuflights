import 'package:flutter/material.dart';
import 'package:flights_app/ui/ui_styles.dart';
import 'package:flights_app/ui/flights_list.dart';

void main() async {
  runApp(FlightsApp());
}


class FlightsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dassu Flüge',
      theme: ThemeData(
        primarySwatch: colorDassu,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FlightsList(title: 'Dassu Flüge'),
    );
  }
}


