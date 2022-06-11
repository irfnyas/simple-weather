import 'package:weather_flutter/domain/model/city_model.dart';
import 'package:weather_flutter/domain/model/province_model.dart';

class ProfileModel {
  String name;
  ProvinceModel? prov;
  CityModel? city;

  ProfileModel({this.name = '', this.prov, this.city});
}
