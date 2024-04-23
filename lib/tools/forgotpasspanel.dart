import 'package:flutter/material.dart';

class ForgotPassPanel extends StatelessWidget {
  final TextEditingController userForgotEmailController =
  TextEditingController();
  final void Function(String email) onResetPressed;

  ForgotPassPanel({Key? key, required this.onResetPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Forgot Password',
          style: TextStyle(
            fontSize: 24,
            color: Color.fromARGB(255, 21, 255, 0),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        TextFormField(
          textAlign: TextAlign.center,
          controller: userForgotEmailController,
          decoration: const InputDecoration(
            hintText: 'Enter Your Registered Email Here',
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 28,
                color: Colors.green,
              ),
            ),
            TextButton(
              onPressed: () {
                onResetPressed(userForgotEmailController.text.trim());
              },
              child: const Text(
                'RESET',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        )
      ],
    );
  }
}
