import 'package:books_application/presentation/screens/books_list.dart';
import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  Headline({Key? key, required this.category, required this.showAll})
      : super(key: key);

  String category;
  String showAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 20, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookList(name: showAll)));
            },
            child: Text(
              "See All",
              style: TextStyle(
                fontFamily: 'Merri',
              ),
            ),
          )
        ],
      ),
    );
  }
}
