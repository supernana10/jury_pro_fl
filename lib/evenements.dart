import 'package:flutter/material.dart';
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
        await http.get("http://172.31.240.97:8000/evenements");
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
                    "https://www.itgenius.co.th/assets/frondend/images/picarticle/HDGraphics_consumer14109502229065.jpg",
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
