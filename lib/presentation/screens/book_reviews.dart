import 'package:books_application/models/reviews_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  final String bookId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ReviewsScreen({required this.bookId});

  Stream<List<Review>> getReviewsForBook(String bookId) {
    return _firestore
        .collection('reviews')
        .where('bookId', isEqualTo: bookId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Review.fromFirestore(doc)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Reviews',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 20),
        child: StreamBuilder<List<Review>>(
          stream: getReviewsForBook(bookId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                  child: Text(
                'No reviews found',
                style: Theme.of(context).textTheme.headlineSmall,
              ));
            } else {
              final reviews = snapshot.data!;
              return ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return ListTile(
                    title: Text(
                      review.comment,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    subtitle: Text(
                      'Rating: ${review.rating.toString()}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
