class DailyForecastModel {
  final DateTime date;
  final double tempMax;
  final double tempMin;
  final int condition;

  DailyForecastModel({
    required this.date,
    required this.tempMax,
    required this.tempMin,
    required this.condition,
  });

factory DailyForecastModel.fromJson(Map<String, dynamic> json){
  return DailyForecastModel(
      date: DateTime.parse(json['time']),
      tempMax: json['temperature_2m_max']?.toDouble() ?? 0.0,
      tempMin: json['temperature_2m_min']?.toDouble() ?? 0.0,
      condition: json['weathercode'] ?? 0
  );}
}