import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ReservationModifyScreen extends StatefulWidget {
  final String reservationKey;
  final Map<dynamic, dynamic> initialData;

  const ReservationModifyScreen({required this.reservationKey, required this.initialData});

  @override
  _ReservationModifyScreenState createState() => _ReservationModifyScreenState();
}

class _ReservationModifyScreenState extends State<ReservationModifyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _nomDemandeurController;
  late TextEditingController _matriculeController;
  late TextEditingController _dateController;
  late TextEditingController _effectifController;
  late TextEditingController _heureDebutController;
  late TextEditingController _heureFinController;
  late TextEditingController _objetReunionController;

  @override
  void initState() {
    super.initState();
    _nomDemandeurController = TextEditingController(text: widget.initialData['nom_demandeur'].toString());
    _matriculeController = TextEditingController(text: widget.initialData['matricule'].toString());
    _dateController = TextEditingController(text: widget.initialData['date'].toString());
    _effectifController = TextEditingController(text: widget.initialData['effectif'].toString());
    _heureDebutController = TextEditingController(text: widget.initialData['heure_debut'].toString());
    _heureFinController = TextEditingController(text: widget.initialData['heure_fin'].toString());
    _objetReunionController = TextEditingController(text: widget.initialData['objet_reunion'].toString());
  }

  @override
  void dispose() {
    _nomDemandeurController.dispose();
    _matriculeController.dispose();
    _dateController.dispose();
    _effectifController.dispose();
    _heureDebutController.dispose();
    _heureFinController.dispose();
    _objetReunionController.dispose();
    super.dispose();
  }

  void _updateReservation() async {
    if (_formKey.currentState!.validate()) {
      final updatedReservation = {
        'nom_demandeur': _nomDemandeurController.text,
        'matricule': _matriculeController.text,
        'date': _dateController.text,
        'effectif': _effectifController.text,
        'heure_debut': _heureDebutController.text,
        'heure_fin': _heureFinController.text,
        'objet_reunion': _objetReunionController.text,
      };

      await FirebaseDatabase.instance
          .reference()
          .child('reservations')
          .child(widget.reservationKey)
          .update(updatedReservation);

      print("Réservation Mise à Jour: $updatedReservation");

      Navigator.pop(context);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: _nomDemandeurController,
                    decoration: InputDecoration(
                        labelText: 'Nom du Demandeur',
                    labelStyle: TextStyle(color: Colors.black,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.green.shade400,
                            )
                        )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ce champ est requis';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 14),
              TextFormField(
                cursorColor: Colors.black,
                controller: _matriculeController,
                decoration: InputDecoration(
                    labelText: 'Matricule',
                    labelStyle: TextStyle(color: Colors.black,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.green.shade400,
                        )
                    )
                ),
              ),
                  SizedBox(height: 14),
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: _objetReunionController,
                    decoration: InputDecoration(
                        labelText: 'Objet de reunion',
                        labelStyle: TextStyle(color: Colors.black,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.green.shade400,
                            )
                        )
                    ),
                  ),
                  SizedBox(height: 14),
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: _dateController,
                    decoration: InputDecoration(
                        labelText: 'Date',
                        labelStyle: TextStyle(color: Colors.black,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.green.shade400,
                            )
                        )
                    ),
                  ),
                  SizedBox(height: 14),
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: _heureDebutController,
                    decoration: InputDecoration(
                        labelText: 'Heure debut',
                        labelStyle: TextStyle(color: Colors.black,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.green.shade400,
                            )
                        )
                    ),
                  ),
                  SizedBox(height: 14),
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: _heureFinController,
                    decoration: InputDecoration(
                        labelText: 'Heure fin',
                        labelStyle: TextStyle(color: Colors.black,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.green.shade400,
                            )
                        )
                    ),
                  ),
                  SizedBox(height: 14),
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: _effectifController,
                    decoration: InputDecoration(
                        labelText: 'Effectif',
                        labelStyle: TextStyle(color: Colors.black,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.green.shade400,
                            )
                        )
                    ),
                  ),

                  SizedBox(height: 16),

                  FloatingActionButton(
                    backgroundColor: Colors.green.shade400,
                    onPressed: _updateReservation,
                    child: Icon(Icons.save,color: Colors.white,size: 33,),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
