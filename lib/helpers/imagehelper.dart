import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageHelper{
  Future<String> getBackgroundImage(String query) async {
    //get data from api
    try {
      final params = {
        'client_id': '2IKmYf5dmuJCEvUawZ8wjXqeIHEC2Lu80fmyt_vB-SM',
        'page': '1',
        'per_page': '1',
        'query': '${query}'
      };
      final uri = Uri.http('api.unsplash.com', '/search/photos', params);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result['results'][0]['urls']['regular'].toString();
      } else {
        throw Exception('Can not get bG image');
      }
    } catch (e) {
      rethrow;
    }
  }
}