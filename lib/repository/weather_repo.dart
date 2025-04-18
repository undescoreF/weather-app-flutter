

import 'package:meteo/models/weather_response_model.dart';
import 'package:meteo/services/weather_service.dart';

class WeatherRepository{
  final WeatherService api =WeatherService();

  Future<WeatherResponseModel> getWeather(double long, double lat) async {
    final json = await api.fetchWeather(long, lat);
    return WeatherResponseModel.fromJson(json);
  }
}

