import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl =
      'https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/1/query';

  Future<Map<String, dynamic>> fetchCovidData() async {
    final response = await http.get(Uri.parse(
        '$_baseUrl?where=UPPER(Country_Region)%20like%20%27%25INDONESIA%25%27&outFields=Last_Update,Recovered,Deaths,Confirmed&returnGeometry=false&outSR=4326&f=json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['features'].isNotEmpty) {
        return data['features'][0]['attributes'];
      } else {
        throw Exception('No data found');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
