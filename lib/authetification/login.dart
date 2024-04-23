import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tmms/tools/loginpanel.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late FirebaseAuth _auth;
  late DatabaseReference _database;

  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _userIDController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _database = FirebaseDatabase.instance.reference();

    // Check if the user is already logged in
    _redirectLoggedInUser();
  }

  Future<void> _redirectLoggedInUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;
      await _checkUserTypeAndNavigate(userId);
    }
  }

  Future<void> _loginUser() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _userEmailController.text.trim(),
        password: _userPasswordController.text.trim(),
      );

      if (userCredential.user != null) {
        String userId = userCredential.user!.uid;
        await _checkUserTypeAndNavigate(userId);
      }
    } catch (e) {
      print('Error logging in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error logging in. Please try again.'),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _checkUserTypeAndNavigate(String userId) async {
    try {
      DataSnapshot snapshot = (await _database.child('users').child(userId).once()).snapshot;

      if (snapshot != null && snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic>? userData = snapshot.value as Map<dynamic, dynamic>;

        if (userData!.containsKey('userType')) {
          String userType = userData['userType'];
          if (userType == 'doctor') {
            Navigator.pushReplacementNamed(context, '/doctorlanding');
          } else if (userType == 'patient') {
            Navigator.pushReplacementNamed(context, '/patientlanding');
          } else {
            print('Unknown user type: $userType');
          }
        } else {
          print('User type is missing in user data');
        }
      } else {
        print('Snapshot is null or not of type Map<dynamic, dynamic>');
      }
    } catch (e) {
      print('Error retrieving user data: $e');
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
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'T.M.M.S',
                style: TextStyle(
                  fontSize: 44,
                  color: Color.fromARGB(255, 255, 3, 3),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
            Center(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withOpacity(0.5),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    LoginPanel(
                      loginCallback: _loginUser,
                      userEmailController: _userEmailController,
                      userPasswordController: _userPasswordController,
                      userIDController: _userIDController,
                    ),
                    const Divider(
                      color: Color.fromRGBO(76, 175, 80, 1),
                      thickness: 1,
                      height: 3,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgotpass');
                      },
                      child: const Text(
                        'Forgot password',
                        style: TextStyle(
                          color: Color.fromARGB(255, 253, 32, 32),
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
