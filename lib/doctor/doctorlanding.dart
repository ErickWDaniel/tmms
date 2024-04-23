import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoctorLanding extends StatelessWidget {
  const DoctorLanding({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctor"),
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "Doctor",
          style: TextStyle(fontSize: 32, color: Colors.black),
        ),
      ),
    );
  }
}
