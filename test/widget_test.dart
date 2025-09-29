import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_shopping_app/main.dart';
import 'package:flutter_shopping_app/screens/welcome_screen.dart';
import 'package:flutter_shopping_app/screens/signup_screen.dart';
import 'package:flutter_shopping_app/screens/signin_screen.dart';
import 'package:flutter_shopping_app/screens/shopping_home_screen.dart';

void main() {
  group('Flutter Shopping App Tests', () {
    Widget createTestableWidget(Widget child) {
      return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        home: child,
      );
    }

    testWidgets('ShoppingApp creates without errors',
        (WidgetTester tester) async {
      await tester.pumpWidget(const ShoppingApp());
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('WelcomeScreen displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const WelcomeScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Welcome'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNWidgets(2));
    });

    testWidgets('WelcomeScreen navigation to SignUp works',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const WelcomeScreen()));
      await tester.pumpAndSettle();
      final signUpButton = find.widgetWithText(ElevatedButton, 'Sign Up');
      expect(signUpButton, findsOneWidget);
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();
      expect(find.byType(SignUpScreen), findsOneWidget);
      expect(find.text('Create Account'), findsOneWidget);
    });

    testWidgets('WelcomeScreen navigation to SignIn works',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const WelcomeScreen()));
      await tester.pumpAndSettle();
      final signInButton = find.widgetWithText(ElevatedButton, 'Sign In');
      expect(signInButton, findsOneWidget);
      await tester.tap(signInButton);
      await tester.pumpAndSettle();
      expect(find.byType(SignInScreen), findsOneWidget);
      expect(find.text('Sign In to Account'), findsOneWidget);
    });

    testWidgets('SignUpScreen form validation works',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const SignUpScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);

      final submitButton = find.widgetWithText(ElevatedButton, 'Sign Up');
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text('Please enter your full name'), findsOneWidget);
      expect(find.text('Please enter a valid email'), findsOneWidget);
      expect(find.text('Password must be at least 6 characters'),
          findsNWidgets(2));
    });

    testWidgets('SignInScreen form validation works',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const SignInScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);

      final submitButton = find.widgetWithText(ElevatedButton, 'Sign In');
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email'), findsOneWidget);
      expect(
          find.text('Password must be at least 6 characters'), findsOneWidget);
    });

    testWidgets('ShoppingHomeScreen displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const ShoppingHomeScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Our Products'), findsOneWidget);
      expect(find.text('Hot Offers'), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('App supports Arabic localization',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'),
            Locale('ar'),
          ],
          locale: Locale('ar'),
          home: ShoppingHomeScreen(),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('منتجاتنا'), findsOneWidget);
      expect(find.text('العروض الساخنة'), findsOneWidget);
    });
  });
}
