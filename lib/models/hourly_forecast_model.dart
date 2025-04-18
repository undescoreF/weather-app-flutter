class HourlyForecastModel {
   DateTime time;
  final double temperature;
  final int condition;
  final double feelsLike;

  HourlyForecastModel({
    required this.time,
    required this.temperature,
    required this.condition,
    required this.feelsLike
  });

  factory HourlyForecastModel.fromJson(Map<String, dynamic> json) {
    return HourlyForecastModel(
      time: DateTime.parse(json['time']),
      temperature: json['temperature_2m']?.toDouble() ?? 0.0,
      condition: json['weathercode'] ?? 0,
      feelsLike: json['apparent_temperature']?.toDouble() ?? 0.0
    );
  }
   HourlyForecastModel copyWith({
     DateTime? time,
   }) {
     return HourlyForecastModel(
       time: time ?? this.time,
       temperature: temperature,
       condition:  condition,
       feelsLike:  feelsLike,
     );
   }

}

