class SPlace{
  String name;
  String admin1;
  String country;
  String timezone;
  double lat;
  double long;
  SPlace({
    required this.lat,
    required this.long,
    required this.name,
    required this.admin1,
    required this.country,
    required this.timezone
});
  factory SPlace.fromJson(Map<String,dynamic> json){
    return SPlace(
        name: json['name'] ?? "" ,
        lat:json['latitude'] ?? 0.0,
        long: json['longitude'] ?? 0.0,
        admin1: json['admin1']  ?? "",
        country: json['country'] ?? "",
        timezone: json['timezone'] ?? ""
);
  }
}