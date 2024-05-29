import 'dart:ffi';

import 'package:books_application/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuotesScreen extends StatefulWidget {
  QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  final _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _quoteTextController = TextEditingController();
  final _authorController = TextEditingController();

  @override
  void dispose() {
    _quoteTextController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 20),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _authService.getUserQuotes(), // Get user's quotes
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            final quotes = snapshot.data!.docs;
            return ListView.builder(
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                final quote = quotes[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(
                    quote['quoteText'],
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  subtitle: Text(
                    'By: ${quote['author']}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0XCDBDB07C),
        shape: CircleBorder(),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add New Quote'),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: _quoteTextController,
                        decoration: InputDecoration(labelText: 'Quote Text'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a quote';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _authorController,
                        decoration:
                            InputDecoration(labelText: 'Author (Optional)'),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Add the quote
                        _authService.addQuote(
                          _quoteTextController.text,
                          _authorController.text,
                        );
                        Navigator.of(context).pop(); // Close the dialog
                        _quoteTextController.clear(); // Clear the input fields
                        _authorController.clear();
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
