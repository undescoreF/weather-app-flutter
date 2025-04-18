import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meteo/controller/weather_controller.dart';
import 'package:sizer/sizer.dart';
import '../widgets/current_weather_box.dart';
import '../widgets/daily_list.dart';
import '../widgets/hourly_list.dart';


class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherController controller = Get.put(WeatherController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if(controller.dailyForecast.isEmpty) {
          return Center(child: CircularProgressIndicator(color: Colors.blue));
        }
          return SingleChildScrollView(
            child: Stack(
              children: [
                CurrentWeatherBoxWidget(),
                HourlyForecastListWidget().paddingOnly(top: 30.h, left: 5.w),
                const Text("10-day Forecast",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue,fontSize: 16)
                ).paddingOnly(top: 55.h,left: 4.w),
                DailyForecastListWidget(),
              ],
            ),
          );
        }
      ),
    );
  }
}
