import 'package:books_application/app/constants/constants.dart';
import 'package:books_application/presentation/screens/books_list.dart';
import 'package:books_application/presentation/screens/search_screen.dart';
import 'package:books_application/presentation/widgets/books/adventure_books.dart';
import 'package:books_application/presentation/widgets/books/anime_books.dart';
import 'package:books_application/presentation/widgets/books/horror.dart';
import 'package:books_application/presentation/widgets/books/novel.dart';
import 'package:books_application/presentation/widgets/books/popular_books.dart';
import 'package:books_application/presentation/widgets/headline.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final TextEditingController searchController = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: height / 1.9,
              child: Stack(
                children: [
                  Container(
                    height: height / 2.1,
                    decoration: BoxDecoration(
                      color: AppColors.beige,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: SafeArea(
                      minimum: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Text("Book Store",
                              style: Theme.of(context).textTheme.headlineSmall),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              showSearch(
                                  context: context,
                                  delegate: CustomSearchDelegate());
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              height: 50,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 1, color: AppColors.black),
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Search for Books"),
                                  Icon(Icons.search),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(
                            flex: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Most Popular',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BookList(name: "Fiction")));
                                },
                                child: Text(
                                  "See All",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              )
                            ],
                          ),
                          const Spacer(
                            flex: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: height / 5.3,
                      //height: constraints.maxHeight * 0.38,
                      margin: const EdgeInsets.only(left: 16),
                      child: const PopularBooks(),
                    ),
                  ),
                ],
              ),
            ),
            Headline(
              category: "Anime",
              showAll: "Anime",
            ),
            SizedBox(
              //color: Colors.grey.shade100,
              height: height / 3.4,
              child: const AnimeBooks(),
            ),
            Headline(
              category: "Adventure",
              showAll: "Adventure",
            ),
            SizedBox(
              //color: Colors.yellow,
              height: height / 3.4,
              child: const AdevntureBooks(),
            ),
            Headline(
              category: "Novel",
              showAll: "Novel",
            ),
            SizedBox(
              //color: Colors.yellow,
              height: height / 3.4,
              child: const NovelBooks(),
            ),
            Headline(
              category: "Horror",
              showAll: "Horror",
            ),
            SizedBox(
              //color: Colors.yellow,
              height: height / 3.4,
              child: const HorrorBooks(),
            ),
          ],
        ),
      ),
    );
  }
}
