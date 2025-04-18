class CurrentWeatherModel {
  final double temperature;
  final int condition;


  CurrentWeatherModel({
    required this.temperature,
    required this.condition,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      temperature: json['temperature']?.toDouble() ?? 0.0,
      condition: json['weathercode'] ?? 0,
    );
  }
}
