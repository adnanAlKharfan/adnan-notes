import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes/provider.dart';
import 'package:provider/provider.dart';
import './notes_page.dart';

class splash_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _splash_screen();
  }
}

class _splash_screen extends State<splash_screen> {
  bool e = true;
  @override
  void initState() {
    super.initState();
    if (e) {
      e = false;
      Timer(Duration(seconds: 1), () {
        Provider.of<data>(context, listen: false).initialize().then((value) =>
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return MyHomePage();
            })));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "Adnan\nnotes",
            style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.1),
          )),
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
