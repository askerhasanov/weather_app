class WeatherDetail {

  final String temp;
  final String timeEpoch;
  final String condition;
  final String description;
  final String humidity;
  final String wind;
  final String icon;
  final String lat;
  final String long;
  final String feelLike;

  WeatherDetail({
    this.temp = '0',
    this.timeEpoch = '0',
    this.condition = 'null',
    this.description = 'null',
    this.humidity = 'null',
    this.wind = 'null',
    this.icon = 'null',
    this.lat = 'null',
    this.long = 'null',
    this.feelLike ='null',
  });

  factory WeatherDetail.fromJson(Map<String, dynamic> json){
    return WeatherDetail(
      temp: json['current']['temp'].toString(),
      timeEpoch: json['current']['dt'].toString(),
      condition: json['current']['weather'][0]['main'].toString(),
      lat: json['lat'].toString(),
      long: json['lon'].toString(),
      humidity:json['current']['humidity'].toString(),
      wind: json['current']['wind_speed'].toString(),
      icon:json['current']['weather'][0]['icon'].toString(),
      description: json['current']['weather'][0]['description'].toString(),
      feelLike: json['current']['feels_like'].toString(),
    );
  }

}