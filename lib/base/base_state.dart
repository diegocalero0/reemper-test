import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {

  void navigatePush(Widget screen, {BuildContext? context2}) {
    Navigator.of(context2 ?? context).push(MaterialPageRoute(builder: (BuildContext context) => screen));
  }

  void navigatePushReplacement(Widget screen) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => screen));
  }

  void refreshScreen() {
    setState(() {});
  }

  void showAlert(String text, {VoidCallback? action}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Wrap(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 24),
                    Padding(
                      child: Text(text, style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: const Color(0xff152738),
                        fontSize: 16,
                      ), textAlign: TextAlign.center),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: const Color(0xff75AABF)
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextButton(
                            child: Text("OK", style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: const Color(0xff64ACC1),
                              fontSize: 16
                            )),
                            onPressed: () {
                              if(action == null) {
                                Navigator.of(context).pop();
                              } else {
                                Navigator.of(context).pop();
                                action.call();
                              }
                              
                            },
                          )
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        );
      }, 
    );
  }

  void goBack() {
    Navigator.of(context).pop();
  }

}