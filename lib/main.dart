import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:tmms/authetification/forgotpass.dart';
import 'package:tmms/authetification/login.dart';
import 'package:tmms/patient/patientlanding.dart';

import 'authetification/register.dart';
import 'doctor/doctorlanding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TMMS',
      theme: ThemeData(
          colorScheme:
          ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 23, 0, 154)),
          useMaterial3: true,
          textTheme: Theme.of(context).textTheme.apply(
              displayColor: Color.fromARGB(255, 160, 192, 252),
              bodyColor: Colors.white)),
      home: Login(),
      routes: {
        '/login': (context) => Login(),
        '/register': (context) =>   RegisterPage(),
        '/forgotpass': (context) => const forgotpass(),
        '/patientlanding': (context) =>  PatientLanding(),
        '/doctorlanding': (context) => DoctorLanding(),
      },
    );
  }
}
