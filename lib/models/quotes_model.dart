import 'package:cloud_firestore/cloud_firestore.dart';

class Quote {
  String? quoteText;
  String? author;
  Timestamp? dateAdded;

  Quote({this.quoteText, this.author, this.dateAdded});

  Map<String, dynamic> toMap() {
    return {
      'quoteText': quoteText,
      'author': author,
      'dateAdded': dateAdded,
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      quoteText: map['quoteText'],
      author: map['author'],
      dateAdded: map['dateAdded'],
    );
  }
}
