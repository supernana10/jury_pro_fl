import 'package:JuryPro/Animation/FadeAnimation.dart';
import 'Accueil.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';


void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash (),
    ));

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new Accueil(),
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
/* class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF3D00),
        title: Text(
          'Bienvenue!!',
          style: TextStyle(color: Color(0xffffffff), fontSize: 40.0),
        ),
      ),
      backgroundColor: Color(0XA9A9A9),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RaisedButton(
            splashColor: Color(0x696969),
            padding: EdgeInsets.all(16.6),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Accueil()));
            },
            child: Text('COMMENCER', style: TextStyle(fontSize: 20)),

            /* shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: Colors.orange[900],
            child: Text(
              "Bienvenue et bonne utilisation!!",
              style: TextStyle(
                color: Colors.white,
              ),
            ), */
          ),
        ],
      )),
    );
  } 

  /*void pageAccueil() {
    BuildContext context;
        Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>Accueil()));
  }*/
}*/
