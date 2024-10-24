import 'package:flutter/material.dart';
import 'package:beauty_solution_seller_app/beauty_station_app.dart';
import 'package:beauty_solution_seller_app/services/services_init.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  await initServices();

  runApp(
    Phoenix(child: const BeautyStationApp()), // Wrap your app
  );
}

Future<void> initServices() async {
  await ServicesInit().init();
}
