import 'package:books_application/models/reviews_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Add a new review (assuming you have the review data)
Future<void> addReview(
    String bookId, String userId, int rating, String comment) async {
  try {
    await _firestore.collection('reviews').add({
      'userId': userId,
      'bookId': bookId,
      'rating': rating,
      'comment': comment,
      'timestamp': FieldValue.serverTimestamp(),
    });
  } catch (e) {
    print('Error adding review: $e');
  }
}

// Get reviews for a specific book
Stream<List<Review>> getReviewsForBook(String bookId) {
  return _firestore
      .collection('reviews')
      .where('bookId', isEqualTo: bookId)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Review.fromFirestore(doc)).toList());
}
