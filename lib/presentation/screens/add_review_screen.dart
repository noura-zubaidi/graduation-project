import 'package:books_application/app/constants/constants.dart';
import 'package:books_application/services/reviews_service.dart';
import 'package:flutter/material.dart';

class ReviewForm extends StatefulWidget {
  final String bookId; // Book ID passed from the detail screen
  final String userId; // User ID from Firebase Auth

  ReviewForm({required this.bookId, required this.userId});

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  int _rating = 1; // Default rating
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Write a Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Rating stars

                      const SizedBox(height: 16.0),
                      // Comment field
                      TextFormField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          labelText: 'Write your review...',
                          labelStyle: TextStyle(
                            fontFamily: 'Merri',
                            fontSize: 14,
                            color: log2,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your review';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (int i = 1; i <= 5; i++)
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _rating = i;
                                });
                              },
                              icon: Icon(
                                i <= _rating ? Icons.star : Icons.star_border,
                                color:
                                    i <= _rating ? Colors.amber : Colors.grey,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      // Submit button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(200, 50),
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Add the review to Firestore
                            addReview(
                              widget.bookId,
                              widget.userId,
                              _rating,
                              _commentController.text,
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Submit Review',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Merri',
                                fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
