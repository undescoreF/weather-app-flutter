import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meteo/controller/search_controller.dart';
import 'package:meteo/controller/weather_controller.dart';
import 'package:meteo/repository/place_repo.dart';
import 'package:meteo/services/place_api_service.dart';
import 'package:sizer/sizer.dart';

import '../../models/place_model.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchPlaceController = Get.put(SearchPlaceController(PlaceRepository(PlaceService())));
    final wcontroller = Get.find<WeatherController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SearchBar(
                backgroundColor: const WidgetStatePropertyAll(Colors.white),
                hintText: 'Search....',
                autoFocus: true,
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back),
                ),
                onChanged: searchPlaceController.searchPlace,
              ),
              SizedBox(
                height: 70.h,
                child: Obx(() {
                  return ListView.builder(
                    itemCount: searchPlaceController.suggestions.length,
                    itemBuilder: (context, index) {
                      final SPlace place = searchPlaceController.suggestions[index];
                      return Container(
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.blue)),
                        ),
                        child: ListTile(
                          onTap: () {
                            final spc = wcontroller.searchPlaceController;
                            spc.defaultLat.value = place.lat;
                            spc.defaultLong.value = place.long;
                            spc.location.value = place.timezone;
                            spc.placeName.value = "${place.name}, ${place.country}";
                            wcontroller.fetchWeatherData(place.long, place.lat);
                            Get.back();
                          },
                          title: Text(
                            "${place.name}, ${place.country}",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                          ),
                        ),
                      );
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
