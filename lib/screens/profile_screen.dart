import 'package:flutter/material.dart';
import 'dart:convert' show json;

class ProfileScreen extends StatefulWidget {
  final String email;
  final bool isConnected;

  ProfileScreen({required this.email, required this.isConnected});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<String> profileImageURL;
  String? phoneNumber;

  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profileImageURL = _initializeProfileImage();
  }

  Future<String> _initializeProfileImage() async {
    String name = widget.email.split('@').first;
    bool isFemale = await _isUserFemale(name);

    if (isFemale) {
      return "assets/images/prfml.jpg";
    } else {
      return "assets/images/prf.jpg";
    }
  }

  Future<bool> _isUserFemale(String name) async {
    List<String> femaleNames = await _loadNamesFromJson('assets/female_names.json');
    return femaleNames.contains(name.toLowerCase());
  }

  Future<List<String>> _loadNamesFromJson(String assetPath) async {
    String namesJson = await DefaultAssetBundle.of(context).loadString(assetPath);
    List<dynamic> namesList = json.decode(namesJson);
    return namesList.map((dynamic name) => name.toString().toLowerCase()).toList();
  }

  void _showPhoneNumberDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.lightGreen[50],
          title: Text('Ajouter Votre Numéro',style: TextStyle(color: Colors.black),),
          content: TextField(
            cursorColor: Colors.black,
            controller: _phoneNumberController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(labelText: 'Numéro de Télephone',labelStyle: TextStyle(color: Colors.black),focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black))),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Annuler',style: TextStyle(color: Colors.black),),
            ),
            TextButton(
              onPressed: () {
                _savePhoneNumberToFirebase();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Enregistré',style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  void _savePhoneNumberToFirebase() {
    setState(() {
      phoneNumber = _phoneNumberController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<String>(
        future: profileImageURL,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur lors du chargement de l'image de profil."));
          } else {
            String profileImageURL = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.green.shade400,
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(profileImageURL),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.email.split('@').first,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            if (widget.isConnected)
                              Text(
                                'Connecté',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: ListTile(
                      leading: Icon(Icons.email, color: Colors.green.shade400),
                      title: Text(widget.email),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: ListTile(
                      leading: Icon(Icons.person_3, color: Colors.green.shade400),
                      title: Text(widget.email.split('@').first),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: ListTile(
                      leading: Icon(Icons.phone, color: Colors.green.shade400),
                      title: Text('Numéro de Télephone'),
                      subtitle: phoneNumber != null ? Text(phoneNumber!) : Text('Ajouter un Numéro Télephone'),
                      trailing: GestureDetector(
                        onTap: _showPhoneNumberDialog,
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: ListTile(
                      leading: Icon(Icons.apartment_outlined, color: Colors.green.shade400),
                      title: Text('OCP Group'),
                      subtitle: Text('Digital Factory'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

