import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_coloc/Component/DropDown.dart';
import 'package:my_coloc/Enumeration/Floor.dart';
import 'package:my_coloc/Model/City.dart';
import 'package:my_coloc/Model/Country.dart';
import 'package:my_coloc/Model/Sector.dart';
import 'package:my_coloc/Util/Constant.dart';
import 'package:my_coloc/Util/EnumUtils.dart';
import 'package:my_coloc/Util/FileUtils.dart';

class CustomForm extends StatefulWidget {
  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  Future getCountries() async {
    final result = await FileUtils.parseJson("country");
    var countryList = result['countries'] as List;
    countries = countryList.map((c) => Country.fromJson(c)).toList();
    selectedCountry = countries.map((c) => c.getName()).toList()[0];
    getCitiesForCountry(selectedCountry);
  }

  List<City> getCitiesForCountry(String name){
    for(Country c in countries){
      if(c.getName()==name){
        setState(() {
          cities = c.getCities();
        });
        getSectorsForCity(cities[0].getName());
        return c.getCities();
      }
    }
    return [];
  }

  List<Sector> getSectorsForCity(String name){
    for(City c in cities){
      if(c.getName()==name){
        setState(() {
          sectors = c.getSectors();
        });
        return c.getSectors();
      }
    }
    return [];
  }

  final _formKey = GlobalKey<FormState>();
  final FocusNode myFocusNode = FocusNode();
  List<Country> countries = [];
  List<City> cities = [];
  List<Sector> sectors = [];
  String selectedCountry = "";
  String selectedCity = "";

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            children: <Widget>[
              CustomDropDown(
                values: countries.map((s) => s.getName()).toList().isEmpty?
                  ["Selectionner un pays"] : countries.map((s) => s.getName()).toList(),
                label: "Pays",
                myFocusNode: myFocusNode,
                nameOnChange: (country){
                    getCitiesForCountry(country);
                },
              ),
              CustomDropDown(
                values: cities.map((s) => s.getName()).toList().isEmpty?
                ["Selectionner une ville"] : cities.map((s) => s.getName()).toList(),
                label: "Ville",
                myFocusNode: myFocusNode,
                nameOnChange: (city){
                    getSectorsForCity(city);
                },
              ),
              CustomDropDown(
                values: sectors.map((s) => s.getName()).toList().isEmpty?
                ["Selectionner un quartier"] : sectors.map((s) => s.getName()).toList(),
                label: "Qartier",
                myFocusNode: myFocusNode,
                nameOnChange: (sector){
                  setState(() {
                    //this.sector = sector;
                  });
                },
              ),
              CustomDropDown(
                values: EnumUtil.extractEnumValues(Floor.values),
                label: "Etage",
                myFocusNode: myFocusNode,
                nameOnChange: (etage){},
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextFormField(
                  focusNode: myFocusNode,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Pays',
                    labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Colors.black : Colors.grey
                    ),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                    focusedBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'please enter some Text';
                    }
                    return null;
                  },
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              RaisedButton(
                onPressed: (){
                  if(_formKey.currentState.validate()){
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data'),));
                  }
                },
                color: Color(kPrincipalColor),
                child: Text('Suivant',style: TextStyle(fontSize: 16,fontFamily: 'Raleway',fontWeight: FontWeight.bold,color: Colors.white),),
              )
            ]
        )
    );
  }
}
