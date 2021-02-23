import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_coloc/Component/ApprtementForm.dart';
import 'package:my_coloc/Util/Constant.dart';


class FindColocJourneyScreen extends StatefulWidget {
  final ValueChanged<int> onButtonClicked;

  FindColocJourneyScreen({Key key, this.onButtonClicked}) : super(key: key);

  @override
  _FindColocJourneyScreenState createState() => _FindColocJourneyScreenState();
}

class _FindColocJourneyScreenState extends State<FindColocJourneyScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
          appBar: AppBar(
            title: Center(child: Text(kFindColoc)),
            backgroundColor: Color(kPrincipalColor),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => {
                widget.onButtonClicked(1),
              }
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ExpansionPanel(icon: Icons.home,title: 'Appartement'),
              ],
            ),
          ),
    );
  }
}

class ExpansionPanel extends StatefulWidget {

  final String title;
  final IconData icon;
  ExpansionPanel({this.title,this.icon});

  @override
  _ExpansionPanelState createState() => _ExpansionPanelState();
}

class _ExpansionPanelState extends State<ExpansionPanel> with TickerProviderStateMixin<ExpansionPanel>{
  AnimationController _animationController;
  ///The animation controller that starts the slide effect
  AnimationController _slideAnimationController;
  ///The animation that creates the slide up effect by controlling the height
  ///factor of the [Align] widget
  Animation<double> _heightFactorAnimation;
  ///Governs whether to show the banner or not. We use a [ValueNotifier]
  ///because the visibility changes asynchronously when the animation finishes,
  ///which we want to trigger the rebuild of [ValueListenableBuilder] That
  ///listens to this value
  ValueNotifier<bool> _isVisibleValueNotifier = ValueNotifier(true);
  bool isCollapsed = false;

  void _handleOnPressed() {
    setState(() {
      isCollapsed = !isCollapsed;
      isCollapsed
          ? _animationController.forward()
          : _animationController.reverse();

      if(_isVisibleValueNotifier.value){
        _slideAnimationController.forward();
        _isVisibleValueNotifier.value = false;
      }else{
        _isVisibleValueNotifier.value = true;
        _slideAnimationController.reverse();
      }
    });
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _slideAnimationController = AnimationController(
      vsync: this,
      //whatever duration you want
      duration: Duration(milliseconds: 500),
    );
    _heightFactorAnimation = CurvedAnimation(
        parent: _slideAnimationController.drive(
          Tween<double>(
            begin: 1.0,
            end: 0.1,
          ),
        ),
        curve: Curves.ease);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10),),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(5,3),
          ),
        ]
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 15, left: 5),
                    child: Icon(widget.icon,size: 30,),
                  ),
                  Text(widget.title,style: TextStyle(fontSize: 20,fontFamily: 'Raleway',fontWeight: FontWeight.bold,),),
                ],
              ),
              IconButton(
                icon: AnimatedIcon(
                  icon: AnimatedIcons.close_menu,
                  progress: _animationController,
                ),
                onPressed: () => _handleOnPressed(),
              ),
            ],
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _isVisibleValueNotifier,
            builder: (context, isVisible, child) {
              return Visibility(
                visible: isVisible,
                child: child,
              );
            },
            child: AnimatedBuilder(
              animation: _slideAnimationController,
              builder: (BuildContext context, Widget child) {
                return ClipRect(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    heightFactor: _heightFactorAnimation.value,
                    child: child,
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



