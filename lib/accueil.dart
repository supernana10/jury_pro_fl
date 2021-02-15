import 'package:JuryPro/evenements.dart';
import 'package:JuryPro/candidats.dart';
import 'package:flutter/material.dart';

class Accueil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: monstateful(),
    );
  }
}

// ignore: camel_case_types
class monstateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _monstate();
  }
}

// ignore: camel_case_types
class _monstate extends State<monstateful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accueil"),
        elevation: 20,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(25.0, 90.0, 25.0, 0.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(blurRadius: 2.0, color: Colors.grey)
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              )
            ],
          ),
          SizedBox(height: 10.0),
          Container(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              )),
          SizedBox(height: 15.0),
          GridView.count(
            crossAxisCount: 2,
            primary: false,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 50.0,
            shrinkWrap: true,
            children: <Widget>[
              _buildCard('Evenement', 'Available', "images/icon_event.jpg",Evenements(), 1),
              _buildCard('Candidats', 'Away', "images/icon_candidat.jpg",Candidats(), 2),
              _buildCard(
                  'Jury', 'Away', "images/icon_jury.jpg", Evenements(), 3),
              _buildCard('Groupes', 'Available', "images/icon_groupe.jpg",
                  Evenements(), 4),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCard(String name, String status, String srcIcon,
      Object lienRoute, int cardIndex) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 7.0,
        child: Column(
          children: <Widget>[
            SizedBox(height: 18.0),
            Stack(children: <Widget>[
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    image: DecorationImage(
                        image: AssetImage(
                      srcIcon,
                    ))),
              ),
            ]),
            SizedBox(height: 2.0),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => lienRoute));
              },
              child: Text(
                "Voir",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            Expanded(
                child: Container(
                    width: 175.0,
                    decoration: BoxDecoration(
                      color: status == 'Away' ? Colors.black : Colors.black,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0)),
                    ),
                    child: Center(
                      child: Text(
                        name,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Quicksand'),
                      ),
                    ))),
          ],
        ),
        margin: cardIndex.isEven
            ? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0)
            : EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0));
  }
}
