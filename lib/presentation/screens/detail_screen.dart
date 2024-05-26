import 'package:books_application/app/constants/constants.dart';
import 'package:books_application/app/notifiers/app_notifiers.dart';
import 'package:books_application/core/model/DetailModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:readmore/readmore.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key? key, required this.id, this.boxColor}) : super(key: key);

  var id;
  final Color? boxColor;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 815;
    double width = MediaQuery.of(context).size.width / 375;

    return Scaffold(
      body: Consumer<AppNotifier>(
        builder: ((context, value, child) {
          return widget.id != null
              ? FutureBuilder(
                  future: value.showBookData(id: widget.id),
                  builder: (context, AsyncSnapshot<DetailModel> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Opps! Try again later!"),
                      );
                    }
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 350,
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.maxFinite,
                                    height: height * 200,
                                    decoration: BoxDecoration(
                                      color: widget.boxColor ??
                                          const Color(0xffa8704e),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(35),
                                        bottomRight: Radius.circular(35),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      height: height * 250,
                                      alignment: Alignment.center,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image(
                                          image: NetworkImage(
                                              "${snapshot.data?.volumeInfo?.imageLinks?.thumbnail}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 70,
                                    left: 16,
                                    child: OutlinedButton.icon(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: OutlinedButton.styleFrom(
                                          side: const BorderSide(width: 1)),
                                      icon: Icon(
                                        Icons.arrow_back_ios_new,
                                        color: AppColors.black,
                                      ),
                                      label: const Text(
                                        "",
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "${snapshot.data?.volumeInfo?.title ?? "Censored"}",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(fontSize: 24),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${snapshot.data?.volumeInfo!.authors?.isNotEmpty ?? false ? snapshot.data?.volumeInfo!.authors![0] : "Censored"}"
                                        .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 35),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${snapshot.data?.volumeInfo?.printType}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ),
                                        const Spacer(),
                                        Text(
                                          "${snapshot.data?.volumeInfo?.pageCount} \$",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ),
                                        const Spacer(),
                                        Text(
                                          "${snapshot.data?.volumeInfo?.pageCount} Pages",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {
                                          //this button takes me to add review page
                                          //the review should be stored in the review history page and in firestore along with
                                          //book id and book name
                                        },
                                        style: OutlinedButton.styleFrom(
                                            side: const BorderSide(width: 1)),
                                        child: Text(
                                          "ADD REVIEW",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                            side: const BorderSide(width: 1)),
                                        child: Text(
                                          "WANT TO READ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Details",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Author",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium,
                                            ),
                                            Text("Publisher",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium),
                                            Text("Published Date",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium),
                                            Text("Categorie",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium)
                                          ],
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${snapshot.data?.volumeInfo?.authors?[0]}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium
                                                    ?.copyWith(fontSize: 16),
                                              ),
                                              Text(
                                                "${snapshot.data?.volumeInfo?.publisher}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium
                                                    ?.copyWith(fontSize: 16),
                                              ),
                                              Text(
                                                "${snapshot.data?.volumeInfo?.publishedDate}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium
                                                    ?.copyWith(fontSize: 16),
                                              ),
                                              Text(
                                                "${snapshot.data?.volumeInfo?.categories?[0]}",
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium
                                                    ?.copyWith(fontSize: 16),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Description",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ReadMoreText(
                                    "${snapshot.data?.volumeInfo?.description}",
                                    trimLines: 6,
                                    colorClickableText: AppColors.black,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: '...Read More',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(fontSize: 16),
                                    trimExpandedText: ' ...Read Less',
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black),
                                    onPressed: () async {
                                      final infoLink =
                                          snapshot.data?.volumeInfo?.infoLink;
                                      if (infoLink != null &&
                                          infoLink.isNotEmpty) {
                                        Uri url = Uri.parse(infoLink);
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url,
                                              mode: LaunchMode
                                                  .externalApplication);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'Could not launch $url')),
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Info link is not available')),
                                        );
                                      }
                                    },
                                    child: Text(
                                      'More Info',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              : const Center(
                  child: Text("Book ID is null!"),
                );
        }),
      ),
    );
  }
}
