import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'ReservationModifyScreen.dart';

class ResvListScreen extends StatefulWidget {
  const ResvListScreen({Key? key}) : super(key: key);

  @override
  State<ResvListScreen> createState() => _ResvListScreenState();
}

class _ResvListScreenState extends State<ResvListScreen> {
  final ref = FirebaseDatabase.instance.ref('reservations');
  bool _shouldRefresh = false;
  String? currentUserEmail;

  @override
  void initState() {
    super.initState();
    currentUserEmail = FirebaseAuth.instance.currentUser?.email;
  }

  Future<void> _removeReservation(String key) async {
    await ref.child(key).remove();
  }

  void _navigateToModifyScreen(String key, Map<dynamic, dynamic> reservationData) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservationModifyScreen(
          reservationKey: key,
          initialData: reservationData,
        ),
      ),
    );

    setState(() {
      _shouldRefresh = !_shouldRefresh;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 16.0),
        child: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  final reservation = snapshot.value as Map<dynamic, dynamic>;
                  final reservationKey = snapshot.key!;

                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: AssetImage('assets/images/salle.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.6),
                            BlendMode.dstATop,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (currentUserEmail?.toLowerCase().endsWith("@admin-ocpgroup.ma") ?? false)
                                  IconButton(
                                    icon: Icon(Icons.delete,color: Colors.red,size: 30,),
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.lightGreen[50],
                                            title: Text("Confirmation",style: TextStyle(color: Colors.black)),
                                            content: Text("Êtes-vous sûr de vouloir supprimer cette réservation?",style: TextStyle(color: Colors.black)),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Annuler", style: TextStyle(color: Colors.black)),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await _removeReservation(reservationKey);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Oui",style: TextStyle(color: Colors.black)),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                if (currentUserEmail?.toLowerCase().endsWith("@admin-ocpgroup.ma") ?? false)
                                  IconButton(
                                    icon: Icon(Icons.edit,color: Colors.green,size: 30,),
                                    onPressed: () {
                                      _navigateToModifyScreen(reservationKey, reservation);
                                    },
                                  ),
                              ],
                            ),
                            Text(
                              reservation['nom_demandeur'],
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(height: 8),
                            Text("Matricule: ${reservation['matricule']}",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("Date: ${reservation['date']}",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("Effectif: ${reservation['effectif']}"),
                            Text("Heure de début: ${reservation['heure_debut']}"),
                            Text("Heure de fin: ${reservation['heure_fin']}"),
                            Text("Objet de réunion: ${reservation['objet_reunion']}"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
