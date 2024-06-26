import 'dart:collection';

import 'package:books_application/app/constants/constants.dart';

import 'package:books_application/presentation/screens/login_screen.dart';
import 'package:books_application/presentation/screens/main_screen.dart';
import 'package:books_application/services/authentication.dart';
import 'package:books_application/utils/constant.dart';
import 'package:books_application/utils/snackbar_extension.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isLoading = false;
  GlobalKey<FormState> _formkey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  HashMap userMap = HashMap();
  AuthService userService1 = AuthService();

  @override
  void initState() {
    super.initState();
    _emailController;
    _passwordController;
    _nameController;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 15),
                child: Text('Sign Up',
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
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username Cannot Be Empty';
                              }
                              final isValid = RegExp(r'^[A-Za-z0-9_]{3,24}$')
                                  .hasMatch(value);
                              if (!isValid) {
                                return '3-24 long with alphanumeric or underscore';
                              }
                              return null;
                            },
                            controller: _nameController,
                            decoration: InputDecoration(
                                labelText: 'Username',
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
                                return 'Email Cannot Be Empty';
                              }
                              return null;
                            },
                            controller: _emailController,
                            decoration: InputDecoration(
                                labelText: 'Email',
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
                              if (value.length < 6) {
                                return 'Password Length Must Be 6 Characters Or More';
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
                            final message = await AuthService().registration(
                              name: _nameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            if (message!.contains('Success')) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
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
                            'Sign Up',
                            style: TextStyle(
                                fontFamily: 'Merri', fontSize: 21, color: log3),
                          )),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                          },
                          child: Text('Already Have An Account? Log In',
                              style: TextStyle(
                                  color: log2,
                                  fontFamily: 'Merri',
                                  fontSize: 17)),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
