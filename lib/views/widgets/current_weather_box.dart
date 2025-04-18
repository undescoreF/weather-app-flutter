import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meteo/controller/weather_controller.dart';
import 'package:sizer/sizer.dart';
import '../pages/search_page.dart';

class CurrentWeatherBoxWidget extends StatelessWidget {
  const CurrentWeatherBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WeatherController>();

    return  Container(
      height: 55.h,
      width: 100.w,
      decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(200, 80), bottomRight: Radius.elliptical(200, 80),),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF6BA9D6), // top
            Color(0xFF5A9BCB), // middle
            Color(0xFF4A89BD), // bottom
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: 5.h,
              width: 100.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu,color: Colors.white, size: 30,).paddingOnly(left: 3.w),
                  Text(
                    "📍 ${controller.searchPlaceController.placeName}",
                    style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () => Get.to(()=>SearchPage()),
                      icon:  Icon(Icons.search_rounded,color: Colors.white,size: 30,).paddingOnly(right: 3.w))
                ],
              ),
            ).paddingOnly(top: 5.h),
            SizedBox(height: 3.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${controller.temperature.value.round()}°c",
                    style: const TextStyle(fontSize:55, color: Colors.white)),
                SizedBox(
                  height: 80,
                  width: 100,
                  child: controller.getWeatherIconPath(controller.hourlyForecast[0].condition) != "assets/images/icon"
                      ? Image.asset(controller.getWeatherIconPath(controller.hourlyForecast[0].condition), fit: BoxFit.contain)
                      : const Icon(Icons.cloud, color: Colors.white, size: 35),
                ),
              ],
            ),

            Center(
              child: Text(
                controller.getWeatherCondition(controller.hourlyForecast[0].condition),
                style: const TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            SizedBox(height: 3.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.thermostat, color: Colors.redAccent),
                const SizedBox(width: 4),
                Text("${controller.todayMax.value.round()}°C", style: const TextStyle(color: Colors.white)),
                const SizedBox(width: 12),
                const Icon(Icons.thermostat, color: Colors.lightBlue),
                const SizedBox(width: 4),
                Text("${controller.todayMin.value.round()}°C", style: const TextStyle(color: Colors.white)),
                const SizedBox(width: 12),
                Text("Feels like ${controller.feelLike.value.round()}°C",
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 12),

          ],
        );
      }),
    );
  }
}
