import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PatientLanding extends StatelessWidget {
  const PatientLanding({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      print('Error logging out: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error logging out. Please try again.'),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient"),
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Patient",
          style: TextStyle(fontSize: 32, color: Colors.black),
        ),
      ),
    );
  }
}
