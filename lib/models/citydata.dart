class CityData{

  String id;
  String name;
  String country;
  String lat;
  String long;

  CityData({
    required this.id,
    required this.name,
    required this.country,
    required this.lat,
    required this.long
  });

  factory CityData.fromJson(Map<String, dynamic> json){
    return CityData(
        id: json['id'].toString(),
        name: json['name'].toString(),
        country: json['country'].toString(),
        lat: json['lat'].toString(),
        long: json['lon'].toString()
    );
  }

  factory CityData.fromDatabase(Map<String, dynamic> city){
    return CityData(
        id: city['cityId'].toString(),
        name: city['name'].toString(),
        country: city['country'].toString(),
        lat: city['lat'].toString(),
        long: city['lon'].toString()
    );
  }
}