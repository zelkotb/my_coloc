import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_coloc/Screen/FindApartmentJourneyScreen.dart';
import 'package:my_coloc/Screen/FindColocJourneyScreen.dart';
import 'package:my_coloc/Screen/OffersScreen.dart';
import 'package:my_coloc/Util/Constant.dart';
import 'file:///C:/Users/user/AndroidStudioProjects/my_coloc/lib/Util/UtilStorage.dart';
import 'package:my_coloc/route/SlideUpRoute.dart';
import 'package:device_info/device_info.dart';
class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  PageController controller = PageController(initialPage: 1);
  ScrollPhysics scrollPhysics = NeverScrollableScrollPhysics();
  int current = 1;
  bool isOnPageTurning = false;
  void scrollListener() {
    if (isOnPageTurning &&
        controller.page == controller.page.roundToDouble()) {
      setState(() {
        current = controller.page.toInt();
        isOnPageTurning = false;
      });
    } else if (!isOnPageTurning && current.toDouble() != controller.page) {
      if ((current.toDouble() - controller.page).abs() > 0.1) {
        setState(() {
          isOnPageTurning = true;
        });
      }
    }
    if(current==1 && !isOnPageTurning ){
      setState(() {
        this.scrollPhysics = NeverScrollableScrollPhysics();
      });
    } else{
      setState(() {
        this.scrollPhysics = ClampingScrollPhysics();
      });
    }
  }
  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 1);
    controller.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    initPlatformState();
    return PageView(
      physics: scrollPhysics,
      controller: controller,
      scrollDirection: Axis.vertical,
      pageSnapping: true,
      children: <Widget>[
        FindApartmentJourneyScreen(
          onButtonClicked: (index){
            _goToScreen(index);
          },
        ),
        Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Image(
                        image: AssetImage('images/dest_icon.png'),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          ChoiceButton(
                            kFindColoc,
                            'icons/building.png',
                                ()=> _goToScreen(2),
                          ),
                          ChoiceButton(
                            kFindApp,
                            'icons/group.png',
                                ()=> _goToScreen(0),
                          ),
                          ChoiceButton(
                            koffers,
                            'icons/shared_key.png',
                                ()=>    { Navigator.push(
                                    context,
                                    SlideUpRoute(
                                      page: OffersScreen(),
                                    )
                                )},
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        FindColocJourneyScreen(
          onButtonClicked: (index){
            _goToScreen(index);
          },
        ),
      ],
    );
  }

  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData;
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        UtilStorage.setToSharedPreferences('id_android', androidInfo.id);
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
  }

  _goToScreen(int page){
    controller.animateToPage(page, duration: Duration(milliseconds: 500), curve: Curves.ease);
  }
}


class ChoiceButton extends StatelessWidget {

  final String _text;
  final String _icon;
  final Function _goToScreen;
  ChoiceButton(this._text,this._icon,this._goToScreen);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        highlightElevation: 3,
        onPressed: _goToScreen,
        textColor: Colors.white,
        color: Color(kPrincipalColor),
        padding: EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Image(
                height: 30,
                width: 30,
                image: AssetImage(_icon),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(_text,
                style: TextStyle(fontSize: 16,fontFamily: 'Raleway',fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}
