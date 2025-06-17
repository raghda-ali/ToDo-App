import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/routers_names.dart';
import 'package:todo_app/core/widgets/custom_elevated_button.dart';
import 'package:todo_app/features/auth/presentation/provider/authentication_provider.dart';
import 'package:todo_app/features/auth/presentation/widgets/custom_email_field.dart';
import 'package:todo_app/features/auth/presentation/widgets/custom_password_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    authProvider.registerEmailController.clear();
    authProvider.registerPasswordController.clear();
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
            key: registerFormKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Register Account',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                CustomEmailField(
                  emailController: authProvider.registerEmailController,
                ),
                SizedBox(height: 10),
                CustomPasswordField(
                  passwordController: authProvider.registerPasswordController,
                ),
                const SizedBox(height: 50),
                CustomElevatedButton(
                  onPressed: () async {
                    if (!registerFormKey.currentState!.validate()) {
                      return;
                    }

                    final error = await authProvider.register(
                      authProvider.registerEmailController.text,
                      authProvider.registerPasswordController.text,
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
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                ),

                SizedBox(height: 20),
                Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have account ?'),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RoutersNames.loginPage);
                      },
                      child: Text(
                        'Login',
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
