import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meteo/views/pages/weather_page.dart';
import 'package:sizer/sizer.dart';
import 'package:timezone/data/latest.dart' as tz;
void main() {
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
         debugShowCheckedModeBanner: false,
         home: WeatherPage(),
        );
      }
    );
  }
}
