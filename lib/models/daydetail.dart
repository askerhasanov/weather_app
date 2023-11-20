class DayDetail{
  String title;
  String icon;
  String temp;
  String wind;

  DayDetail({required this.title, required this.icon, required this.temp, required this.wind});

  factory DayDetail.fromJson(Map<String, dynamic> json){
    return DayDetail(
        title: json['dt'].toString(),
        icon: json['weather'][0]['icon'].toString(),
        temp: json['temp']['day'].toString(),
        wind: json['wind_speed'].toString()
    );
  }
}