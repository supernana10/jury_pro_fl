import 'package:flutter/material.dart';
import 'package:JuryPro/candidats.dart';
import 'package:JuryPro/DesignForm/InputDeco_design.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class AjouterCandidat extends StatefulWidget {
  @override
  _AjouterCandidatState createState() => _AjouterCandidatState();
}

class _AjouterCandidatState extends State<AjouterCandidat> {
  static final String uploadEndPoint =
      'http://localhost/upload_image/upload_image.php';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) {
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
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
          return CircleAvatar(
            radius: 80,
            backgroundColor: Colors.white,
            child: Image.file(
              snapshot.data,
              fit: BoxFit.cover,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            "Pas d'image sélectionner",
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  //TextController to read text entered in text field
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telephone = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // ignore: missing_return
  Future<Map<String, dynamic>> addCandidat(BuildContext context, String nom,
      String prenom, int code, String email, int telephone) async {
    print(base64Image);
    final http.Response response = await http.post(
      'http://172.31.239.223:8000/candidats',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "candidat_nom": nom,
        "candidat_prenom": prenom,
        "candidat_code": code,
        "candidat_email": email,
        "candidat_telephone": telephone,
        "evenement_id": 2,
        "candidat_photo": base64Image
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Alert(
        context: context,
        title: "Candidat",
        desc: "Ajouter avec success.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
      Navigator.of(context).pop();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception("Echec de  l'ajout du Candidat.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajout d'un Candidat"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      showImage(),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10, top: 20),
                        child: TextFormField(
                          // ignore: unnecessary_brace_in_string_interps
                          //initialValue: Text(papa.data.candidatNom),
                          controller: nom,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(Icons.person, "Nom"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Entrer Votre nom S\'il vous plait';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            //name = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: TextFormField(
                          controller: prenom,
                          keyboardType: TextInputType.text,
                          decoration:
                              buildInputDecoration(Icons.person, "Prenom"),
                          onSaved: (String value) {
                            //email = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: TextFormField(
                          controller: code,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(Icons.code, "Code"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Entrer Votre numéro S\'il vous plait';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            // = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                              buildInputDecoration(Icons.email, "E-mail"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Entrer votre e-mail S\'il vous plait';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: TextFormField(
                          controller: telephone,
                          keyboardType: TextInputType.number,
                          decoration:
                              buildInputDecoration(Icons.phone, "Téléphone"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Entrer votre numéro S\'il vous plait';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                          width: 600,
                          height: 50,
                          child: Row(
                            children: [
                              RaisedButton(
                                color: Colors.orange,
                                onPressed: () {
                                  addCandidat(
                                      context,
                                      nom.text,
                                      prenom.text,
                                      code.hashCode,
                                      email.text,
                                      telephone.hashCode);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Candidats()));
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(
                                        color: Colors.black, width: 2)),
                                textColor: Colors.white,
                                child: Text("Ajouter"),
                              ),
                              RaisedButton(
                                color: Colors.orange,
                                onPressed: chooseImage,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(
                                        color: Colors.black, width: 2)),
                                textColor: Colors.white,
                                child: Text("Image"),
                              ),
                              RaisedButton(
                                color: Colors.green,
                                onPressed: startUpload,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(
                                        color: Colors.black, width: 2)),
                                textColor: Colors.white,
                                child: Text("upload"),
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
