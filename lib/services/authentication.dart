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

  Future<void> addQuote(String quoteText, String author) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final userQuotesCollection = _firebaseFirestore
            .collection('quotes')
            .doc(user.uid)
            .collection('quotes');
        await userQuotesCollection.add({
          'quoteText': quoteText,
          'author': author,
          'dateAdded': Timestamp.now(),
        });
      } else {
        // Handle the case where the user is not logged in
      }
    } catch (e) {
      print("Error adding quote: ${e.toString()}");
      // Handle error appropriately
    }
  }

  // Get User's Quotes (Stream)
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserQuotes() {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      final userQuotesCollection = _firebaseFirestore
          .collection('quotes')
          .doc(user.uid)
          .collection('quotes');
      return userQuotesCollection.snapshots();
    } else {
      // Handle the case where the user is not logged in
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
      // Handle the case where the user is not logged in
      return null;
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
    await saveLoginState(false);
  }
}
