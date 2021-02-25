import 'package:my_coloc/Model/City.dart';

class Country {
  String name;
  List<City> cities;

  Country({this.name,this.cities});

  String getName(){
    return this.name;
  }

  void setName(String name){
    this.name = name;
  }

  List<City> getCities(){
    return this.cities;
  }

  void setCities(List<City> cities){
    this.cities = cities;
  }

  factory Country.fromJson(Map<String, dynamic> json) {
    var list = json['cities'] as List;
    return Country(
      name : json['name'],
      cities: list.map((c) => City.fromJson(c)).toList()
    );
  }
}