import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './notes_page.dart';
import 'package:provider/provider.dart';

import './provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final model = data();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ChangeNotifierProvider<data>(
        create: (context) => model,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              backgroundColor: Colors.black,
              primarySwatch: Colors.blue,
              buttonColor: Colors.white,
              cursorColor: Colors.black),
          routes: {
            '/': (context) {
              return MyHomePage();
            }
          },
        ));
  }
}
