import 'package:flutter/material.dart';
import 'package:beauty_solution_seller_app/beauty_station_app.dart';
import 'package:beauty_solution_seller_app/services/services_init.dart';

void main() async {
  await initServices();

  runApp(
    const BeautyStationApp(), // Wrap your app
  );
}

Future<void> initServices() async {
  await ServicesInit().init();
}
