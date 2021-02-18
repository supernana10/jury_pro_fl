import 'dart:convert';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

// ignore: must_be_immutable
class EvenementCreateOrUpdate extends StatefulWidget {
  @override
  _EvenementCreateOrUpdateState createState() =>
      _EvenementCreateOrUpdateState();

  int evenementId = 0;
  EvenementCreateOrUpdate({this.evenementId});
}

class _EvenementCreateOrUpdateState extends State<EvenementCreateOrUpdate> {
  Map<String, dynamic> evenement;
  bool get isEditing => widget.evenementId > 0;
  @override
  void initState() {
    super.initState();
    if (isEditing) {
      fetchEvenement(widget.evenementId);
    }
  }

  Future<Map<String, dynamic>> fetchEvenement(int eventId) async {
    final response =
        await http.get('http://172.31.240.97:8000/evenements/$eventId');
    if (response.statusCode == 200) {
      setState(() {
        evenement = jsonDecode(response.body);
      });
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load evenement');
    }
  }

  TextEditingController nom = new TextEditingController();
  TextEditingController type = new TextEditingController();
  TextEditingController dateDebut = new TextEditingController();
  TextEditingController dateFin = new TextEditingController();

  Future<Map<String, dynamic>> updateEvenement(BuildContext context, int id,
      String nom, String type, String dateDebut, String dateFin) async {
    final http.Response response = await http.post(
      'http://172.31.240.97:8000/evenements',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "evenement_id": id,
        "evenement_nom": nom,
        "evenement_type": type,
        "evenement_date_debut": dateDebut,
        "evenement_date_fin": dateFin,
        "evenement_photo": null
      }),
    );
    print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Alert(
        context: context,
        title: "EVENEMENT",
        desc: "Enregistrer avec success.",
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
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update evenement.');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: Text(
              isEditing ? "Modifier" : "Ajouter",
              style: TextStyle(fontSize: 25.0, color: Colors.black),
            ),
          ),
          backgroundColor: Colors.deepOrange),
      body: Column(children: [
        Padding(
          padding:
              const EdgeInsets.only(bottom: 5, left: 20, right: 20, top: 20),
          child: TextFormField(
            onChanged: (String value) {},
            controller: nom,
            //initialValue: isEditing ? evenement['evenement_nom'] : null,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Color(0xFF0F2E48), fontSize: 14),
            autofocus: false,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFFAAB5C3))),
                filled: true,
                labelText: 'Nom',
                fillColor: Color(0xFFF3F3F5),
                focusColor: Color(0xFFF3F3F5),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFFAAB5C3))),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFFE7004C))),
                hintText: 'Nom'),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 5, left: 20, right: 20, top: 20),
          child: TextFormField(
              onChanged: (String value) {},
              controller: nom,
              //initialValue: isEditing ? evenement['evenement_type'] : null,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Color(0xFF0F2E48), fontSize: 14),
              autofocus: false,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Color(0xFFAAB5C3))),
                  filled: true,
                  labelText: 'Type',
                  fillColor: Color(0xFFF3F3F5),
                  focusColor: Color(0xFFF3F3F5),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Color(0xFFAAB5C3))),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Color(0xFFE7004C))),
                  hintText: 'Entrer le type d\'evenement')),
        ),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 5, left: 20, right: 20, top: 20),
          child: DateField(
            selectedDate: DateTime.parse(
                isEditing ? evenement['evenement_date_debut'] : '2021-01-01'),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFFAAB5C3))),
                filled: true,
                labelText: 'Date de debut',
                fillColor: Color(0xFFF3F3F5),
                focusColor: Color(0xFFF3F3F5),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFFAAB5C3))),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFFE7004C))),
                hintText: 'Entrer la date de debut'),
            onDateSelected: (value) async {
              setState(() {
                //dateFin2 = value.toString();
              });
            },
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 5, left: 20, right: 20, top: 20),
          child: DateField(
            selectedDate: DateTime.parse(
                isEditing ? evenement['evenement_date_fin'] : "2021-01-01"),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFFAAB5C3))),
                filled: true,
                labelText: 'Date de fin',
                fillColor: Color(0xFFF3F3F5),
                focusColor: Color(0xFFF3F3F5),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFFAAB5C3))),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFFE7004C))),
                hintText: 'Entrer la date de fin'),
            onDateSelected: (value) async {
              setState(() {
                //dateFin2 = value.toString();
              });
            },
          ),
        ),
        /* ElevatedButton(
          child: Text(
            isEditing ? 'Modifier' : 'Ajouter',
          ),
          onPressed: () {
            //print(dateDebut2);
            setState(() {
              //updateEvenement(context, widget.evenementId, this.nom2,
              //    this.type2, this.dateDebut2, this.dateFin2);
            });
          },
        ), */
      ]),
    );
  }
}
