import 'dart:ffi';

import 'package:books_application/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuotesScreen extends StatefulWidget {
  final String bookId;

  QuotesScreen({super.key, required this.bookId});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  final _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _quoteTextController = TextEditingController();

  @override
  void dispose() {
    _quoteTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 40, bottom: 20),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream:
              _authService.getBookQuotes(widget.bookId), // Get book's quotes
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
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        quote['quoteText'],
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                contentTextStyle: TextStyle(
                  fontFamily: 'Merri',
                ),
                title: const Text(
                  textAlign: TextAlign.center,
                  'Add New Quote',
                ),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _quoteTextController,
                        decoration: InputDecoration(
                          labelText: 'Quote Text',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a quote';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child:
                        Text('Cancel', style: TextStyle(color: Colors.black)),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Add the quote
                        _authService.addQuote(
                            widget.bookId, _quoteTextController.text);
                        Navigator.of(context).pop(); // Close the dialog
                        _quoteTextController.clear(); // Clear the input fields
                      }
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.black),
                    ),
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
