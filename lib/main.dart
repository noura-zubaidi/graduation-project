import 'package:books_application/app/constants/constants.dart';
import 'package:books_application/app/notifiers/app_notifiers.dart';
import 'package:books_application/presentation/screens/main_screen.dart';
import 'package:books_application/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://jqlqghozldmspsrxiwes.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpxbHFnaG96bGRtc3Bzcnhpd2VzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY4MDY3NDksImV4cCI6MjAzMjM4Mjc0OX0.qrpMN1BbWUrcn6zYBw3LcWoGNIKhTdavKdR55h5msWQ',
  );

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
        home: MainScreen(),
      ),
    );
  }
}
