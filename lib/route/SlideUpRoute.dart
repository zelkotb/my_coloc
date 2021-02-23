import 'package:flutter/cupertino.dart';

class SlideUpRoute extends PageRouteBuilder{
  final Widget page;
  SlideUpRoute({this.page})
      : super(
    transitionDuration: Duration(milliseconds: 700),
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.ease)).animate(animation),
          child: child,
        ),
  );
}