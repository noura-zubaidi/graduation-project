import 'package:books_application/app/constants/constants.dart';
import 'package:books_application/app/notifiers/app_notifiers.dart';
import 'package:books_application/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppNotifier()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: textTheme),
        home: const MainScreen(),
      ),
    );
  }
}
