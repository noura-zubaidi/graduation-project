import 'package:books_application/app/constants/constants.dart';
import 'package:books_application/presentation/screens/main_screen.dart';
import 'package:books_application/services/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:books_application/app/notifiers/app_notifiers.dart';

import 'package:books_application/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authService = AuthService();
  bool isLoggedIn = await authService.isLoggedIn();
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp({required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppNotifier()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: textTheme),
        home: isLoggedIn ? MainScreen() : WelcomeScreen(),
      ),
    );
  }
}
