import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/routers_names.dart';
import 'package:todo_app/core/widgets/custom_elevated_button.dart';
import 'package:todo_app/features/auth/presentation/provider/authentication_provider.dart';
import 'package:todo_app/features/auth/presentation/widgets/custom_email_field.dart';
import 'package:todo_app/features/auth/presentation/widgets/custom_password_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    authProvider.loginEmailController.clear();
    authProvider.loginPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 50,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Form(
            key: loginFormKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                CustomEmailField(
                  emailController: authProvider.loginEmailController,
                ),
                SizedBox(height: 10),
                CustomPasswordField(
                  passwordController: authProvider.loginPasswordController,
                ),
                const SizedBox(height: 50),
                CustomElevatedButton(
                  onPressed: () async {
                    if (!loginFormKey.currentState!.validate()) {
                      return;
                    }

                    final error = await authProvider.login(
                      authProvider.loginEmailController.text,
                      authProvider.loginPasswordController.text,
                    );
                    if (error != null) {
                      Fluttertoast.showToast(
                        msg: error,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    }
                    else {
                      if (!context.mounted) return;
                      Navigator.pushNamed(context, RoutersNames.homePage);
                    }
                  },
                  child:
                      authProvider.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                ),
                SizedBox(height: 20),
                Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member ?'),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RoutersNames.registerPage);
                      },
                      child: Text(
                        'SignUp now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
