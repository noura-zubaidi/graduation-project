import 'package:books_application/app/constants/constants.dart';
import 'package:books_application/app/notifiers/app_notifiers.dart';
import 'package:books_application/core/model/Books.dart';
import 'package:books_application/presentation/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  final _random = math.Random();
  String errorLink =
      "https://img.freepik.com/free-vector/funny-error-404-background-design_1167-219.jpg?w=740&t=st=1658904599~exp=1658905199~hmac=131d690585e96267bbc45ca0978a85a2f256c7354ce0f18461cd030c5968011c";
  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (context, value, child) {
        return FutureBuilder(
          future: value.searchBookData(searchBook: query),
          builder: (context, AsyncSnapshot<Books> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Opps! Try again later!"),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.items?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                    id: snapshot.data?.items?[index].id,
                                    boxColor: AppColors.beige,
                                  )));
                    },
                    leading: Image.network(
                        "${snapshot.data?.items?[index].volumeInfo?.imageLinks?.thumbnail ?? errorLink}"),
                    title: Text(
                      "${snapshot.data?.items![index].volumeInfo!.authors?.length != 0 ? snapshot.data?.items![index].volumeInfo!.authors![0] : "Not Found"}",
                    ),
                    subtitle: Text(
                      "${snapshot.data?.items![index].volumeInfo?.title}",
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.black,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (context, value, child) {
        return FutureBuilder(
          future: value.searchBookData(searchBook: "Biography"),
          builder: (context, AsyncSnapshot<Books> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Opps! Try again later!"),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                      id: snapshot.data?.items?[index].id,
                                      boxColor: AppColors.beige,
                                    )));
                      },
                      leading: Image.network(
                          "${snapshot.data?.items?[index].volumeInfo?.imageLinks?.thumbnail ?? errorLink}"),
                      title: Text(
                        "${snapshot.data?.items![index].volumeInfo!.authors?.length != 0 ? snapshot.data?.items![index].volumeInfo!.authors![0] : "Not Found"}",
                      ),
                      subtitle: Text(
                          "${snapshot.data?.items![index].volumeInfo?.title}"));
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.black,
              ),
            );
          },
        );
      },
    );
  }
}
