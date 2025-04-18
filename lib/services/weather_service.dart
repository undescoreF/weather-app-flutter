import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService {

  Future<Map<String, dynamic>> fetchWeather(double long, double lat) async {

    final url = Uri.parse('https://api.open-meteo.com/v1/forecast?'
        'latitude=$lat&longitude=$long'
        '&current_weather=true'
        '&hourly=temperature_2m,apparent_temperature,weathercode'
        '&daily=temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min,weathercode'
        '&timezone=auto&forecast_days=15');
    final response = await http.get(url);

    if(response.statusCode==200){
      return jsonDecode(response.body);
    }else{
      throw Exception('fetchWeather erro');
    }

  }
}