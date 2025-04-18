import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:meteo/controller/search_controller.dart';
import 'package:meteo/models/daily_forecast_model.dart';
import 'package:meteo/models/hourly_forecast_model.dart';
import 'package:meteo/repository/place_repo.dart';
import 'package:meteo/repository/weather_repo.dart';
import 'package:meteo/services/place_api_service.dart';
import 'package:timezone/timezone.dart' as tz;

class WeatherController extends GetxController {
  DateTime date = DateTime.now();
  final WeatherRepository weather = WeatherRepository();

  RxDouble temperature = 0.0.obs;
  RxDouble feelLike = 0.0.obs;
  var todayMax =0.0.obs;
  var todayMin = 0.0.obs;
  var hourlyForecast = <HourlyForecastModel>[].obs;
  var dailyForecast = <DailyForecastModel>[].obs;

  final SearchPlaceController searchPlaceController = SearchPlaceController(
    PlaceRepository(PlaceService()),
  );

  @override
  Future<void> onInit() async {
    super.onInit();
    await searchPlaceController.getCurrentLocation();
    searchPlaceController.location.value = await FlutterNativeTimezone.getLocalTimezone();
    await fetchWeatherData(
      searchPlaceController.defaultLong.value,
      searchPlaceController.defaultLat.value,
    );

  }

  Future<void> fetchWeatherData(double long, double lat) async {
    final result = await weather.getWeather(long, lat);
    temperature.value = result.currentWeather.temperature;
    hourlyForecast.value = result.hourlyForecast;
    dailyForecast.value = result.dailyForecast;
    getNext36HoursForecast1(
      hourlyList: result.hourlyForecast,
      timezoneName: searchPlaceController.location.value,
    );

  }

  String getWeekDay(DateTime date) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    final dayName = weekdays[date.weekday - 1];
    final monthName = months[date.month - 1];

    return '$dayName, $monthName ${date.day}';
  }

  List<HourlyForecastModel> getNext36HoursForecast1({
    required List<HourlyForecastModel> hourlyList,
    required String timezoneName,
  }) {


    final location = tz.getLocation(timezoneName);
    final nowUtc = DateTime.now().toUtc();
    final nowInTargetZone = tz.TZDateTime.from(nowUtc, location);

    final nextHours = hourlyList.where((hour) {
      return hour.time.hour>= nowInTargetZone.hour;
     //return (hour.time.isAfter(nowInTargetZone.subtract(Duration(hours: 1))));
    }).take(36).toList();


    hourlyForecast.value = nextHours;
    todayMin.value = dailyForecast.first.tempMin;
    todayMax.value = dailyForecast.first.tempMax;
    feelLike.value = nextHours.first.feelsLike;
   // temperature.value = nextHours.first.temperature;
    update();

    return hourlyForecast;
  }
  String getWeatherCondition(int weatherCode) {
    const conditionMap = {
      0: 'Clear sky',
      1: 'Mainly clear',
      2: 'Partly cloudy',
      3: 'Overcast',
      45: 'Fog',
      48: 'Depositing rime fog',
      51: 'Light drizzle',
      53: 'Moderate drizzle',
      55: 'Dense drizzle',
      56: 'Light freezing drizzle',
      57: 'Dense freezing drizzle',
      61: 'Slight rain',
      63: 'Moderate rain',
      65: 'Heavy rain',
      66: 'Light freezing rain',
      67: 'Heavy freezing rain',
      71: 'Slight snow',
      73: 'Moderate snow',
      75: 'Heavy snow',
      77: 'Snow grains',
      80: 'Slight rain showers',
      81: 'Moderate rain showers',
      82: 'Violent rain showers',
      85: 'Slight snow showers',
      86: 'Heavy snow showers',
      95: 'Thunderstorm',
      96: 'Thunderstorm with slight hail',
      99: 'Thunderstorm with heavy hail',
    };

    return conditionMap[weatherCode] ?? 'Unknown';
  }
  String getWeatherIconPath(int weatherCode) {

    const iconMap = {
      0: 'sunny.png',
      1: 'partly_cloudy.png',
      3: 'overcast.png',
      45: 'fog.png',
    };


    return 'assets/images/${iconMap[weatherCode] ?? 'icon.png'}';
  }

}
