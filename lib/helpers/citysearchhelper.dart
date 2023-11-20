import 'dart:convert';
import '../models/citydata.dart';
import 'package:http/http.dart' as http;

class CitySearchHelper{
  Future<List<CityData>> getSearchedCities(String input) async {
    //get data from api
    try{
      final params = {
        'key' : 'fdfdaa3317694c32adc172533233001',
        'q': '${input}',
      };
      final uri = Uri.http('api.weatherapi.com','/v1/search.json', params);
      print(uri);
      final response = await http.get(uri);
      print(response.body);
      if(response.statusCode ==200){
        List<dynamic> result = jsonDecode(response.body);
        List<CityData> citylist = result.map((json) => CityData.fromJson(json)).toList();
        return citylist;
      }else{
        throw Exception('Can not get weather');
      }
    }catch(e){
      rethrow;
    }
  }
}