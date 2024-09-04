import 'package:anj_techtest/data/model/covid_model.dart';
import 'package:dio/dio.dart';

class RemoteDatasource {
  final dio = Dio(BaseOptions(
      baseUrl:
          'https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/1/query'));

  Future<FeaturesAPI> getData() async {
    final response = await dio.get(
        '?where=UPPER(Country_Region)%20like%20%27%25INDONESIA%25%27&outFields=Last_Update,Recovered,Deaths,Confirmed&returnGeometry=false&outSR=4326&f=json');
    return FeaturesAPI.fromJson(response.data);
  }
}
