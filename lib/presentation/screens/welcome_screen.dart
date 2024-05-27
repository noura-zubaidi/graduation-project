import 'package:books_application/app/constants/constants.dart';
import 'package:books_application/presentation/screens/login_screen.dart';
import 'package:books_application/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: wlc1,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset('assets/images/book.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text('BOOK HIVE',
                  style: TextStyle(
                      color: wlc2, fontFamily: 'Merri', fontSize: 45)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: wlc2,
                    fixedSize: const Size(220, 50)),
                child: const Text(
                  'Log In',
                  style: TextStyle(
                      fontFamily: 'Merri', fontSize: 18, color: Colors.black),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: wlc2,
                    fixedSize: const Size(220, 50)),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontFamily: 'Merri', fontSize: 18, color: Colors.black),
                )),
          ],
        ),
      ),
    );
  }
}
