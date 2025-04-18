import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meteo/controller/weather_controller.dart';
import 'package:sizer/sizer.dart';


class DailyForecastListWidget extends StatelessWidget {
  const DailyForecastListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WeatherController>();
    return Obx(() {
      final displayCount = controller.dailyForecast.length > 10
          ? 10
          : controller.dailyForecast.length;
      return
      ListView.builder(
          itemCount: displayCount,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),

        itemBuilder: (context, index)  {
          final dailyForecast = controller.dailyForecast[index];

          return Card(
            color: Colors.white,
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: ListTile(
                leading: Text(
                  "${controller.getWeekDay(dailyForecast.date).split(",").last.trim()}\n${controller.getWeekDay(dailyForecast.date).split(",").first.trim()}",
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
                ),
                title: controller.getWeatherIconPath(dailyForecast.condition) != "assets/images/icon"
                    ? SizedBox(
                  width: 32,
                  height: 32,
                  child: Image.asset(
                    controller.getWeatherIconPath(dailyForecast.condition),
                    fit: BoxFit.contain,
                  ),
                )
                    : const Icon(Icons.cloud, color: Colors.blueAccent, size: 32),
                trailing: Text(
                  "${dailyForecast.tempMax.round()}°/${dailyForecast.tempMin.round()}°",
                  style: const TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        });
    }).paddingOnly(top: 55.h,left: 3.w, right: 2.w);
  }
}
