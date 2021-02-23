import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_coloc/Util/Constant.dart';

class FindApartmentJourneyScreen extends StatefulWidget {
  final ValueChanged<int>  onButtonClicked;
  FindApartmentJourneyScreen({this.onButtonClicked});

  @override
  _FindApartmentJourneyScreenState createState() => _FindApartmentJourneyScreenState();
}

class _FindApartmentJourneyScreenState extends State<FindApartmentJourneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(kFindApp)),
        backgroundColor: Color(kPrincipalColor),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              widget.onButtonClicked(1),
            }
        ),
      ),
      body: Container(color: Colors.white,),
    );
  }
}


