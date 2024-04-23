import 'package:flutter/material.dart';

class LoginPanel extends StatelessWidget {
  final Function() loginCallback;
  final TextEditingController userEmailController;
  final TextEditingController userPasswordController;
  final TextEditingController userIDController;

  const LoginPanel({
    Key? key,
    required this.loginCallback,
    required this.userEmailController,
    required this.userPasswordController,
    required this.userIDController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Welcome',
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        TextFormField(
          textAlign: TextAlign.center,
          controller: userEmailController,
          decoration: const InputDecoration(
            hintText: 'User Email',
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 10),
        TextFormField(
          textAlign: TextAlign.center,
          controller: userPasswordController,
          decoration: const InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(color: Colors.white),
          ),
          obscureText: true,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: loginCallback,
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text(
                'Register',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ],
        )
      ],
    );
  }
}
