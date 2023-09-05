import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert' show json;

import 'home.dart';
import 'home_src.dart';
import 'reserver_salle.dart';
import 'resv_list.dart';
import 'sign_in.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Widget> _screens = [];
  late User? _user;
  bool _isConnected = false;
  bool _isFemale = false;

  // Define the start time and date variables
  late DateTime startTime; // Retrieve this from Firebase
  late DateTime currentDate;
  @override
  void initState() {
    super.initState();
    _initializeUserInfo();
    startTime = DateTime(2023, 12, 12, 11, 00); // Replace this with your Firebase logic.
  }

  Future<void> _initializeUserInfo() async {
    _user = FirebaseAuth.instance.currentUser;
    _isFemale = await _isUserFemale();
    _initializeScreens();
  }

  void _initializeScreens() {
    setState(() {
      _screens = [
        Home(),
        ProfileScreen(
          email: _user?.email ?? '',
          isConnected: _user != null,
        ),
        ReserverScreen(),
        ResvListScreen(),
        SignInScreen(),
      ];
    });
  }

  Future<bool> _isUserFemale() async {
    List<String> femaleNames = await _loadNamesFromJson('assets/female_names.json');
    List<String> maleNames = await _loadNamesFromJson('assets/male_names.json');

    String name = _user?.displayName?.toLowerCase().trim() ?? '';
    return femaleNames.contains(name);
  }

  Future<List<String>> _loadNamesFromJson(String assetPath) async {
    String namesJson = await DefaultAssetBundle.of(context).loadString(assetPath);
    List<dynamic> namesList = json.decode(namesJson);
    return namesList.map((dynamic name) => name.toString().toLowerCase()).toList();
  }

  Future<void> _showLogoutConfirmationDialog() async {
    bool confirmed = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirmer la Sortie"),
          content: Text("Êtes-vous sûr de vouloir vous déconnecter?"),
          backgroundColor: Colors.lightGreen[50],
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Annuler", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("Confirmer", style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );

    if (confirmed) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
            (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.isNotEmpty ? _screens[_currentIndex] : Container(),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: _currentIndex == 0 ? Colors.green : Colors.black,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: _currentIndex == 1 ? Colors.green : Colors.black,
          ),
          Icon(
            Icons.add_home_work_rounded,
            size: 30,
            color: _currentIndex == 2 ? Colors.green : Colors.black,
          ),
          Icon(
            Icons.event_available,
            size: 30,
            color: _currentIndex == 3 ? Colors.green : Colors.black,
          ),
          Icon(
            Icons.logout,
            size: 30,
            color: _currentIndex == 4 ? Colors.green : Colors.black,
          ),
        ],
        color: Colors.green.shade400,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.decelerate,
        animationDuration: Duration(milliseconds: 600),
        onTap: (int index) {
          if (index == 4) {
            _showLogoutConfirmationDialog();
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }
}
