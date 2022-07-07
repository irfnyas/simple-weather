import 'package:simple_weather/domain/model/city_model.dart';
import 'package:simple_weather/domain/model/province_model.dart';

class ProfileModel {
  String name;
  ProvinceModel? prov;
  CityModel? city;

  ProfileModel({this.name = '', this.prov, this.city});
}
