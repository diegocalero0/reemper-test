import 'package:flutter/material.dart';

/// A generic state that contains some helpfull methods
abstract class BaseState<T extends StatefulWidget> extends State<T> {

  /// Method that navigates to a next screen
  void navigatePush(Widget screen, {BuildContext? context2}) {
    Navigator.of(context2 ?? context).push(MaterialPageRoute(builder: (BuildContext context) => screen));
  }

  /// Method that navigates replacing the current screen
  void navigatePushReplacement(Widget screen) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => screen));
  }

  /// Method that refresh a screen
  void refreshScreen() {
    setState(() {});
  }

  /// Method that navigates to go back
  void goBack() {
    Navigator.of(context).pop();
  }

}