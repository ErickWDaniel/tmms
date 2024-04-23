import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tmms/tools/forgotpasspanel.dart';

class forgotpass extends StatefulWidget {
  const forgotpass({Key? key}) : super(key: key);

  @override
  State<forgotpass> createState() => _forgotpassState();
}

class _forgotpassState extends State<forgotpass> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent. Please check your email.'),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.green,
        ),
      );
      // Navigate back to login screen after sending reset email
      Navigator.pop(context);
    } catch (e) {
      print('Error sending password reset email: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error sending password reset email. Please try again.'),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/picture/tmmsmain.jpeg'),
            fit: BoxFit.cover,
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withOpacity(0.5),
                ),
                padding: const EdgeInsets.all(20),
                child: ForgotPassPanel(
                  onResetPressed: _resetPassword,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
