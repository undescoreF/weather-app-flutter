import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meteo/controller/weather_controller.dart';
import 'package:sizer/sizer.dart';

class HourlyForecastListWidget extends StatelessWidget {
  const HourlyForecastListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WeatherController>();

    return SizedBox(
      height: 110,
      child: Obx(() {
        final hourlyForecast = controller.hourlyForecast;
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: hourlyForecast.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, index) {

            return Container(
              width: 80,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(index != 0 ? "${hourlyForecast[index].time.hour}:00" : "Now",
                    style: const TextStyle(fontWeight: FontWeight.w400,color: Colors.white70),),

                  SizedBox(
                    width: 32,
                    height: 32,
                    child: Image.asset(
                      controller.getWeatherIconPath(hourlyForecast[index].condition),
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    index != 0 ? "${hourlyForecast[index].temperature.round()}°C" : "${controller.temperature.round()}°C",
                    style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ],
              ),
            );
          },
        );
      }),
    ).paddingOnly(top: 6.h);
  }
}
