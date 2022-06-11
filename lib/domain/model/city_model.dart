class CityModel {
  String id;
  String name;
  String provinceId;
  String lat;
  String lng;

  CityModel(
      {this.id = '',
      this.name = '',
      this.provinceId = '',
      this.lat = '',
      this.lng = ''});

  CityModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        provinceId = json['province_id'],
        lat = json['lat'],
        lng = json['lng'];
}
