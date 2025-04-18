import 'dart:convert';

import 'package:http/http.dart' as http;


class PlaceService{
  Future<Map<String, dynamic>> fetchPlaceData(String name) async {

    final url = Uri.parse('https://geocoding-api.open-meteo.com/v1/search?name=$name&count=3');
    final response = await  http.get(url);

    if(response.statusCode==200){
      return jsonDecode(response.body);
    }else{
      throw Exception("Failed ");
    }

  }

}