import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _prefs = SharedPreferences.getInstance();
  Future<String?> registration({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      // Store user information in Firestore
      await _firebaseFirestore.collection('users').doc(user?.uid).set({
        'uid': user?.uid,
        'email': email,
        'name': name,
      });

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final prefs = await _prefs;
      await prefs.setBool('isLoggedIn', true);

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> addQuote(String bookId, String quoteText) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final bookQuotesCollection = _firebaseFirestore
            .collection('books')
            .doc(bookId)
            .collection('quotes');
        await bookQuotesCollection.add({
          'quoteText': quoteText,
          'dateAdded': Timestamp.now(),
        });
      } else {
        // Handle the case where the user is not logged in
        print("User is not logged in.");
      }
    } catch (e) {
      print("Error adding quote: ${e.toString()}");
      // Handle error appropriately
    }
  }

  // Get User's Quotes (Stream)
  Stream<QuerySnapshot<Map<String, dynamic>>> getBookQuotes(String bookId) {
    try {
      final bookQuotesCollection = _firebaseFirestore
          .collection('books')
          .doc(bookId)
          .collection('quotes');
      return bookQuotesCollection.snapshots();
    } catch (e) {
      print("Error retrieving quotes: ${e.toString()}");
      // Handle error appropriately
      return Stream.empty();
    }
  }

  Future<Map<String, dynamic>?> getCurrentUserData() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      try {
        final userData =
            await _firebaseFirestore.collection('users').doc(user.uid).get();
        if (userData.exists) {
          return userData.data() as Map<String, dynamic>;
        } else {
          // Handle the case where user data doesn't exist
          print('User data not found in Firestore');
          return null;
        }
      } catch (e) {
        print('Error fetching user data: ${e.toString()}');
        return null;
      }
    } else {
      // Return a user object with null values if not logged in
      return {
        'name': null,
        'email': null,
        'bio': null,
        'image': null,
      };
    }
  }

  Future<String?> editUserData({
    required String name,
    required String email,
    String? bio,
    String? image,
  }) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      try {
        await _firebaseFirestore.collection('users').doc(user.uid).update({
          'name': name,
          'email': email,
          'bio': bio,
          'image': image,
        });
        return 'Success';
      } catch (e) {
        print('Error updating user data: ${e.toString()}');
        return e.toString();
      }
    } else {
      // Handle the case where the user is not logged in
      return 'User is not logged in.';
    }
  }

  Future<void> saveLoginState(bool isLoggedIn) async {
    final prefs = await _prefs;
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  // Check Login State
  Future<bool> isLoggedIn() async {
    final prefs = await _prefs;
    return prefs.getBool('isLoggedIn') ??
        false; // Default to false if not found
  }

  // Logout
  Future<void> logout() async {
    await _firebaseAuth.signOut();
    final prefs = await _prefs;
    await prefs.remove('isLoggedIn'); // Remove the saved login state
  }
}
