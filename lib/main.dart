import 'package:flutter/material.dart';
import 'package:new_ahtu/screens/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.lightGreen[50],
      ),
      home: SignInScreen(),
    );
  }
}
