import 'dart:async';
import 'dart:convert';

import 'package:JuryPro/modifierevenements.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List data;
  List evenements;

  String get uri => null;

  Future getData() async {
    var response = await http.get("http://172.31.239.223:8000/evenements");
    data = json.decode(response.body);
    // print("Response : ");
    // print(data);
    setState(() {
      data = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future deleteEvenements(uri) async {
    String _uri = uri;

    var request = http.Request('POST',
        Uri.parse('http://172.31.239.223:8000/evenements/delete/' + _uri));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("succes");
    } else {
      print(response.reasonPhrase);
      print("echec");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Jury Pro"),
          backgroundColor: Colors.deepOrange,
        ),
        body: data != null ? getDisplayData() : waitData());
  }

  Widget getDisplayData() {
    // print(data[0]);
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int i) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.arrow_drop_down_circle),
                title: Text("${data[i]["evenementNom"]}"),
                subtitle: Text(
                  "Evenement de ${data[i]["evenementType"]}",
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Image.network("https://picsum.photos/250?image=9",
                  fit: BoxFit.fill, loadingBuilder: (BuildContext context,
                      Widget child, ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Date Debut: ${data[i]["evenementDateDebut"]}",
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Date Fin: ${data[i]["evenementDateFin"]}",
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              ButtonBar(alignment: MainAxisAlignment.end, children: [
                FlatButton(
                  textColor: Colors.black,
                  color: Colors.orange[800],
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ModifierEvenement(data[i])));
                    getData();
                  },
                  child: const Text('Modifier'),
                ),
                FlatButton(
                  textColor: Colors.white,
                  color: Colors.black,
                  onPressed: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                              title: Text(
                                  "Etes-vous sûr de vouloir supprimer cet evenement?"),
                              // content: Text(
                              //     "This is the content"),
                              actions: [
                                // Close the dialog
                                CupertinoButton(
                                  child: Text("OUI",
                                      style:
                                          TextStyle(color: Colors.orange[900])),
                                  onPressed: () {
                                    this.deleteEvenements(
                                        "${data[i]["evenementId"]}".toString());
                                    print(
                                        "${data[i]["evenementId"]}".toString());
                                    Navigator.of(context).pop();
                                    setState(() {});
                                  },
                                ),
                                CupertinoButton(
                                    child: Text('NON',
                                        style: TextStyle(
                                            color: Colors.orange[900])),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ],
                            ));
                    // Perform some action
                  },
                  child: const Text('Supprimer'),
                ),
              ]),
            ],
          ),
        );
      },
    );
  }

  Widget waitData() {
    return Center(
      child: Text("Chargement...",
          style: TextStyle(
            color: Colors.deepOrange,
          )),
    );
  }
}

/* import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'dart:developer' as developer;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Evenements(),
  ));
}

class Evenements extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Evenements> {
  List data;
  List evenements;

  Future getData() async {
    http.Response response =
        await http.get("http://172.31.239.223:8000/evenements");
    data = json.decode(response.body);
    // print("Response : ");
    // print(data);
    setState(() {
      data = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Evènements"),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.event),
                  title: Text("${data[index]["evenementNom"]}"),
                  subtitle: Text(
                    "Evenement de ${data[index]["evenementType"]}",
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Image.network(
                    "https://cdn.pixabay.com/photo/2014/05/02/21/50/laptop-336378_1280.jpg",
                    fit: BoxFit.fill, loadingBuilder: (BuildContext context,
                        Widget child, ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Début:${data[index]["evenementDateDebut"]} / Fin:${data[index]["evenementDateDebut"]}",
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(alignment: MainAxisAlignment.center, children: [
                  FlatButton(
                    textColor: Colors.blueAccent,
                    color: Colors.orange,
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Text(
                      'En Savoir +',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }
}
 */
