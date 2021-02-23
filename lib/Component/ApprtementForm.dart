import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_coloc/Component/DropDown.dart';
import 'package:my_coloc/Enumeration/City.dart';
import 'package:my_coloc/Enumeration/Country.dart';
import 'package:my_coloc/Enumeration/Sector.dart';
import 'package:my_coloc/Util/Constant.dart';
import 'package:my_coloc/Util/EnumUtils.dart';

class CustomForm extends StatefulWidget {
  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {

  final _formKey = GlobalKey<FormState>();
  final FocusNode myFocusNode = FocusNode();
  String country = EnumUtil.extractEnumValues(Country.values)[0];
  String city = EnumUtil.extractEnumValues(City.values)[0];
  String sector = EnumUtil.extractEnumValues(Sector.values)[0];

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            children: <Widget>[
              CustomDropDown(
                enumValues: EnumUtil.extractEnumValues(Country.values),
                label: "Pays",
                myFocusNode: myFocusNode,
                nameOnChange: (country){
                  setState(() {
                    this.country = country;
                  });
                },
              ),
              CustomDropDown(
                enumValues: EnumUtil.extractEnumValuesForCountry(City.values, this.country),
                label: "Ville",
                myFocusNode: myFocusNode,
                nameOnChange: (city){
                  setState(() {
                    this.city = city;
                  });
                },
              ),
              CustomDropDown(
                enumValues: EnumUtil.extractEnumValues(Sector.values),
                label: "Qartier",
                myFocusNode: myFocusNode,
                nameOnChange: (sector){
                  setState(() {
                    this.sector = sector;
                  });
                },
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
