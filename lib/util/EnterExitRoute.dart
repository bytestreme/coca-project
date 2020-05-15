import 'package:flutter/material.dart';

class EnterExitRoute extends PageRouteBuilder {
  final Widget enterPage;
  bool reverse = false;
  final Widget exitPage;
  EnterExitRoute({this.exitPage, this.enterPage, this.reverse})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    enterPage,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        Stack(
          children: <Widget>[
            SlideTransition(
              position: new Tween<Offset>(
                begin: Offset.zero,
                end: reverse ? const Offset(1.0, 0.0): const Offset(-1.0, 0.0),
              ).animate(animation),
              child: exitPage,
            ),
            SlideTransition(
              position: new Tween<Offset>(
                begin: reverse ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: enterPage,
            )
          ],
        ),
  );
}