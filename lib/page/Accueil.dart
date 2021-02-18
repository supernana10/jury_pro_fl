import 'package:flutter/material.dart';

import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:jury_pro/page/Candidat.dart';
import 'package:jury_pro/page/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JURY_PRO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" HOME JURY_PRO"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MaterialButton(
                child: Text("CANDIDATS"),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Candidat()));
                },
                color: Colors.deepOrange,
              ),
              SizedBox(height: 12),
              MaterialButton(
                child: Text("EVENEMENTS"),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new Home()));
                  // Navigator.pushNamed(context, 'evenements');
                },
                color: Colors.limeAccent,
              ),
              SizedBox(height: 12),
              MaterialButton(
                child: Text("JURY"),
                onPressed: () {},
                color: Colors.tealAccent,
              ),
              SizedBox(height: 12),
              CircularRevealAnimation(
                child: Image.network(
                  'https://picsum.photos/250?image=9',
                  width: 200,
                  height: 300,
                ),
                animation: animation,
                //centerAlignment: Alignment.centerRight,
                centerOffset: Offset(130, 100),
//                minRadius: 12,
//                maxRadius: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void candidat(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.network(
                  'https://cdn.pixabay.com/photo/2020/09/29/23/38/team-5614157_1280.png'),
            ),
            margin: EdgeInsets.only(top: 50, left: 12, right: 12, bottom: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return CircularRevealAnimation(
          child: child,
          animation: anim1,
          centerAlignment: Alignment.bottomCenter,
        );
      },
    );
  }

  void evenement(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 400.0),
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Title of the dialog",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Content of the dialog. Content of the dialog. Content of the dialog. Content of the dialog. ",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("OK"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            margin: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return CircularRevealAnimation(
          child: child,
          animation: anim1,
          centerAlignment: Alignment.center,
        );
      },
    );
  }
}
