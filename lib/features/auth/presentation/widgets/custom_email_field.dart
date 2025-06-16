
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/widgets/custom_text_field.dart';
import 'package:todo_app/features/auth/presentation/provider/authentication_provider.dart';

class CustomEmailField extends StatelessWidget {
  final TextEditingController emailController;
  const CustomEmailField({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return   CustomTextField(
      label: "Email",
      hintText: "Enter your email",
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icons.email,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        final emailRegex = RegExp(
          r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
        );
        if (!emailRegex.hasMatch(value)) {
          return 'Enter a valid email';
        }
        return null;
      },
    );
  }
}
