import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_coloc/Util/EnumUtils.dart';

class CustomDropDown extends StatefulWidget {

  final List<String> enumValues;
  final FocusNode myFocusNode;
  final String label;
  final ValueChanged<String> nameOnChange;

  CustomDropDown({this.enumValues,this.myFocusNode,this.label,this.nameOnChange});

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

  String selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20, top: 20),
      child: DropdownButtonFormField(
        value: (selectedValue == null || !EnumUtil.isValueExistInEnum(selectedValue, widget.enumValues))
            ? widget.enumValues[0] : selectedValue,
        onChanged: (value){
          setState(() {
            this.selectedValue = value;
            widget.nameOnChange(value);
          });
        },
        validator: (value) => value == null ? 'ce champs est obligatoire' : null,
        items: widget.enumValues
            .map((String item){
          return new DropdownMenuItem(
            value: item,
            child: new Text(item),);
        }).toList(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: widget.label,
          labelStyle: TextStyle(
              color: widget.myFocusNode.hasFocus ? Colors.black : Colors.grey
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
      ),
    );
  }
}
