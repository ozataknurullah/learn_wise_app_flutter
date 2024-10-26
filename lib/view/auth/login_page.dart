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
                  child: authViewModel.isLoading
                      ? CircularProgressIndicator() // Loading animasyonu
                      : ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              authViewModel.setLoading(true); // Loading başlat
                              await authViewModel.login(
                                _emailController.text,
                                _passwordController.text,
                              );

                              authViewModel.setLoading(false); // Loading durdur

                              if (authViewModel.errorMessage == null) {
                                // Başarılı bir giriş sonrası kullanıcıya pop-up mesaj gösteriyoruz
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    Future.delayed(Duration(seconds: 1), () {
                                      Navigator.of(context)
                                          .pop(); // Pop-up kaybolsun
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MainNavigationPage(),
                                        ),
                                      );
                                    });
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      backgroundColor: AppStyles.accentColor,
                                      child: const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.check_circle_outline,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                            SizedBox(height: 16),
                                            Text(
                                              'Giriş Başarılı!',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
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
