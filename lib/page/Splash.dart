import 'package:jury_pro/page/Accueil.dart';
// import 'package:jury_pro/page/Home.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new Splash(),
  ));
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new MyApp(),
      title: new Text(
        ' Bienvenue sur Jury_Pro',
        textDirection: TextDirection.ltr,
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
          color: Colors.orange,
        ),
      ),
      image: new Image.network(
        'https://cdn.pixabay.com/photo/2014/05/02/21/47/laptop-336369_1280.jpg',
        alignment: Alignment.center,
      ),
      backgroundColor: Colors.white70,
      loaderColor: Colors.black,
    );
  }
}

/*class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcome In SplashScreen Package"),
        automaticallyImplyLeading: false,
      ),
      body: new Center(
        child: new Text(
          "Succeeded!",
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
      ),
    );
  }
}*/
