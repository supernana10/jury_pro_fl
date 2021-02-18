import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Candidat extends StatefulWidget {
  @override
  _CandidatState createState() => _CandidatState();
}

class _CandidatState extends State<Candidat> {
  List data;
  List candidats;
  String code;
  String nom;
  String prenom;
  String mail;
  String tel;
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  final picker = ImagePicker();

  Map<String, dynamic> datas;

  String get uri => null;

  Future getData() async {
    var response = await http.get("http://172.31.240.97:8000/candidats");
    data = json.decode(response.body);
    print(data);
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

  Widget listView(List data) {
    return ListView.builder(
        itemCount: data.length ?? 0,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.all(10.0),
            title: Text(data[index]["candidat_nom"]),
            subtitle: Text(data[index]["candidat_email"]),
            trailing: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onTap: () {},
          );
        });
  }

  Future deleteEvenements(uri) async {
    String _uri = uri;

    var request = http.Request('POST',
        Uri.parse('http://172.31.240.97:8000/candidats/delete/' + _uri));
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
          title: Text("Candidats"),
          backgroundColor: Colors.deepOrange,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  addCandidat();
                })
          ],
        ),
        body: data != null ? listView(data) : waitData());
  }

  Widget getDisplayData() {
    print(data[0]);
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

  Future addCandidat() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext popContext) {
          return SimpleDialog(
            elevation: 20.0,
            title: Text(
              "Ajouter un candidat",
              textAlign: TextAlign.center,
            ),
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Code',
                      ),
                      onChanged: (data) {
                        setState(() {
                          this.code = data;
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nom',
                      ),
                      onChanged: (data) {
                        setState(() {
                          this.nom = data;
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Prénom',
                      ),
                      onChanged: (data) {
                        setState(() {
                          this.prenom = data;
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      onChanged: (data) {
                        setState(() {
                          this.mail = data;
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Téléphone',
                      ),
                      onChanged: (data) {
                        setState(() {
                          this.tel = data;
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      children: <Widget>[
                        RaisedButton(
                            child: Text("Photo"),
                            onPressed: () {
                              getImage();
                            }),
                        showImage()
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                      child: Text("Annuler"),
                      color: Colors.transparent,
                      onPressed: () {}),
                  RaisedButton(
                      child: Text("Enregistrer"),
                      color: Colors.deepOrange,
                      onPressed: () {
                        postData();
                      }),
                ],
              )
            ],
          );
        });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  getImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  Future postData() async {
    datas = {
      "candidat_code": this.code,
      "candidat_nom": this.nom,
      "candidat_prenom": this.prenom,
      "candidat_email": this.mail,
      "candidat_telephone": this.tel,
      "candidat_photo": this.base64Image,
    };
    final http.Response response = await http.post(
        "http://172.31.240.97:8000/candidats",
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(datas));
  }
}
