import 'package:flutter/material.dart';
import 'package:reemper/screens/modalities/modalities_screen.dart';
import 'package:reemper/servicelocator/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xff5CBEF8),
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 29,
            color: Color(0xff5CBEF8),
            fontWeight: FontWeight.bold
          ),
          headline2: TextStyle(
            fontSize: 26,
            color: Color(0xff1A1E22),
            fontWeight: FontWeight.bold
          ),
          bodyText1: TextStyle(
            fontSize: 14,
            color: Color(0xff1A1E22)
          ),
          bodyText2: TextStyle(
            fontSize: 18,
            color: Color(0xff1A1E22)
          )
        ),
        primarySwatch: Colors.blue
      ),
      home: const ModalitiesScreen(),
    );
  }
}