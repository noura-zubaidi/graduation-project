import 'package:books_application/app/constants/constants.dart';
import 'package:books_application/app/notifiers/app_notifiers.dart';
import 'package:books_application/core/model/Books.dart';
import 'package:books_application/presentation/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class BookList extends StatelessWidget {
  BookList({Key? key, required this.name}) : super(key: key);

  final String name;
  final _random = math.Random();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 815;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColors.black),
        title: Text(
          name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Consumer<AppNotifier>(
        builder: (context, value, child) {
          return FutureBuilder<Books>(
            future: value.searchBookData(searchBook: name),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Oops! Try again later!"),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.black,
                  ),
                );
              }
              if (!snapshot.hasData ||
                  snapshot.data?.items == null ||
                  snapshot.data!.items!.isEmpty) {
                return const Center(
                  child: Text("No data found!"),
                );
              }

              final books = snapshot.data!.items!;
              return GridView.builder(
                itemCount: books.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 260,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemBuilder: (context, index) {
                  if (index >= books.length) {
                    return const SizedBox.shrink();
                  }

                  final book = books[index];
                  final imageUrl = book.volumeInfo?.imageLinks?.thumbnail ?? '';

                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              id: book.id,
                              boxColor: boxColors[_random.nextInt(5)],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: constraints.maxHeight / 2,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Container(
                                      height: constraints.maxHeight / 2.5,
                                      decoration: BoxDecoration(
                                        color: boxColors[_random.nextInt(5)],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      child: Card(
                                        margin: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: SizedBox(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: imageUrl.isNotEmpty
                                                ? Image.network(
                                                    imageUrl,
                                                    height:
                                                        constraints.maxHeight /
                                                            2,
                                                    width:
                                                        constraints.maxWidth /
                                                            2,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.network(
                                                    'https://www.closeencounters.co.uk/38463-large_default/snow-white-with-the-red-hair-volume-16.jpg',
                                                    height:
                                                        constraints.maxHeight /
                                                            2,
                                                    width:
                                                        constraints.maxWidth /
                                                            2,
                                                    fit: BoxFit.fill,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        book.volumeInfo?.authors?.isNotEmpty ??
                                                false
                                            ? book.volumeInfo!.authors![0]
                                            : "Not Found",
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4
                                            ?.copyWith(
                                              fontSize:
                                                  constraints.maxWidth * 0.09,
                                            ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        book.volumeInfo?.title ?? '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                              fontSize:
                                                  constraints.maxWidth * 0.09,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                        child: Container(
                                      height: 30,
                                      width: 70,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ))
                                  ],
                                ),
                              )
                            ],
                          );
                        }),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
