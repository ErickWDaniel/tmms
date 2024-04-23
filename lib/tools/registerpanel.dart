import 'package:flutter/material.dart';

class RegisterPanel extends StatefulWidget {
  final Function() registerCallback;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController fullNameController;
  final TextEditingController phoneNumberController;
  final TextEditingController idController;
  final String userType;
  final ValueChanged<String> onUserTypeChanged;

  const RegisterPanel({
    Key? key,
    required this.registerCallback,
    required this.emailController,
    required this.passwordController,
    required this.fullNameController,
    required this.phoneNumberController,
    required this.idController,
    required this.userType,
    required this.onUserTypeChanged,
  }) : super(key: key);

  @override
  _RegisterPanelState createState() => _RegisterPanelState();
}

class _RegisterPanelState extends State<RegisterPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Registration',
            style: TextStyle(
              fontSize: 32,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Radio<String>(
                value: 'doctor',
                groupValue: widget.userType,
                onChanged: (value) {
                  widget.onUserTypeChanged(value!);
                },
              ),
              const Text('Doctor', style: TextStyle(color: Colors.white)),
              const SizedBox(width: 20),
              Radio<String>(
                value: 'patient',
                groupValue: widget.userType,
                onChanged: (value) {
                  widget.onUserTypeChanged(value!);
                },
              ),
              const Text('Patient', style: TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 10),
          _buildTextField(
            hintText: widget.userType == 'doctor' ? 'Doctor ID' : 'Patient ID',
            controller: widget.idController,
          ),
          _buildTextField(
            hintText: 'Full Name',
            controller: widget.fullNameController,
          ),
          _buildTextField(
            hintText: 'Phone Number',
            controller: widget.phoneNumberController,
            keyboardType: TextInputType.phone,
          ),
          _buildTextField(
            hintText: 'Email',
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          _buildTextField(
            hintText: 'Password',
            controller: widget.passwordController,
            obscureText: true,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 28,
                  color: Color.fromARGB(255, 66, 58, 180),
                ),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: widget.registerCallback,
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 24, color: Colors.green),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required TextEditingController controller,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return TextFormField(
      enabled: widget.userType != null,
      textAlign: TextAlign.center,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
      ),
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}
