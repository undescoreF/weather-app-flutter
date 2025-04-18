import 'current_weather_model.dart';
import 'hourly_forecast_model.dart';
import 'daily_forecast_model.dart';

class WeatherResponseModel {
  final CurrentWeatherModel currentWeather;
  final List<HourlyForecastModel> hourlyForecast;
  final List<DailyForecastModel> dailyForecast;

  WeatherResponseModel({
    required this.currentWeather,
    required this.hourlyForecast,
    required this.dailyForecast,
  });

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json) {
    return WeatherResponseModel(
      currentWeather: CurrentWeatherModel.fromJson(json['current_weather']),
      hourlyForecast: _parseHourlyForecast(json['hourly']),
      dailyForecast: _parseDailyForecast(json['daily']),
    );
  }
  // Fonction pour parser hourly
  static List<HourlyForecastModel> _parseHourlyForecast(Map<String, dynamic> hourlyData) {
    List<HourlyForecastModel> hourlyList = [];
    int timeCount = (hourlyData['time'] as List).length;

    for (int i = 0; i < timeCount; i++) {
      hourlyList.add(HourlyForecastModel.fromJson({
        'time': hourlyData['time'][i],
        'temperature_2m': hourlyData['temperature_2m'][i],
        'weathercode' : hourlyData['weathercode'][i],
        'apparent_temperature':hourlyData['apparent_temperature'][i],
      }));
    }

    return hourlyList;
  }

// Fonction pour parser daily
  static List<DailyForecastModel> _parseDailyForecast(Map<String, dynamic> dailyData) {
    List<DailyForecastModel> dailyList = [];
    int timeCount = (dailyData['time'] as List).length;

    for (int i = 0; i < timeCount; i++) {
      dailyList.add(DailyForecastModel.fromJson({
        'time': dailyData['time'][i],
        'temperature_2m_max': dailyData['temperature_2m_max'][i],
        'temperature_2m_min': dailyData['temperature_2m_min'][i],
        'weathercode': dailyData['weathercode'][i],
      }));
    }

    return dailyList;
  }
}

