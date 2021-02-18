import 'package:flutter/material.dart';
import 'package:jury_pro/page/Home.dart';
import 'package:jury_pro/page/Accueil.dart';
import 'package:jury_pro/page/Modifier.dart';
import 'package:jury_pro/page/Splash.dart';
//import 'package:jury_pro/page/Splash.dart';
//import 'package:jury_pro/page/Modifier.dart';
//import 'package:jury_pro/page/Modifier.dart';
//import 'package:jury_pro/page/Modifier.dart';

//import 'page/Splash.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Splash(),
    theme: ThemeData(primarySwatch: Colors.deepOrange),
    initialRoute: '/home',
    routes: {
      '/home': (context) => MyApp(),
      '/evenements': (context) => Home(),
      '/modifier': (context) => EvenementCreateOrUpdate(),
    },
  ));
}
