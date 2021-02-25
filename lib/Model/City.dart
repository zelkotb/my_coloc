
import 'package:my_coloc/Model/Sector.dart';

class City {

  String name;
  List<Sector> sectors;

  City({this.name,this.sectors});

  String getName(){
    return this.name;
  }

  void setName(String name){
    this.name = name;
  }

  List<Sector> getSectors(){
    return this.sectors;
  }

  void setSectors(List<Sector> sectors){
    this.sectors = sectors;
  }

  factory City.fromJson(Map<String, dynamic> json) {
    var list = json['sectors'] as List;
    return City(
        name : json['name'],
        sectors : list.map((c) => Sector.fromJson(c)).toList()
    );
  }
}