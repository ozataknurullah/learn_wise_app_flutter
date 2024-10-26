import 'package:flutter/material.dart';
import 'package:learn_wise/utils/app_styles.dart';
import 'package:learn_wise/view/auth/sign_up_page.dart';
import 'package:learn_wise/view/main_navigation_page.dart';
import 'package:learn_wise/viewmodels/auth_view_model.dart';
import 'package:learn_wise/widgets/dialogs/error_dialog.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Login',
                    style: AppStyles.heading1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  decoration: AppStyles.textFieldDecoration('Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: AppStyles.textFieldDecoration('Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await authViewModel.login(
                          _emailController.text,
                          _passwordController.text,
                        );

                        if (authViewModel.errorMessage == null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainNavigationPage(),
                            ),
                          );
                        } else {
                          // Giriş başarısızsa hata mesajını gösteriyoruz.
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ErrorDialog(
                                errorMessage: authViewModel.errorMessage!,
                              );
                            },
                          );
                        }
                      }
                    },
                    style: AppStyles.primaryButtonStyle.copyWith(
                      backgroundColor:
                          WidgetStateProperty.all(AppStyles.accentColor),
                    ),
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
