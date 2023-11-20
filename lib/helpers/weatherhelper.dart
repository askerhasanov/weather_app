import 'dart:convert';
import 'package:weather_app/helpers/imagehelper.dart';
import 'package:weather_app/models/citydata.dart';
import 'package:weather_app/models/cityweather.dart';
import 'package:http/http.dart' as http;

class WeatherHelper {
  Future<CityWeather?> getWeatherData(CityData? selectedCity) async{
    if(selectedCity != null){
      try{
        final params = {
          'appid' : 'c63fd168493cb26bfa90e2436849866d',
          'lat': '${selectedCity!.lat}',
          'lon': '${selectedCity.long}',
          'exclude': 'hourly,minutely',
        };
        final uri = Uri.http('api.openweathermap.org','/data/3.0/onecall', params);
        print(uri);
        final response = await http.get(uri);
        if(response.statusCode ==200){
          print(jsonDecode(response.body));
          String bg = await ImageHelper().getBackgroundImage(selectedCity.name);
          return CityWeather.fromData(selectedCity, jsonDecode(response.body), bg);
        }else{
          throw Exception('Can not get weather');
        }
      }catch(e){
        rethrow;
      }
    }
  }
}