import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/l10n/app_localizations.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../utils/validators.dart';
import '../widgets/custom_app_bar.dart';
import 'shopping_home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    final localizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            localizations.accountCreatedSuccessfully,
            style: const TextStyle(fontFamily: 'Suwannaphum'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToShopping();
              },
              child: Text(
                localizations.close,
                style: const TextStyle(fontFamily: 'Suwannaphum'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToShopping() {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ShoppingHomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: localizations.signUp,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localizations.createAccount,
                style: const TextStyle(
                  fontFamily: 'Suwannaphum',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                controller: _fullNameController,
                labelText: localizations.fullName,
                validator: Validators.validateFullName,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _emailController,
                labelText: localizations.email,
                validator: Validators.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _passwordController,
                labelText: localizations.password,
                validator: Validators.validatePassword,
                obscureText: true,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _confirmPasswordController,
                labelText: localizations.confirmPassword,
                validator: (value) => Validators.validateConfirmPassword(
                  value,
                  _passwordController.text,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: localizations.signUp,
                onPressed: _handleSignUp,
                backgroundColor: Colors.deepPurple,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}