import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/l10n/app_localizations.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../utils/validators.dart';
import '../widgets/custom_app_bar.dart';
import 'shopping_home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
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
            localizations.accountSignInSuccessfully,
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
        title: localizations.signIn,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localizations.signInToAccount,
                style: const TextStyle(
                  fontFamily: 'Suwannaphum',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 30),
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
              const SizedBox(height: 30),
              CustomButton(
                text: localizations.signIn,
                onPressed: _handleSignIn,
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