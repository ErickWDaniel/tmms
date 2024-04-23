import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tmms/tools/registerpanel.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late FirebaseAuth _auth;
  late DatabaseReference _database;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  String _userType = 'doctor'; // Default user type

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _database = FirebaseDatabase.instance.reference();
  }

  void _registerUser() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        // Send email verification
        await userCredential.user!.sendEmailVerification();
        // Save user data
        String userId = userCredential.user!.uid;
        await _saveUserData(userId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'User registered successfully! Confirmation email has been sent.',
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 5),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushNamed(context, '/login');
      }
    } catch (e) {
      print('Error registering user: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Error registering user. Please try again.',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveUserData(String userId) async {
    await _database.child('users').child(userId).set({
      'userType': _userType,
      'email': _emailController.text.trim(),
      'fullName': _fullNameController.text.trim(),
      'phoneNumber': _phoneNumberController.text.trim(),
      'userId': _idController.text.trim(),
    });
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
                child: RegisterPanel(
                  registerCallback: _registerUser,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  fullNameController: _fullNameController,
                  phoneNumberController: _phoneNumberController,
                  idController: _idController,
                  userType: _userType,
                  onUserTypeChanged: (String userType) {
                    setState(() {
                      _userType = userType;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
