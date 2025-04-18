import 'package:meteo/models/place_model.dart';
import 'package:meteo/services/place_api_service.dart';

class PlaceRepository{

  final PlaceService api;
  PlaceRepository(this.api);

  Future<List<SPlace>> searchPlace(String name) async {
    final json = await api.fetchPlaceData(name);
    return (json['results'] as List)
        .map((e) => SPlace.fromJson(e)).toList();
  }
}