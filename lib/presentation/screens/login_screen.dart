import 'dart:developer';

import 'package:books_application/app/constants/constants.dart';
import 'package:books_application/presentation/screens/home_screen.dart';
import 'package:books_application/presentation/screens/main_screen.dart';
import 'package:books_application/presentation/screens/signup_screen.dart';
import 'package:books_application/services/authentication.dart';
import 'package:books_application/utils/constant.dart';
import 'package:books_application/utils/snackbar_extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  GlobalKey<FormState> _formkey = GlobalKey();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  AuthService userService1 = AuthService();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: log1,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 40),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 15),
                  child: Text('Log in',
                      style: TextStyle(
                          color: log2,
                          fontFamily: 'Merri',
                          fontSize: 45,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email Cannot Be Empty';
                              }
                              return null;
                            },
                            controller: _emailController,
                            decoration: InputDecoration(
                                labelText: 'Your Email',
                                labelStyle: TextStyle(
                                  fontFamily: 'Merri',
                                  fontSize: 14,
                                  color: log2,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: log2, width: 1))),
                          )),
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password Cannot Be Empty';
                              }
                              return null;
                            },
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  fontFamily: 'Merri',
                                  fontSize: 14,
                                  color: log2,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: log2, width: 1))),
                          )),
                      const SizedBox(height: 30),
                      ElevatedButton(
                          onPressed: () async {
                            final message = await AuthService().login(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );

                            if (message!.contains('Success')) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),
                              );
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              backgroundColor: log2,
                              fixedSize: const Size(220, 55)),
                          child: Text(
                            'Log In',
                            style: TextStyle(
                                fontFamily: 'Merri', fontSize: 21, color: log3),
                          )),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                          },
                          child: Text('Don\'t Have An Account? Sign Up',
                              style: TextStyle(
                                  color: log2,
                                  fontFamily: 'Merri',
                                  fontSize: 17)),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
