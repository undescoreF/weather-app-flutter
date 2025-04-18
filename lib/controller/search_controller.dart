import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:meteo/models/place_model.dart';
import 'package:meteo/repository/place_repo.dart';


class SearchPlaceController extends GetxController{
  PlaceRepository placeRepository ;
  var suggestions = <SPlace>[].obs;
  var defaultLong = 0.0.obs;
  var defaultLat = 0.0.obs;
  var location =  "".obs;
  var placeName = "".obs;
  SearchPlaceController(this.placeRepository);

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    location.value = await FlutterNativeTimezone.getLocalTimezone();
    await getCurrentLocation();

  }

  Future<void> searchPlace(String name) async{
    if(name.isEmpty) suggestions.clear();
    final result = await placeRepository.searchPlace(name);
    suggestions.value = result;
  }
  Future<void> getCurrentLocation() async {
    await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }


    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    defaultLong.value = position.longitude;
    defaultLat.value = position.latitude;
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    placeName.value = "${placemarks[0].locality!}, ${placemarks[0].country!}";



  }
}