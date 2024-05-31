import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String reviewId;
  final String userId;
  final String bookId;
  final int rating;
  final String comment;
  final Timestamp timestamp;

  Review({
    required this.reviewId,
    required this.userId,
    required this.bookId,
    required this.rating,
    required this.comment,
    required this.timestamp,
  });

  // Factory constructor to create a Review object from Firestore data
  factory Review.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Review(
      reviewId: doc.id,
      userId: data['userId'],
      bookId: data['bookId'],
      rating: data['rating'],
      comment: data['comment'],
      timestamp: data['timestamp'],
    );
  }
}
