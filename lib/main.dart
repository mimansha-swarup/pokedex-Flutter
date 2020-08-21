

import 'package:flutter/material.dart';
import 'package:kantodex/Pages///loading.dart';
import 'package:kantodex/Pages/home.dart';
import 'package:kantodex/service/pokedetails.dart';


void main() {
  ErrorWidget.builder = (FlutterErrorDetails error) {
    bool inDebug = false;
    assert(() {
      inDebug = true;
      return true;
    }());
    if (inDebug) return ErrorWidget(error.exception);
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Error',
        style: TextStyle(color: Colors.amber),
        textDirection: TextDirection.ltr,
      ),
    );
  };
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => HomeScreen(),
      '/details':(context) => PokeBio(),
    },
  ));
}
