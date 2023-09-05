import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';


class ReserverScreen extends StatefulWidget {
  @override
  _ReserverScreenState createState() => _ReserverScreenState();
}

class _ReserverScreenState extends State<ReserverScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _nomDemandeur;
  String? _matricule;
  String? _objetReunion;
  String? _date;
  String? _heureDebut;
  String? _heureFin;
  int? _effectif;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      DatabaseReference reservationsRef =
      FirebaseDatabase.instance.reference().child('reservations');
      reservationsRef.push().set({
        'nom_demandeur': _nomDemandeur,
        'matricule': _matricule,
        'objet_reunion': _objetReunion,
        'date': _date,
        'heure_debut': _heureDebut,
        'heure_fin': _heureFin,
        'effectif': _effectif,
      }).then((_) {
        _formKey.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Réservation enregistrée avec succès')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Une erreur est survenue')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white, // White background color
              padding: EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            labelText: 'Nom du demandeur',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28.0),
                                borderSide: BorderSide(
                                  color: Colors.green.shade400,
                                ))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir le nom du demandeur';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _nomDemandeur = value;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            labelText: 'Matricule',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28.0),
                                borderSide: BorderSide(
                                  color: Colors.green.shade400,
                                ))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir le matricule';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _matricule = value;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            labelText: 'Objet de la réunion',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28.0),
                                borderSide: BorderSide(
                                  color: Colors.green.shade400,
                                ))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir l\'objet de la réunion';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _objetReunion = value;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            labelText: 'Date',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28.0),

                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28.0),
                                borderSide: BorderSide(
                                  color: Colors.green.shade400,
                                )
                            )
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir la date';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _date = value;
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                  labelText: 'Heure de début',
                                  labelStyle: TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(28.0),
                                      borderSide: BorderSide(
                                        color: Colors.green.shade400,
                                      )
                                  )
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez saisir l\'heure de début';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _heureDebut = value;
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                  labelText: 'Heure de fin',
                                  labelStyle: TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(28.0),
                                      borderSide: BorderSide(
                                        color: Colors.green.shade400,
                                      )
                                  )
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez saisir l\'heure de fin';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _heureFin = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            labelText: 'Effectif',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28.0),
                                borderSide: BorderSide(
                                  color: Colors.green.shade400,
                                )
                            )
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir l\'effectif';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Veuillez saisir un nombre valide';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _effectif = int.tryParse(value!);
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(
                          'Réserver',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green.shade400, // Button color
                          onPrimary: Colors.black, // Text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}