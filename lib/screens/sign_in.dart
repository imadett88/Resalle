import 'package:flutter/material.dart';
import 'dart:ffi';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_ahtu/screens/home.dart';
import 'package:animated_text_kit/animated_text_kit.dart';



class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool showPassword = false;

  bool isValidOcpGroupEmail(String email) {
    // Check the email
    return email.toLowerCase().endsWith("@ocpgroup.ma") || email.toLowerCase().endsWith("@admin-ocpgroup.ma");
  }


  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          backgroundColor: Colors.lightGreen[50],
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Vous devez être membre du Groupe OCP (@ocpgroup.ma) pour vous connecter.',style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler',style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Se Connecter',style: TextStyle(color: Colors.black)),
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  var methods = await auth.fetchSignInMethodsForEmail(email);
                  if (methods.contains('password')) {
                    var user = await auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  } else {
                    var user = await auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/back.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Container(
                constraints: BoxConstraints(maxWidth: 350.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 180,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Center(
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'Bienvenue',
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                              speed: const Duration(milliseconds: 200),
                            ),
                          ],
                          totalRepeatCount: 100,
                          pause: const Duration(milliseconds: 500),
                          displayFullTextOnTap: true,
                          stopPauseOnTap: true,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          'Inscrivez-vous et réservez la salle',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 50.0),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Address Email',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 16.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.email,color: Colors.green.shade400,)
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Mot de Passe',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 16.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.lock,color: Colors.green.shade400,),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            child: Icon(
                              showPassword ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          // Check if the email is valid
                          if (!isValidOcpGroupEmail(email)) {
                            // Show a confirmation dialog
                            await showConfirmationDialog(context);
                          } else {
                            try {
                              var methods = await auth.fetchSignInMethodsForEmail(email);
                              if (methods.contains('password')) {
                                // Email is already registered, sign in the user
                                var user = await auth.signInWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              } else {
                                var user = await auth.createUserWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green.shade400,
                          elevation: 0.0,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        child: Text(
                          'Se Connecter',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.white,
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
          Positioned(
            bottom: 20.0, // Adjust the position as needed
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Text(
                    '2023 OCP Group © Tous Les Droits Sont Réservé',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )]
      ),


    );
  }
}
