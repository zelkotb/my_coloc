class Sector {
  String name;

  Sector({this.name});

  String getName(){
    return this.name;
  }

  void setName(String name){
    this.name = name;
  }

  factory Sector.fromJson(Map<String, dynamic> json) {
    return Sector(
      name : json['name'],
    );
  }
}