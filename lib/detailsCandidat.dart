import 'package:flutter/material.dart';
import 'package:JuryPro/DesignForm/InputDeco_design.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class DetailCandidat extends StatefulWidget {
  String idCandidat;
  DetailCandidat(this.idCandidat);
  @override
  _DetailCandidatState createState() => _DetailCandidatState(this.idCandidat);
}

Future<Post> fetchPost(String id) async {
  final response = await http.get('http://172.31.239.223:8000/candidats/$id');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Post.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('??? Echec du chargment des données ???');
  }
}

class Post {
  final String candidatNom;
  final String candidatPrenom;
  final String candidatCode;
  final String candidatEmail;
  final String candidatPhone;

  Post(
      {this.candidatNom,
      this.candidatPrenom,
      this.candidatCode,
      this.candidatEmail,
      this.candidatPhone});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      candidatNom: json['candidat_nom'],
      candidatPrenom: json['candidat_prenom'],
      candidatCode: json['candidat_code'].toString(),
    );
  }
}

///////

class _DetailCandidatState extends State<DetailCandidat> {
  String idCandidat;

  _DetailCandidatState(this.idCandidat);

  /*String name, email, phone;

  Map data;
  List evenements;

  Future getData() async {
    http.Response response =
        await http.get("http://172.31.241.50:8000/candidats/$idCandidat");
    data = json.decode(response.body);
    debugPrint(response.body);
    // print("Response : ");
    // print(data);
    setState(() {
      data = data;
    });
  }
*/
  String id;
  Future<Post> post;
  @override
  void initState() {
    super.initState();
    id = widget.idCandidat;
    //print(id);
    post = fetchPost(idCandidat); //fetchPost(id);
  }

  //TextController to read text entered in text field
  TextEditingController password = TextEditingController(text: "fdffdfdfdfdf");
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController code = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails Candidat"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<Post>(
                  future: post,
                  builder: (context, papa) {
                    if (papa.hasData) {
                      return Container(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundImage: NetworkImage(
                                  "http://e-adresse.net/img/img-dev.jpg"),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text("NOM"),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15, left: 10, right: 10),
                              child: TextFormField(
                                // ignore: unnecessary_brace_in_string_interps
                                //initialValue: Text(papa.data.candidatNom),
                                initialValue: papa.data.candidatNom,
                                keyboardType: TextInputType.text,
                                decoration:
                                    buildInputDecoration(Icons.person, "Nom"),
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
                            Text("PRENOM"),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15, left: 10, right: 10),
                              child: TextFormField(
                                initialValue: papa.data.candidatPrenom,
                                keyboardType: TextInputType.text,
                                decoration: buildInputDecoration(
                                    Icons.person, "Prenom"),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Entrer Votre mail S\'il vous plait';
                                  }
                                  if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return 'Entrer un mail valide S\'il vous plait';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  //email = value;
                                },
                              ),
                            ),
                            Text("CODE"),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15, left: 10, right: 10),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration:
                                    buildInputDecoration(Icons.code, "Code"),
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
                                //controller: password,
                                keyboardType: TextInputType.text,
                                decoration: buildInputDecoration(
                                    Icons.lock, "Mot de passe"),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Entrer un mot de passe S\'il vous plait';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15, left: 10, right: 10),
                              child: TextFormField(
                                controller: confirmpassword,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                decoration: buildInputDecoration(
                                    Icons.lock, "Confirmer"),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Retaper le mot de passe S\'il vous plait';
                                  }
                                  print(password.text);

                                  print(confirmpassword.text);

                                  if (password.text != confirmpassword.text) {
                                    return "Password does not match";
                                  }

                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              height: 50,
                              child: RaisedButton(
                                color: Colors.orange,
                                onPressed: () {
                                  if (_formkey.currentState.validate()) {
                                    print("successful");

                                    return;
                                  } else {
                                    print("UnSuccessfull");
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(
                                        color: Colors.black, width: 2)),
                                textColor: Colors.white,
                                child: Text("Modifier"),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
