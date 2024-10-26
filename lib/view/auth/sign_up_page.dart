import 'package:flutter/material.dart';
import 'package:learn_wise/utils/app_styles.dart';
import 'package:learn_wise/view/main_navigation_page.dart';
import 'package:learn_wise/viewmodels/auth_view_model.dart';
import 'package:learn_wise/widgets/dialogs/error_dialog.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
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
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Sign Up',
                    style: AppStyles.heading1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _nameController,
                  decoration: AppStyles.textFieldDecoration('Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _lastNameController,
                  decoration: AppStyles.textFieldDecoration('Last Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your last name' : null,
                ),
                const SizedBox(height: 20),
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
                  validator: (value) => value!.length < 6
                      ? 'Password must be at least 6 characters'
                      : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  decoration: AppStyles.textFieldDecoration('Phone'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your phone number' : null,
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await authViewModel.signUp(
                          _nameController.text,
                          _lastNameController.text,
                          _emailController.text,
                          _passwordController.text,
                          _phoneController.text,
                          'USER',
                        );
                        if (authViewModel.errorMessage != null) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ErrorDialog(
                                errorMessage: authViewModel.errorMessage!,
                              );
                            },
                          );
                        } else {
                          // Başarılı bir kayıt işlemi sonrası başka bir sayfaya geçiş yapın
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainNavigationPage(),
                            ),
                          );
                        }
                      }
                    },
                    style: AppStyles.primaryButtonStyle.copyWith(
                      backgroundColor: WidgetStateProperty.all(Colors.black),
                    ),
                    child: const Text('Sign Up'),
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
