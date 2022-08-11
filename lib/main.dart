import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/splach_screen.dart';

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
    return ChangeNotifierProvider<data>(
        create: (context) => model,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              backgroundColor: Colors.black,
              primarySwatch: Colors.blue,
              buttonColor: Colors.white),
          routes: {
            '/': (context) {
              return splash_screen();
            }
          },
        ));
  }
}
