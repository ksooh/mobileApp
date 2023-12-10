import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login/firebase_options.dart';
import 'login/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mainPage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
//GetMaterialApp
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MapEasy',
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const MainPage();
            } else {
              return const LoginPage();
            }
          }),
    );
  }
}
