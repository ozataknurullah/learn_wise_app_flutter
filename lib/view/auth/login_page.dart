import 'package:flutter/material.dart';
import 'package:learn_wise/utils/app_styles.dart';
import 'sign_up_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min, // İçeriği sıkıştırmak için
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('Logged in with email: ${_emailController.text}');
                      }
                    },
                    style: AppStyles.primaryButtonStyle.copyWith(
                      backgroundColor:
                          MaterialStateProperty.all(AppStyles.accentColor),
                    ),
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialMediaButton(Icons.g_mobiledata),
                      const SizedBox(width: 20),
                      _socialMediaButton(Icons.facebook),
                      const SizedBox(width: 20),
                      _socialMediaButton(Icons.alternate_email),
                    ],
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

  Widget _socialMediaButton(IconData icon) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.black12,
      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}
