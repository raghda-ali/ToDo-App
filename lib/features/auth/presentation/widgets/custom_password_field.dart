
import 'package:flutter/material.dart';
import 'package:todo_app/core/widgets/custom_text_field.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController passwordController;
  const CustomPasswordField({super.key, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Password",
      hintText: "Enter your password",
      controller: passwordController,
      obscureText: true,
      prefixIcon: Icons.lock,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }
}
