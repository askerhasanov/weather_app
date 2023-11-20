import 'package:weather_app/models/citydata.dart';
import 'package:weather_app/models/daydetail.dart';
import 'package:weather_app/models/weatherDetail.dart';

class CityWeather {

  CityData city;
  WeatherDetail current;
  List<DayDetail> days;
  String backgroundImage;

  CityWeather({
    required this.current,
    required this.days,
    required this.city,
    required this.backgroundImage,
  });


  factory CityWeather.fromData(CityData selectedCity, Map<String, dynamic> json, String bg){
    List<dynamic> daysl = json['daily'];
    daysl = daysl.sublist(1,5);
    return CityWeather(
        current: WeatherDetail.fromJson(json),
        days: daysl.map((jsond) => DayDetail.fromJson(jsond)).toList(),
        city: selectedCity,
        backgroundImage: bg,
    );
  }
}