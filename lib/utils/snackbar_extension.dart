import 'package:flutter/material.dart';

extension ShowSnackBar on BuildContext {
  void showSnackBar(
      {required String message, Color backgroundColor = Colors.white}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }
}
